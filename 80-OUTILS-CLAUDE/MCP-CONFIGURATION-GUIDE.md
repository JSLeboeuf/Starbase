# GUIDE DE CONFIGURATION MCP
## Configuration des serveurs MCP installes

---

## STATUT DES MCP SERVERS

### Fonctionnels (aucune config requise)

| MCP Server | Statut | Description |
|------------|--------|-------------|
| **memory** | ✅ Connecte | Knowledge Graph - memorise les infos entre sessions |
| **google-workspace** | ✅ Connecte | Gmail + Google Drive |
| **sequential-thinking** | ✅ Connecte | Raisonnement structure etape par etape |
| **document-analyzer** | ✅ Connecte | Analyse de documents (sentiment, mots-cles) |
| **notion** | ✅ Connecte | Integration Notion API |

### Necessitent une cle API

| MCP Server | Variable d'environnement | Ou obtenir la cle |
|------------|-------------------------|-------------------|
| **tavily** | `TAVILY_API_KEY` | https://tavily.com (gratuit: 1000 req/mois) |
| **brave-search** | `BRAVE_API_KEY` | https://brave.com/search/api/ (gratuit: 2000 req/mois) |
| **perplexity** | `PERPLEXITY_API_KEY` | https://www.perplexity.ai/settings/api |
| **exa** | `EXA_API_KEY` | https://exa.ai (gratuit: 1000 req/mois) |

### Necessitent configuration supplementaire

| MCP Server | Configuration requise |
|------------|----------------------|
| **obsidian** | Installer le plugin "Local REST API" dans Obsidian |
| **filesystem** | Chemin Windows peut necessiter ajustement |
| **puppeteer** | Package peut ne pas exister |
| **context7** | Peut necessiter configuration Upstash |
| **fetch** | Devrait fonctionner sans config |

---

## COMMENT AJOUTER LES CLES API

### Methode 1 : Variables d'environnement Windows

1. Ouvrir PowerShell en admin
2. Executer :

```powershell
# Tavily (recherche web IA)
[Environment]::SetEnvironmentVariable("TAVILY_API_KEY", "tvly-xxxxx", "User")

# Brave Search
[Environment]::SetEnvironmentVariable("BRAVE_API_KEY", "BSAxxxxx", "User")

# Perplexity
[Environment]::SetEnvironmentVariable("PERPLEXITY_API_KEY", "pplx-xxxxx", "User")

# Exa
[Environment]::SetEnvironmentVariable("EXA_API_KEY", "xxxxx", "User")
```

3. Redemarrer Claude Code

### Methode 2 : Fichier .env

Creer un fichier `C:\Users\Utilisateur\.env` :

```env
TAVILY_API_KEY=tvly-xxxxx
BRAVE_API_KEY=BSAxxxxx
PERPLEXITY_API_KEY=pplx-xxxxx
EXA_API_KEY=xxxxx
```

### Methode 3 : Modifier .claude.json directement

Ajouter les cles dans la section `env` de chaque serveur MCP.

---

## OBTENIR LES CLES API GRATUITES

### 1. Tavily (RECOMMANDE - meilleur pour recherche IA)
- URL : https://tavily.com
- Gratuit : 1000 requetes/mois
- Inscription : Email

### 2. Brave Search
- URL : https://brave.com/search/api/
- Gratuit : 2000 requetes/mois
- Inscription : Email

### 3. Perplexity
- URL : https://www.perplexity.ai/settings/api
- Prix : Pay-per-use (~$0.001/requete)
- Necessite compte Perplexity

### 4. Exa
- URL : https://exa.ai
- Gratuit : 1000 requetes/mois
- Inscription : Email

---

## UTILISATION DES MCP POUR TON CAS JEROME

### Sequential Thinking (DEJA ACTIF)

Pour une analyse approfondie, demande :
> "Utilise sequential thinking pour analyser les 5 scenarios si je refuse le switch de Jerome"

### Memory (DEJA ACTIF)

Pour memoriser les informations cles :
> "Memorise que Jerome lit Machiavel et les 48 lois du pouvoir"

### Avec Tavily/Perplexity (apres config API)

Pour recherche juridique :
> "Recherche les cas de recours en oppression LSAQ Quebec 2024 2025"

---

## COMMANDES UTILES

```bash
# Voir tous les MCP installes
claude mcp list

# Supprimer un MCP
claude mcp remove <nom>

# Ajouter un MCP avec env
claude mcp add <nom> -s user -e TAVILY_API_KEY=xxx -- npx -y tavily-mcp
```

---

## PROCHAINES ETAPES

1. **Obtenir cle Tavily** (gratuit) - https://tavily.com
2. **Configurer la variable** d'environnement
3. **Redemarrer Claude Code**
4. **Tester** avec une recherche juridique

---

*Guide de configuration MCP*
*Date : 15 decembre 2025*
