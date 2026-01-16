#!/usr/bin/env python3
"""
Script pour charger tous les emails dans Supabase
Projet JEROME - Bataille juridique
"""

import re
import os
from datetime import datetime
from supabase import create_client, Client

# Configuration Supabase
SUPABASE_URL = "https://yixgiabpoeoixxqdgyrs.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlpeGdpYWJwb2VvaXh4cWRneXJzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NjI5NTEwOCwiZXhwIjoyMDgxODcxMTA4fQ.MAhUezdbj6ebbvsKp6HV99rlirGM5ZYDN9r5L1hy7SI"

# Fichiers à traiter
EMAIL_FILES = [
    ("JEROME-TOUS-EMAILS-COMPLET.txt", "jerome"),
    ("FELIX-TOUS-EMAILS.txt", "felix"),
    ("CEDRIC-TOUS-EMAILS.txt", "cedric"),
]

def parse_email_file(filepath: str, contact_type: str) -> list:
    """Parse un fichier d'emails et retourne une liste de dictionnaires."""
    emails = []
    
    with open(filepath, 'r', encoding='utf-8-sig') as f:
        content = f.read()
    
    # Séparer les emails par le délimiteur
    email_blocks = content.split('=' * 60)
    
    for block in email_blocks:
        if not block.strip() or 'DATE:' not in block:
            continue
            
        email_data = {
            'contact_type': contact_type,
            'from_email': None,
            'from_name': None,
            'to_emails': [],
            'cc_emails': [],
            'subject': None,
            'body': None,
            'date_sent': None,
            'has_attachments': False,
            'attachments': [],
            'raw_content': block.strip()[:10000]  # Limiter la taille
        }
        
        lines = block.strip().split('\n')
        body_start = False
        body_lines = []
        
        for i, line in enumerate(lines):
            if line.startswith('DATE:'):
                date_str = line[5:].strip()
                try:
                    # Parser différents formats de date
                    email_data['date_sent'] = date_str
                except:
                    pass
                    
            elif line.startswith('FROM:'):
                from_str = line[5:].strip()
                # Extraire nom et email
                match = re.search(r'([^<]+)?<?([^>]+@[^>]+)>?', from_str)
                if match:
                    email_data['from_name'] = match.group(1).strip() if match.group(1) else None
                    email_data['from_email'] = match.group(2).strip()
                else:
                    email_data['from_email'] = from_str
                    
            elif line.startswith('TO:'):
                to_str = line[3:].strip()
                # Extraire tous les emails
                to_emails = re.findall(r'[\w\.-]+@[\w\.-]+', to_str)
                email_data['to_emails'] = to_emails[:10]  # Limiter à 10
                
            elif line.startswith('CC:'):
                cc_str = line[3:].strip()
                cc_emails = re.findall(r'[\w\.-]+@[\w\.-]+', cc_str)
                email_data['cc_emails'] = cc_emails[:10]
                
            elif line.startswith('SUBJECT:'):
                email_data['subject'] = line[8:].strip()[:500]  # Limiter
                
            elif line.startswith('PIECES JOINTES:'):
                attachments = line[15:].strip().split(', ')
                email_data['attachments'] = [a.strip() for a in attachments if a.strip()][:10]
                email_data['has_attachments'] = len(email_data['attachments']) > 0
                
            elif line.startswith('-' * 10):
                body_start = True
                
            elif body_start:
                body_lines.append(line)
        
        email_data['body'] = '\n'.join(body_lines)[:5000]  # Limiter le body
        
        if email_data['from_email']:
            emails.append(email_data)
    
    return emails

def determine_importance(email: dict) -> str:
    """Détermine l'importance d'un email basé sur le contenu."""
    keywords_critical = ['switch', 'convention', 'cea', 'cautionnement', 'oppression']
    keywords_high = ['actionnaire', 'actions', 'financement', 'bnc', 'notaire']
    
    text = f"{email.get('subject', '')} {email.get('body', '')}".lower()
    
    for kw in keywords_critical:
        if kw in text:
            return 'critical'
    
    for kw in keywords_high:
        if kw in text:
            return 'high'
    
    return 'medium'

def main():
    print("=" * 60)
    print("CHARGEMENT DES EMAILS DANS SUPABASE - PROJET JEROME")
    print("=" * 60)
    
    # Connexion Supabase
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
    print(f"\n✅ Connecté à Supabase: {SUPABASE_URL}")
    
    total_loaded = 0
    
    for filename, contact_type in EMAIL_FILES:
        filepath = os.path.join(os.path.dirname(__file__), filename)
        
        if not os.path.exists(filepath):
            print(f"\n❌ Fichier non trouvé: {filepath}")
            continue
        
        print(f"\n📧 Traitement de {filename}...")
        emails = parse_email_file(filepath, contact_type)
        print(f"   → {len(emails)} emails parsés")
        
        # Insérer par batch de 100
        batch_size = 100
        inserted = 0
        
        for i in range(0, len(emails), batch_size):
            batch = emails[i:i+batch_size]
            
            # Préparer les données pour insertion
            for email in batch:
                email['importance'] = determine_importance(email)
            
            try:
                result = supabase.table('emails').insert(batch).execute()
                inserted += len(batch)
                print(f"   → Batch {i//batch_size + 1}: {len(batch)} emails insérés ({inserted}/{len(emails)})")
            except Exception as e:
                print(f"   ❌ Erreur batch {i//batch_size + 1}: {str(e)[:100]}")
        
        total_loaded += inserted
        print(f"   ✅ {inserted} emails chargés pour {contact_type}")
    
    print("\n" + "=" * 60)
    print(f"✅ TOTAL: {total_loaded} emails chargés dans Supabase")
    print("=" * 60)
    
    # Vérification finale
    result = supabase.table('emails').select('contact_type', count='exact').execute()
    print(f"\n📊 Vérification: {result.count} emails dans la base")

if __name__ == "__main__":
    main()


