# 🚀 MAXIMISER LA PERFORMANCE CURSOR + CODEX
## Projet JEROME - Extraction Vérité & Prise de Décisions Optimales
**Date:** 21 décembre 2025

---

## 📋 RÉSUMÉ EXÉCUTIF

Ce document compile les meilleures pratiques, outils, et configurations pour maximiser:
1. **Extraction de preuves** depuis emails/documents
2. **Analyse juridique** du conflit actionnaires
3. **Prise de décisions** avec frameworks BATNA/Game Theory
4. **Performance Cursor** en mode Agent

---

## 🔧 PARTIE 1: CONFIGURATION CURSOR OPTIMALE

### 1.1 Mode Agent (Cursor 2.0+)

**Activer le mode Agent-first:**
- Toggle via bouton "Agents" en haut à gauche
- Permet jusqu'à **8 agents en parallèle**
- Chaque agent travaille dans un **Git worktree isolé**

**Fonctionnalités clés à utiliser:**

| Fonctionnalité | Usage Projet JEROME |
|----------------|---------------------|
| **Multi-agents parallèles** | Extraire emails + Analyser preuves + Recherche juridique simultanément |
| **Sandboxed Terminals** | Exécuter scripts d'extraction sécurisés |
| **Browser Integration** | Scraper REQ Québec pour données compagnies |
| **Plan Mode** | Stratégies multi-étapes (extraction → analyse → rapport) |
| **Composer Model** | Éditions multi-fichiers rapides |

### 1.2 MCPs Optimaux pour le Projet

```json
{
  "mcpServers": {
    "supabase-jerome": { "project": "yixgiabpoeoixxqdgyrs" },
    "supabase-nexus": { "project": "phiduqxcufdmgjvdipyu" },
    "gmail-jsleboeuf": { "account": "jsleboeuf3" },
    "perplexity": { "models": ["search", "reason", "deep_research"] },
    "github": { "backup": true },
    "tavily": { "web_search": true },
    "context7": { "docs": true }
  }
}
```

### 1.3 MCPs Additionnels Recommandés

| MCP | Installation | Usage Projet |
|-----|--------------|--------------|
| **Box MCP** | `@box/mcp-server` | Analyse contrats/PDF avec permissions |
| **Notion MCP** | `@notionhq/notion-mcp-server` | Organisation preuves en base de données |
| **Playwright MCP** | `@playwright/mcp@latest` | Scraping REQ, sites juridiques |

---

## 🤖 PARTIE 2: SKILLS CODEX RECOMMANDÉS

### 2.1 Skill: Analyse Conflits Actionnaires

**Créer:** `~/.codex/skills/shareholder-disputes/SKILL.md`

```markdown
---
name: shareholder-dispute-analysis
description: Analyse juridique des conflits actionnaires Québec (LSAQ)
---

Tu es un assistant spécialisé en **conflits actionnaires** au Québec.

## Comportement
1. Demander: (1) juridiction, (2) type société, (3) stade procédural
2. Identifier: parties, timeline, enjeux juridiques
3. Analyser: oppression (art. 450-453 LSAQ), attentes raisonnables, bonne foi

## Structure de sortie
1. Faits (bullets)
2. Enjeux juridiques
3. Standards applicables (LSAQ/LCSA)
4. Application aux faits
5. Options et risques

## Contraintes
- Ne PAS donner conseil juridique définitif
- Utiliser langage: "un tribunal considérerait..."
- Inclure disclaimer: pas un avocat, pas un avis juridique

## Jurisprudence clé Québec
- BCE Inc. v. 1976 Debentureholders (CSC)
- Quigley v. Placements Banque Nationale (QCCA 2018)
```

### 2.2 Skill: Extraction Documents Juridiques

**Créer:** `~/.codex/skills/legal-extraction/SKILL.md`

```markdown
---
name: legal-document-extraction
description: Extraction structurée de parties, dates, montants, clauses
---

Tu es un **moteur d'extraction juridique**.

## Schéma JSON de sortie
{
  "document_type": "string",
  "parties": [{"name": "string", "role": "string"}],
  "dates": {"effective": "string", "execution": "string"},
  "financials": {"amounts": [], "currency": "string"},
  "key_clauses": [{"label": "string", "summary": "string"}],
  "extraction_notes": "string"
}

## Instructions
- Préserver le sens original
- Si doute, mettre null + note
- Sortie JSON uniquement
```

### 2.3 Skill: Analyse BATNA & Négociation

**Créer:** `~/.codex/skills/batna-negotiation/SKILL.md`

```markdown
---
name: batna-negotiation-analysis
description: Analyse BATNA et stratégie de négociation actionnaires
---

Tu es un **stratège de négociation** spécialisé en conflits corporatifs.

## Framework BATNA
1. Identifier meilleure alternative à l'accord négocié
2. Évaluer ZOPA (Zone of Possible Agreement)
3. Analyser BATNA de la contrepartie
4. Recommander tactiques

## Structure d'analyse
1. Position actuelle (forces/faiblesses)
2. BATNA de chaque partie
3. ZOPA estimé
4. Tactiques recommandées
5. Scénarios de sortie

## Game Theory
- Identifier jeux à somme nulle vs coopératifs
- Analyser équilibres de Nash possibles
- Recommander stratégies dominantes
```

---

## 📊 PARTIE 3: OUTILS & REPOS GITHUB

### 3.1 Repos Open Source Recommandés

| Repo | Usage | URL |
|------|-------|-----|
| **OLAW (Harvard LIL)** | RAG juridique avec outils | github.com/harvard-lil/olaw |
| **Ally (Microsoft)** | Analyse contrats Azure OpenAI | github.com/Azure-Samples/ally-legal-assistant |
| **LegalBench** | Benchmark tâches juridiques LLM | github.com/HazyResearch/legalbench |
| **Legal-AI-PILOT** | Prédiction issues juridiques | github.com/zzlang-c/Legal-AI-PILOT |
| **LLM-and-Law** | Collection papers/code LLM+Droit | github.com/Jeryi-Sun/LLM-and-Law |

### 3.2 Script Python: Extraction Gmail Pièces Jointes

```python
# extract_gmail_attachments.py
# Extraction batch des pièces jointes Gmail pour découverte juridique

from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
import base64
import os

def extract_attachments(query, output_dir):
    """
    Extraire toutes les pièces jointes correspondant à une requête Gmail.
    
    Args:
        query: Requête Gmail (ex: "from:nicolas.marois@notavo.ca has:attachment")
        output_dir: Dossier de sortie
    """
    creds = Credentials.from_authorized_user_file('token.json')
    service = build('gmail', 'v1', credentials=creds)
    
    # Rechercher les messages
    results = service.users().messages().list(
        userId='me', 
        q=query,
        maxResults=500
    ).execute()
    
    messages = results.get('messages', [])
    print(f"Trouvé {len(messages)} emails avec pièces jointes")
    
    os.makedirs(output_dir, exist_ok=True)
    
    for msg in messages:
        msg_data = service.users().messages().get(
            userId='me', 
            id=msg['id'],
            format='full'
        ).execute()
        
        # Extraire métadonnées
        headers = {h['name']: h['value'] for h in msg_data['payload'].get('headers', [])}
        date = headers.get('Date', 'unknown')
        subject = headers.get('Subject', 'no-subject')
        
        # Parcourir les parties pour trouver les pièces jointes
        parts = msg_data['payload'].get('parts', [])
        for part in parts:
            if part.get('filename'):
                attachment_id = part['body'].get('attachmentId')
                if attachment_id:
                    attachment = service.users().messages().attachments().get(
                        userId='me',
                        messageId=msg['id'],
                        id=attachment_id
                    ).execute()
                    
                    # Décoder et sauvegarder
                    data = base64.urlsafe_b64decode(attachment['data'])
                    filename = f"{date[:10]}_{subject[:30]}_{part['filename']}"
                    filename = "".join(c for c in filename if c.isalnum() or c in '._-')
                    
                    filepath = os.path.join(output_dir, filename)
                    with open(filepath, 'wb') as f:
                        f.write(data)
                    print(f"Sauvegardé: {filename}")

# Exemple d'utilisation
if __name__ == "__main__":
    # Extraire toutes les PJ de Nicolas Marois (notaire)
    extract_attachments(
        query="from:nicolas.marois@notavo.ca has:attachment",
        output_dir="./NICOLAS-MAROIS-PIECES-JOINTES"
    )
    
    # Extraire toutes les PJ de Jérôme
    extract_attachments(
        query="from:jlevac@mkmg.ca has:attachment",
        output_dir="./JEROME-PIECES-JOINTES"
    )
```

---

## ⚖️ PARTIE 4: STRATÉGIE JURIDIQUE QUÉBEC

### 4.1 Recours en Oppression (Art. 450-453 LSAQ)

**Test en deux étapes (BCE Inc.):**
1. Quelles étaient les **attentes raisonnables** du demandeur?
2. La conduite contestée **frustre-t-elle** ces attentes de façon oppressive?

**Critères remplis dans le projet JEROME:**

| Critère | Preuve | Force |
|---------|--------|-------|
| Traitement inégal | Switch à JS, pas Félix | 🔴 FORTE |
| Attentes frustrées | CEA jamais signée (9 mois) | 🔴 FORTE |
| Abus de pouvoir | Félix dicte au notaire | 🔴 FORTE |
| Mauvaise foi | Cautionnements discriminatoires | 🔴 FORTE |
| Préjudice | ~1.8M$ en jeu | 🔴 FORTE |

### 4.2 Jurisprudence Clé à Connaître

| Cas | Principe | Application |
|-----|----------|-------------|
| **BCE Inc. v. 1976 Debentureholders (CSC)** | Test attentes raisonnables | Fondement de l'analyse |
| **Quigley v. Placements BN (QCCA 2018)** | Contrat > oppression | Si CEA signée, limite recours |
| **QCCA Nov 2023** | Rejet réclamations faibles | Attentes doivent être objectives |

### 4.3 Stratégies Recommandées

**Pour minoritaire (Jean-Samuel):**
1. ✅ Documenter attentes raisonnables (emails, conduite passée)
2. ✅ Aligner théorie oppression avec contrats existants
3. ✅ Demander remèdes proportionnels (rachat, rectification)
4. ✅ Utiliser mesures provisoires si risque de dilution

**Remèdes à demander:**
- Rachat forcé des parts à juste valeur (sans décote minoritaire)
- Rectification du registre des actionnaires
- Changements de gouvernance (droits d'information, siège au CA)

---

## 🎯 PARTIE 5: FRAMEWORK DÉCISIONNEL

### 5.1 Analyse BATNA - Projet JEROME

| Partie | BATNA | Force |
|--------|-------|-------|
| **Jean-Samuel** | Embaucher chargé de projet (700k$/5 ans) | 🟢 FORTE |
| **Jérôme** | Quitter sans équité (perd 6% sur tous projets) | 🔴 FAIBLE |
| **Cédric** | Perdre JS → chaos opérationnel | 🟡 MOYENNE |
| **Félix** | Status quo (garde contrôle + 23%) | 🟢 FORTE |

### 5.2 ZOPA Estimé

```
ZOPA (Zone of Possible Agreement):
├── Minimum acceptable JS: Garder 23%, CEA signée, cautionnement pro-rata
├── Maximum acceptable Jérôme: Performance-based equity (10% si milestones)
└── Zone: Performance equity (2-10%) + CEA avec vesting + répartition cautionnements
```

### 5.3 Matrice de Décision

| Scénario | Gain JS | Risque | Recommandation |
|----------|---------|--------|----------------|
| **Accepter switch** | -1.8M$ | Précédent exploité | ❌ REFUSER |
| **Négocier performance equity** | Neutre | Résolution possible | ✅ EXPLORER |
| **Recours oppression** | +2M$ (si succès) | Long, coûteux | ⚠️ RÉSERVE |
| **Remplacer Jérôme** | -700k$ (5 ans) | Perte relation | ✅ BATNA VIABLE |

---

## 🔍 PARTIE 6: RECHERCHES PERPLEXITY À FAIRE

### Recherches Juridiques

```
1. "Jurisprudence Québec oppression actionnaire minoritaire 2023 2024 QCCA ordonnances"

2. "Plainte Chambre des notaires Québec partialité négligence professionnelle procédure"

3. "Convention actionnaire Québec clauses vesting clawback shotgun drag-along modèles"

4. "Évaluation parts actionnaire minoritaire Québec méthodologie DCF comparable"
```

### Recherches Outils

```
1. "Best AI tools legal document review contract analysis 2024 open source"

2. "Gmail API Python batch attachment extraction forensic evidence chain custody"

3. "Cursor IDE MCP configuration legal document analysis workflow optimization"

4. "BATNA negotiation software game theory shareholder disputes decision support"
```

### Recherches Stratégiques

```
1. "Peter Thiel Joe Lonsdale startup equity disputes partner conflict resolution philosophy"

2. "Machiavelli Prince power dynamics corporate partnerships manipulation defense"

3. "48 Laws of Power Robert Greene counter-strategies protection"
```

---

## 📈 PARTIE 7: WORKFLOW OPTIMISÉ

### 7.1 Pipeline d'Extraction Complète

```
PHASE 1: COLLECTE (Aujourd'hui)
├── Gmail MCP → Extraire emails Nicolas Marois (514 emails)
├── Gmail MCP → Télécharger 244 pièces jointes notaire
├── Supabase → Indexer nouveaux emails
└── Output: Tous documents bruts

PHASE 2: ANALYSE (Demain)
├── Codex Skill → Extraction structurée documents
├── Perplexity → Recherche jurisprudence applicable
├── Supabase → Créer table preuves_etendues
└── Output: Base de données preuves complète

PHASE 3: SYNTHÈSE (Cette semaine)
├── Agent Cursor → Génération rapport final
├── Codex Skill → Analyse BATNA complète
├── Export → Dossier pour avocat
└── Output: Rapport décisionnel complet
```

### 7.2 Commandes Cursor Recommandées

```
# Prompt pour extraction complète
"En utilisant gmail-jsleboeuf MCP, extraire tous les emails de nicolas.marois@notavo.ca 
depuis mars 2025, télécharger les pièces jointes, et les indexer dans supabase-jerome 
avec tags: cea, switch, cautionnement, collusion"

# Prompt pour analyse juridique
"Analyser les 8 preuves dans la table 'preuves' de supabase-jerome sous l'angle 
de l'article 450 LSAQ (oppression). Pour chaque preuve, évaluer: 
1) Attente raisonnable frustrée
2) Conduite oppressive/abusive
3) Lien avec préjudice quantifié"

# Prompt pour rapport final
"Générer un rapport exécutif de 10 pages couvrant:
1) Timeline chronologique des événements
2) Preuves par acteur (Cédric, Félix, Jérôme)
3) Analyse juridique LSAQ
4) Analyse BATNA
5) Recommandations stratégiques"
```

---

## ✅ CHECKLIST FINALE

### Configuration
- [ ] Cursor 2.0+ avec mode Agent activé
- [ ] 7 MCPs configurés (jerome, nexus, gmail, perplexity, github, tavily, context7)
- [ ] Skills Codex créés (shareholder-disputes, legal-extraction, batna-negotiation)

### Données
- [ ] 5,416 emails dans Supabase
- [ ] Pièces jointes Nicolas Marois téléchargées
- [ ] Preuves indexées et taggées
- [ ] Timeline complète vérifiée

### Analyse
- [ ] Recherches Perplexity juridiques complétées
- [ ] Framework BATNA appliqué
- [ ] Matrice de décision remplie
- [ ] Scénarios de sortie documentés

### Livrable
- [ ] Rapport exécutif généré
- [ ] Dossier preuves organisé pour avocat
- [ ] Plan d'action avec deadlines

---

## 🎯 RÉSUMÉ FINAL

### Ce qu'il faut implémenter IMMÉDIATEMENT:

1. **Skills Codex** - Créer les 3 skills recommandés
2. **Script Python** - Extraire les 244 PJ de Nicolas Marois
3. **Workflow Agent** - Configurer pipeline multi-agents

### Outils les plus puissants pour ce projet:

| Outil | Usage | Impact |
|-------|-------|--------|
| **Perplexity Deep Research** | Jurisprudence LSAQ | 🔴 CRITIQUE |
| **Cursor Multi-Agents** | Extraction parallèle | 🔴 CRITIQUE |
| **Supabase** | Base de données preuves | 🔴 CRITIQUE |
| **Codex Skills** | Analyse structurée | 🟡 HAUTE |
| **Gmail API Batch** | Téléchargement PJ | 🟡 HAUTE |

### Prochaine action recommandée:

**Créer les Skills Codex** puis lancer l'extraction des pièces jointes de Nicolas Marois - c'est là que se trouvent les conventions d'actionnaires et documents juridiques critiques.

---

*Document généré le 21 décembre 2025*
*Basé sur recherches Perplexity approfondies*


