# 📚 CLAUDE CODE - DOCUMENTATION COMPLÈTE ANTHROPIC 2025

## 🎯 Vue d'ensemble

Claude Code est un outil de ligne de commande alimenté par IA développé par Anthropic, conçu pour aider les développeurs en automatisant les tâches de codage via des commandes en langage naturel.

### Fonctionnalités Clés
- **Codage en langage naturel** : Décrivez la fonctionnalité souhaitée en anglais simple
- **Aide au débogage** : Saisissez des messages d'erreur ou descriptions de bugs
- **Navigation dans la base de code** : Posez des questions sur la structure du projet
- **Automatisation des tâches** : Résolution de problèmes de lint, conflits de fusion

## 🚀 Installation & Configuration

### Installation
```bash
# Via NPM (recommandé)
npm install -g @anthropic-ai/claude-code

# Installation native (bêta)
curl -fsSL https://claude.ai/install.sh | bash  # macOS/Linux/WSL
irm https://claude.ai/install.ps1 | iex         # Windows PowerShell
```

### Authentification
```bash
claude  # Lance la session interactive et demande la connexion
```

**Options de connexion :**
- **Claude.ai** : Recommandé pour les plans d'abonnement
- **Claude Console** : Pour accès API avec crédits prépayés

### Premiers Pas
```bash
cd votre-projet
claude
```

## ⚙️ Configuration Avancée

### Hiérarchie des fichiers de configuration (priorité décroissante)
1. **Paramètres gérés entreprise** : `/Library/Application Support/ClaudeCode/` (macOS)
2. **Paramètres projet** : `.claude/settings.json`
3. **Paramètres locaux** : `.claude/settings.local.json`
4. **Paramètres utilisateur global** : `~/.claude/settings.json`

### Commandes de configuration
```bash
# Lister les paramètres actuels
claude config list

# Obtenir un paramètre spécifique
claude config get <clé>

# Définir un paramètre
claude config set <clé> <valeur>

# Réinitialiser aux valeurs par défaut
claude config reset

# Paramètres globaux (ajouter -g/--global)
claude config set model claude-opus-4-5-20251101 --global
```

### Paramètres Essentiels

#### Sélection de Modèle
```json
{
  "model": "claude-opus-4-5-20251101"
}
```
**Modèles disponibles :**
- `claude-opus-4-5-20251101` (plus intelligent, plus lent)
- `claude-sonnet-4-5-20250929` (équilibre, par défaut)
- `claude-haiku-4-5-20251001` (plus rapide, moins intelligent)

#### Permissions
```json
{
  "permissions": {
    "allow": [
      "Bash(npm run test:*)",
      "Read(~/.zshrc)"
    ],
    "deny": [
      "Bash(curl:*)",
      "Read(./secrets/**)"
    ]
  }
}
```

#### Variables d'environnement
```json
{
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "1",
    "OTEL_METRICS_EXPORTER": "otlp"
  }
}
```

#### Thème et UI
```json
{
  "theme": "dark",
  "spinnerTipsEnabled": true
}
```

## 🔧 Serveurs MCP (Model Context Protocol)

### Qu'est-ce que MCP ?
Les serveurs MCP permettent d'intégrer des outils et services externes, étendant les capacités de Claude Code.

### Configuration MCP
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/chemin/autorise"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### Vérification MCP
```bash
# Voir les serveurs configurés
/mcp

# Vérifier le statut
claude mcp list
```

### Nouvelles Fonctionnalités 2025
- **Support MCP distant** : Connexion sécurisée sans gestion locale
- **OAuth natif** : Authentification sécurisée sans clés API

## 💻 Utilisation Quotidienne

### Commandes Essentielles
```bash
# Mode interactif
claude

# Tâche unique
claude "fix the build error"

# Continuer dernière conversation
claude -c

# Commit Git
claude commit

# Aide
/help
```

### Workflows Courants

#### Exploration du Codebase
```bash
> what does this project do?
> show me the main entry points
> explain the authentication flow
```

#### Modifications de Code
```bash
> add a hello world function to main.py
> refactor the authentication module to use async/await
> add input validation to the user registration form
```

#### Tests et Debugging
```bash
> write unit tests for the calculator functions
> fix the null pointer exception in userService.js
> add error handling to the API endpoints
```

#### Git Operations
```bash
> what files have I changed?
> commit my changes with a descriptive message
> create a pull request for this feature
```

#### Documentation
```bash
> update the README with installation instructions
> add JSDoc comments to all public functions
```

#### Revue de Code
```bash
> review my changes and suggest improvements
> check for security vulnerabilities
> optimize the database queries
```

## 🎯 Bonnes Pratiques

### Pour Débutants
- **Soyez spécifique** : Décrivez clairement les tâches
- **Instructions étape par étape** : Divisez les tâches complexes
- **Laissez Claude explorer d'abord** : Compréhension du codebase avant modifications
- **Raccourcis clavier** : Utilisez l'historique des commandes

### Workflows Avancés
- **TDD (Test-Driven Development)** : Écrivez les tests d'abord
- **Planification** : Utilisez `/plan` pour les tâches complexes
- **Sessions multiples** : Travaillez sur différentes tâches simultanément
- **Context reset** : Réinitialisez le contexte pour les longues sessions

## 🔄 Mises à Jour Récents (2025)

### Version 2.0 (Septembre 2025)
- **Checkpoints** : Rollbacks sécurisés pendant le développement
- **Extension VS Code** : Intégration directe dans Visual Studio Code
- **Terminal UX amélioré** : Terminal v2.0
- **Agent SDK** : Anciennement Claude Code SDK

### Fonctionnalités 2025
- **MCP distant** (Juin 2025)
- **OAuth natif** (Juin 2025)
- **Intégration Slack** (2025)
- **Plans business** avec Claude Code inclus

## 🛠️ Dépannage

### Problèmes Courants
```bash
# Permissions refusées
claude --dangerously-skip-permissions

# Problèmes réseau
claude config set httpProxy http://proxy.company.com:8080

# Réinitialisation
claude config reset
```

### Commandes de Diagnostic
```bash
# Vérifier la version
claude --version

# Voir les logs
claude --debug

# Tester la connectivité
claude doctor
```

## 📈 Optimisations Performance

### Variables d'Environnement
```bash
export NODE_OPTIONS="--max-old-space-size=16384"
export UV_THREADPOOL_SIZE="16"
export CLAUDE_CODE_MAX_THINKING_TOKENS="32768"
```

### Configuration Optimisée
```json
{
  "model": "claude-opus-4-5-20251101",
  "permissions": {
    "allow": ["*"],
    "deny": []
  },
  "env": {
    "CLAUDE_CODE_ENABLE_TELEMETRY": "0"
  }
}
```

## 🔗 Ressources Additionnelles

- **Documentation Officielle** : https://docs.anthropic.com/en/docs/claude-code/
- **Guide Démarrage Rapide** : https://docs.anthropic.com/en/docs/claude-code/quickstart
- **Tutoriels** : https://docs.anthropic.com/en/docs/claude-code/tutorials
- **Notes de Version** : https://docs.claude.com/en/release-notes/overview

---

**Dernière mise à jour : Décembre 2025**
**Version Claude Code : 2.0.70**
**Documentation Anthropic officielle**
