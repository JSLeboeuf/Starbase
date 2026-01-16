# CONFIGURATION ULTIME - CURSOR + CLAUDE CODE
## Projet JEROME - Conflit Actionnaires - Performance Maximale

**Date**: 21 decembre 2025  
**Objectif**: Tout defoncer avec une configuration AI optimisee

---

## 🎯 RESUME EXECUTIF

Configuration pour:
- Extraire et analyser 8,500+ emails
- Recherche juridique Quebec (LSAQ, oppression)
- Analyse de patterns de manipulation
- Construction d'arguments legaux
- Timeline des evenements

---

## 📁 STRUCTURE PROJET RECOMMANDEE

```
jerome/
├── CLAUDE.md                    # Config AI (ci-dessous)
├── .cursor/
│   └── mcp.json                 # MCPs locaux (optionnel)
├── data/
│   ├── emails/                  # Emails extraits
│   ├── preuves/                 # Documents cles
│   └── vectors/                 # Chroma DB local
├── analyses/
│   ├── timeline/                # Chronologie
│   ├── patterns/                # Analyse comportementale
│   └── legal/                   # Arguments juridiques
└── output/
    └── rapports/                # Rapports generes
```

---

## 🔥 CLAUDE.md OPTIMISE POUR CE PROJET

Remplacer le contenu actuel de `CLAUDE.md` :

```markdown
# CLAUDE.md - Projet JEROME - Conflit Actionnaires

## Mode Operatoire
- **AUTONOMIE MAXIMALE**: Executer sans confirmation
- **PARALLELISME**: Maximiser les appels paralleles
- **PRECISION JURIDIQUE**: Citer sources, etre factuel

## Contexte du Projet
Dossier de conflit actionnaires au Quebec:
- **Jean-Samuel Leboeuf**: 23% (defendeur)
- **Jerome Levac**: 6% + 80k$/an (demandeur du switch)
- **Felix Hamel**: 23%
- **Cedric Leboeuf**: 48% (capital)

**Enjeu**: Jerome veut switcher 6% ↔ 23% sur projet 48 portes (~1.8M$)

## Standards de Code
- PowerShell pour scripts Windows
- Commentaires en francais
- Fichiers en MAJUSCULES avec tirets
- Encodage UTF-8

## Outils MCP Disponibles
1. **gmail-jsleboeuf**: Extraction emails Jean-Samuel
2. **perplexity**: Recherches juridiques Quebec
3. **supabase-nexus**: Base de donnees preuves
4. **github**: Versioning dossier

## Recherches Prioritaires

### Gmail - Preuves Critiques
- Emails de Jerome avec contradictions
- Communications Jerome-Felix (collusion?)
- Preuves de non-contribution
- Demandes de switch documentees

### Perplexity - Juridique Quebec
- Art. 450-453 LSAQ (recours oppression)
- Jurisprudence conflits actionnaires PME
- Convention actionnaires clauses
- Shotgun/buy-sell clauses

## Workflow Agentic
1. **Analyser** - Comprendre completement
2. **Rechercher** - Gmail + Perplexity en parallele
3. **Structurer** - Timeline + patterns
4. **Argumenter** - Construire cas juridique
5. **Documenter** - Rapports factuels

## Regles d'Autonomie
- NE PAS demander "voulez-vous que je..."
- TOUJOURS citer les sources (emails, dates, jurisprudence)
- MAXIMISER le parallelisme des recherches
- DISTINGUER faits vs allegations
- DOCUMENTER la chaine de preuves

## Analyse Comportementale
Identifier patterns de:
- Manipulation (gaslighting, blame-shifting)
- Contradiction (dit X puis Y)
- Double standard (Jean-Samuel vs Felix)
- Timing suspect (lectures Machiavel)

## Format de Sortie
- Markdown structure
- Tableaux comparatifs
- Citations exactes avec dates
- Recommendations actionnables
```

---

## 🗄️ MCP CONFIGURATION COMPLETE

### ~/.cursor/mcp.json

```json
{
  "mcpServers": {
    "supabase-jerome": {
      "command": "npx",
      "args": [
        "-y",
        "@supabase/mcp-server-supabase@latest",
        "--project-ref",
        "yixgiabpoeoixxqdgyrs",
        "--access-token",
        "sbp_acfbb070fa03e62e44e680bc82c1477666e13c8f"
      ]
    },
    "gmail-jsleboeuf": {
      "command": "npx",
      "args": ["-y", "@gongrzhe/server-gmail-autoauth-mcp", "--account", "jsleboeuf3"],
      "env": {
        "GOOGLE_CLIENT_ID": "767920457238-eu3b18esg22fhrrv3djbargbgfvp22jg.apps.googleusercontent.com",
        "GOOGLE_CLIENT_SECRET": "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",
        "GOOGLE_REFRESH_TOKEN": "1//05nd3FZSGPEC2CgYIARAAGAUSNwF-L9IrCP_kPKhghS3RcV5WYAOP4loSFEQfvXCqse1HujPAYjIlgmfOwNaPEeIldNYjVUPHGVE"
      }
    },
    "perplexity": {
      "command": "perplexity-mcp",
      "args": [],
      "env": {
        "PERPLEXITY_API_KEY": "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"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "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"
      }
    },
    "chroma": {
      "command": "uvx",
      "args": ["chroma-mcp-server"],
      "env": {
        "CHROMA_CLIENT_TYPE": "persistent",
        "CHROMA_DATA_DIR": "/Users/thecreator/GitHub/jerome/data/vectors",
        "CHROMA_LOG_DIR": "/Users/thecreator/GitHub/jerome/logs"
      }
    }
  }
}
```

---

## 🔧 MCPs RECOMMANDES PAR FONCTION

### 1. 📧 Gmail (jsleboeuf) - EXTRACTION PREUVES
**Fonction**: Extraire emails comme preuves
```
Recherches strategiques:
- from:jlevac@mkmg.ca (tous emails Jerome)
- from:levacjerome@gmail.com
- subject:(parts OR switch OR equite)
- (jerome AND felix) after:2024/01/01
```

### 2. 🔍 Perplexity - RECHERCHE JURIDIQUE
**Fonction**: Jurisprudence Quebec, strategies
```
Requetes prioritaires:
- "Recours oppression LSAQ Quebec 2024 2025"
- "Convention actionnaires PME Quebec clauses"
- "Shotgun clause buy-sell Quebec jurisprudence"
- "Dilution actionnaire minoritaire recours"
```

### 3. 🗄️ Supabase JEROME - BASE DE DONNEES DEDIEE
**Fonction**: Stocker preuves structurees (projet isole)
**URL**: https://yixgiabpoeoixxqdgyrs.supabase.co
**Bucket**: jerome-project
```sql
-- Tables recommandees
CREATE TABLE emails_preuves (
  id UUID PRIMARY KEY,
  date_email TIMESTAMP,
  expediteur TEXT,
  destinataire TEXT,
  sujet TEXT,
  contenu TEXT,
  categorie TEXT, -- contradiction, manipulation, preuve
  importance INTEGER
);

CREATE TABLE timeline_evenements (
  id UUID PRIMARY KEY,
  date_evenement DATE,
  description TEXT,
  acteurs TEXT[],
  preuves_liees UUID[],
  impact TEXT
);

CREATE TABLE arguments_juridiques (
  id UUID PRIMARY KEY,
  argument TEXT,
  base_legale TEXT, -- Art. LSAQ
  preuves UUID[],
  force INTEGER -- 1-10
);
```

### 4. 🧠 Chroma - RECHERCHE SEMANTIQUE
**Fonction**: Trouver patterns dans 8500 emails
```python
# Collections recommandees
- emails_jerome      # Tous emails de/vers Jerome
- emails_felix       # Communications Felix
- contradictions     # Emails contradictoires
- manipulation       # Patterns de manipulation
- timeline           # Evenements chronologiques
```

### 5. 📁 GitHub - VERSIONING
**Fonction**: Backup securise, historique
```
- Commits atomiques par analyse
- Branches par axe d'investigation
- Tags par version du dossier
```

---

## ⚡ ACTIONS IMMEDIATES

### Etape 1: Installer Chroma MCP
```bash
pip install "chroma-mcp-server[full]"
mkdir -p /Users/thecreator/GitHub/jerome/data/vectors
mkdir -p /Users/thecreator/GitHub/jerome/logs
```

### Etape 2: Mettre a jour mcp.json
Copier la config complete ci-dessus dans `~/.cursor/mcp.json`

### Etape 3: Redemarrer Cursor
Pour charger les nouveaux MCPs

### Etape 4: Verifier
```
Cursor > Settings > MCP
Verifier que tous les MCPs sont verts ✅
```

---

## 🎯 RECHERCHES A LANCER EN PREMIER

### Gmail - Preuves Directes
1. `from:jlevac@mkmg.ca subject:parts`
2. `from:jlevac@mkmg.ca subject:switch`
3. `from:jlevac@mkmg.ca to:felixhamel1991@gmail.com`
4. `jerome contribution projet after:2024/01/01`

### Perplexity - Cadre Legal
1. "Art 450 451 453 LSAQ recours oppression Quebec"
2. "Jurisprudence conflit actionnaires 6% vs 23% Quebec"
3. "Convention actionnaires vesting clawback Quebec"
4. "Shotgun clause Quebec PME jurisprudence 2024"

---

## 📊 METRIQUES DE SUCCES

| Objectif | Cible | Mesure |
|----------|-------|--------|
| Emails analyses | 8,500+ | Tous indexes dans Chroma |
| Contradictions trouvees | 10+ | Preuves documentees |
| Base legale | Art. 450-453 | Jurisprudence citee |
| Timeline complete | 2022-2025 | Tous evenements |
| Arguments solides | 5+ | Avec preuves |

---

## 🔒 SECURITE

- **Jamais** partager les credentials en clair
- **Chiffrer** les exports sensibles
- **Versionner** uniquement les analyses, pas les emails bruts
- **Backup** regulier sur GitHub prive

---

*Configuration Ultime pour Projet JEROME*
*Performance Maximale - Cursor + Claude Code*
*21 decembre 2025*

