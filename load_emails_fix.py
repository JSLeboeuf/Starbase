#!/usr/bin/env python3
"""
Script pour charger TOUS les emails - version corrigée sans date
"""

import re
import os
from supabase import create_client, Client

SUPABASE_URL = "https://yixgiabpoeoixxqdgyrs.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlpeGdpYWJwb2VvaXh4cWRneXJzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NjI5NTEwOCwiZXhwIjoyMDgxODcxMTA4fQ.MAhUezdbj6ebbvsKp6HV99rlirGM5ZYDN9r5L1hy7SI"

EMAIL_FILES = [
    ("JEROME-TOUS-EMAILS-COMPLET.txt", "jerome"),
    ("FELIX-TOUS-EMAILS.txt", "felix"),
    ("CEDRIC-TOUS-EMAILS.txt", "cedric"),
]

def parse_email_file(filepath: str, contact_type: str) -> list:
    emails = []
    
    with open(filepath, 'r', encoding='utf-8-sig') as f:
        content = f.read()
    
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
            'date_sent': None,  # On ne met PAS de date pour éviter les erreurs
            'has_attachments': False,
            'attachments': [],
            'raw_content': block.strip()[:10000]
        }
        
        lines = block.strip().split('\n')
        body_start = False
        body_lines = []
        date_str = None
        
        for line in lines:
            if line.startswith('DATE:'):
                date_str = line[5:].strip()
                # Garder la date brute comme texte dans raw_content
                    
            elif line.startswith('FROM:'):
                from_str = line[5:].strip()
                match = re.search(r'([^<]+)?<?([^>]+@[^>]+)>?', from_str)
                if match:
                    email_data['from_name'] = match.group(1).strip() if match.group(1) else None
                    email_data['from_email'] = match.group(2).strip()
                else:
                    email_data['from_email'] = from_str
                    
            elif line.startswith('TO:'):
                to_str = line[3:].strip()
                to_emails = re.findall(r'[\w\.-]+@[\w\.-]+', to_str)
                email_data['to_emails'] = to_emails[:10]
                
            elif line.startswith('CC:'):
                cc_str = line[3:].strip()
                cc_emails = re.findall(r'[\w\.-]+@[\w\.-]+', cc_str)
                email_data['cc_emails'] = cc_emails[:10]
                
            elif line.startswith('SUBJECT:'):
                email_data['subject'] = line[8:].strip()[:500]
                
            elif line.startswith('PIECES JOINTES:'):
                attachments = line[15:].strip().split(', ')
                email_data['attachments'] = [a.strip() for a in attachments if a.strip()][:10]
                email_data['has_attachments'] = len(email_data['attachments']) > 0
                
            elif line.startswith('-' * 10):
                body_start = True
                
            elif body_start:
                body_lines.append(line)
        
        email_data['body'] = '\n'.join(body_lines)[:5000]
        
        # Ajouter la date comme tag si présente
        if date_str:
            email_data['tags'] = [f"date:{date_str[:30]}"]
        
        if email_data['from_email']:
            emails.append(email_data)
    
    return emails

def determine_importance(email: dict) -> str:
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
    print("CHARGEMENT COMPLET - SANS CONTRAINTE DE DATE")
    print("=" * 60)
    
    supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
    
    # Vider la table pour recharger tout
    print("\n🗑️ Vidage de la table emails...")
    supabase.table('emails').delete().neq('id', 0).execute()
    print("✅ Table vidée")
    
    total_loaded = 0
    
    for filename, contact_type in EMAIL_FILES:
        filepath = os.path.join(os.path.dirname(__file__), filename)
        
        if not os.path.exists(filepath):
            print(f"\n❌ Fichier non trouvé: {filepath}")
            continue
        
        print(f"\n📧 Traitement de {filename}...")
        emails = parse_email_file(filepath, contact_type)
        print(f"   → {len(emails)} emails parsés")
        
        batch_size = 50
        inserted = 0
        errors = 0
        
        for i in range(0, len(emails), batch_size):
            batch = emails[i:i+batch_size]
            
            for email in batch:
                email['importance'] = determine_importance(email)
            
            try:
                result = supabase.table('emails').insert(batch).execute()
                inserted += len(batch)
                if (i // batch_size) % 10 == 0:
                    print(f"   → {inserted}/{len(emails)} emails insérés...")
            except Exception as e:
                errors += 1
                # Essayer un par un si le batch échoue
                for single in batch:
                    try:
                        supabase.table('emails').insert(single).execute()
                        inserted += 1
                    except:
                        pass
        
        total_loaded += inserted
        print(f"   ✅ {inserted}/{len(emails)} emails chargés pour {contact_type}")
    
    print("\n" + "=" * 60)
    print(f"✅ TOTAL: {total_loaded} emails chargés dans Supabase")
    print("=" * 60)

if __name__ == "__main__":
    main()


