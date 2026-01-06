# Configuration MCP - Projet JEROME
## MCPs Essentiels pour le Dossier de Combat

---

## 🔑 CREDENTIALS CENTRAUX

### Supabase JEROME (Projet Dédié)
```
PROJECT_REF = yixgiabpoeoixxqdgyrs
SUPABASE_URL = https://yixgiabpoeoixxqdgyrs.supabase.co
BUCKET_NAME = jerome-project
```

### Token Global Supabase
```
SUPABASE_ACCESS_TOKEN = (mets-le dans ton environnement, ne le commit pas)
```

---

## ✅ MCPs CRITIQUES (À GARDER)

### 1. Supabase JEROME - PROJET DÉDIÉ 🎯
```json
"supabase-jerome": {
  "command": "npx",
  "args": [
    "-y",
    "@supabase/mcp-server-supabase@latest",
    "--project-ref",
    "yixgiabpoeoixxqdgyrs",
    "--access-token",
    "${SUPABASE_ACCESS_TOKEN}"
  ]
}
```

**Utilisation :**
- ✅ Projet **100% dédié** au dossier juridique
- ✅ Tables: emails, preuves, timeline, arguments
- ✅ Storage bucket: `jerome-project`
- ✅ Isolation totale des données sensibles

### 3. Gmail (jsleboeuf3) - INDISPENSABLE
```json
"gmail-jsleboeuf": {
  "command": "npx",
  "args": ["-y", "@gongrzhe/server-gmail-autoauth-mcp", "--account", "jsleboeuf3"],
  "env": {
    "GOOGLE_CLIENT_ID": "${GOOGLE_CLIENT_ID}",
    "GOOGLE_CLIENT_SECRET": "${GOOGLE_CLIENT_SECRET}",
    "GOOGLE_REFRESH_TOKEN": "${GOOGLE_REFRESH_TOKEN}"
  }
}
```

**Utilisation stratégique :**
- Rechercher emails de Jérôme avec contradictions
- Trouver preuves de manipulation
- Documenter communications sur le "switch"
- Extraire échanges Jérôme-Félix (collusion?)

### 2. Perplexity - CRITIQUE
```json
"perplexity": {
  "command": "perplexity-mcp",
  "args": [],
  "env": {
    "PERPLEXITY_API_KEY": "${PERPLEXITY_API_KEY}"
  }
}
```

**Utilisation stratégique :**
- Recherches juridiques Québec (Art. 450-453 LSAQ)
- Jurisprudence recours en oppression
- Précédents de conflits actionnaires
- Stratégies de négociation

### 3. GitHub - UTILE
```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
  }
}
```

**Utilisation :**
- Backup automatique du dossier
- Versioning des documents
- Historique des modifications

---

## ❌ MCPs À DÉSACTIVER (Pas pertinents)

| MCP | Raison |
|-----|--------|
| `supabase-milette` | Projet Milette - pas ce dossier |
| `supabase-bp-emondage` | BP Émondage - pas ce dossier |
| `vapi` | Voice AI - pas pertinent |
| `filesystem` | Pointe vers autre projet |
| `context7` | Documentation technique - pas critique |
| `sequential-thinking` | Pas nécessaire |
| `playwright` | Automatisation web - pas critique |
| `gmail` (contact-autoscale) | Mauvais compte Gmail |
| `notion` | Optionnel |

---

## 🔥 RECHERCHES GMAIL STRATÉGIQUES

### Trouver les Contradictions de Jérôme
```
from:jlevac@mkmg.ca OR from:levacjerome@gmail.com
```

### Emails sur les Parts/Équité
```
(jérôme OR levac) AND (parts OR équité OR 6% OR 23% OR switch)
```

### Communications Jérôme-Félix
```
from:jlevac@mkmg.ca to:felixhamel1991@gmail.com
```

### Projet Rivière-Baudette
```
rivière-baudette OR "48 portes" OR 9552
```

### Preuves de Non-Contribution
```
from:jlevac@mkmg.ca (contribution OR travail OR projet)
```

---

## 🎯 RECHERCHES PERPLEXITY STRATÉGIQUES

1. **Juridique Québec**
   - "Recours oppression actionnaire minoritaire Québec LSAQ 2024"
   - "Convention actionnaires clauses protection Québec"
   - "Shotgun clause buy-sell agreement Québec"

2. **Stratégie de Négociation**
   - "Négociation actionnaires minoritaires tactiques"
   - "BATNA alternative négociation partenariat"

3. **Précédents Jurisprudence**
   - "Jurisprudence conflit actionnaires PME Québec"
   - "Dilution parts actionnaire minoritaire recours"

---

## 📋 CONFIGURATION COMPLÈTE RECOMMANDÉE

Copier dans `~/.cursor/mcp.json` :

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
    }
  }
}
```

---

## 🎯 RÉSUMÉ - 4 MCPs POUR TOUT DÉFONCER

| MCP | Fonction | Arme |
|-----|----------|------|
| 🗄️ **supabase-jerome** | Base de données dédiée | Stockage preuves isolé |
| 📧 **gmail-jsleboeuf** | Extraction emails | Preuves directes |
| 🔍 **perplexity** | Recherches juridiques | Jurisprudence |
| 📁 **github** | Versioning | Backup sécurisé |

---

## ⚡ ACTIONS IMMÉDIATES

1. **Remplacer** `~/.cursor/mcp.json` avec la config ci-dessus
2. **Redémarrer** Cursor pour charger les nouveaux MCPs
3. **Vérifier** que les 4 MCPs sont actifs

---

*Configuration optimisée pour le projet JEROME - Conflit Actionnaires*
*Date: 21 décembre 2025*
