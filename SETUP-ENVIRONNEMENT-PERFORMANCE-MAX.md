# SETUP ENVIRONNEMENT - PERFORMANCE MAXIMALE
## macOS + Cursor IDE + Claude Code + MCP Servers
### Guide Complet d'Optimisation 2025

---

## 🎯 RÉSUMÉ EXÉCUTIF

Ce guide optimise:
- **Node.js**: Heap 8GB, Thread Pool 12
- **Cursor IDE**: Indexation sélective, mémoire élevée
- **macOS**: Énergie, Spotlight, Caches
- **MCP Servers**: Latence minimale, tokens optimisés
- **Vector DB**: Qdrant local, quantization

---

## ⚡ VARIABLES D'ENVIRONNEMENT CRITIQUES

### Ajouter à `~/.zshrc`:

```bash
# ============================================
# NODE.JS PERFORMANCE MAXIMALE
# ============================================

# Heap Memory: 8GB (ajuster selon RAM disponible)
# 16GB RAM → 6144-8192
# 32GB RAM → 12288-16384
export NODE_OPTIONS="--max-old-space-size=8192 --max-semi-space-size=128"

# Thread Pool: Match CPU cores (M3 Max = 12)
export UV_THREADPOOL_SIZE=12

# ============================================
# CLAUDE CODE CLI OPTIMIZATIONS
# ============================================

# Thinking tokens (raisonnement)
export MAX_THINKING_TOKENS=8192

# MCP Output (réponses compactes)
export MAX_MCP_OUTPUT_TOKENS=4096

# Timeouts (secondes)
export MCP_TIMEOUT=300
export MCP_TOOL_TIMEOUT=120

# API Context Management
export USE_API_CONTEXT_MANAGEMENT=true

# Disable telemetry (performance)
export DISABLE_TELEMETRY=1

# ============================================
# NPM/PNPM PERFORMANCE
# ============================================

export npm_config_fund=false
export npm_config_audit=false
export npm_config_loglevel=error

# ============================================
# CURSOR/ELECTRON OPTIMIZATION
# ============================================

# GPU Acceleration
export ELECTRON_ENABLE_GPU=1

# Disable animations (optionnel)
# export ELECTRON_DISABLE_ANIMATIONS=1
```

### Appliquer immédiatement:
```bash
source ~/.zshrc
```

---

## 🖥️ OPTIMISATIONS macOS SYSTÈME

### 1. Énergie et Performance

```bash
# Désactiver mise en veille écran (pendant dev)
sudo pmset -c displaysleep 0

# Désactiver mise en veille disque
sudo pmset -c disksleep 0

# Désactiver Power Nap
sudo pmset -c powernap 0

# Vérifier les settings
pmset -g
```

### 2. Spotlight - DÉSACTIVER pour projets

```bash
# Désactiver Spotlight pour le projet (économise CPU/IO)
sudo mdutil -i off /Users/thecreator/GitHub/jerome

# Vérifier le statut
mdutil -s /Users/thecreator/GitHub/jerome

# Pour tout le dossier GitHub
sudo mdutil -i off /Users/thecreator/GitHub
```

### 3. Caches et Maintenance

```bash
# Vider caches système (faire périodiquement)
rm -rf ~/Library/Caches/Comet/* 2>/dev/null
rm -rf ~/Library/Caches/node-gyp/* 2>/dev/null
rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null

# Nettoyer npm cache
npm cache clean --force

# Nettoyer Homebrew
brew cleanup

# Vider corbeille
rm -rf ~/.Trash/*
```

### 4. Finder Optimisations

```bash
# Afficher fichiers cachés
defaults write com.apple.finder AppleShowAllFiles YES

# Désactiver animations Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Appliquer
killall Finder
```

### 5. Dock et UI

```bash
# Accélérer animations Dock
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Réduire transparence (performance GPU)
defaults write com.apple.universalaccess reduceTransparency -bool true

# Appliquer
killall Dock
```

---

## 📝 CURSOR IDE SETTINGS.JSON

### Créer/Modifier: `.vscode/settings.json` dans le projet

```json
{
  "// INDEXATION SÉLECTIVE - Performance": "",
  "cursor.indexing.exclude": [
    "**/node_modules/**",
    "**/dist/**",
    "**/build/**",
    "**/.git/**",
    "**/coverage/**",
    "**/*.pdf",
    "**/*.docx",
    "**/ARCHIVES-GROUPE-LEBOEUF/**"
  ],
  
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true,
    "**/*.pdf": true
  },
  
  "files.watcherExclude": {
    "**/node_modules/**": true,
    "**/dist/**": true,
    "**/build/**": true,
    "**/.git/objects/**": true
  },

  "// MÉMOIRE ET PERFORMANCE": "",
  "cursorLargeFile.optimizeForLargeFiles": true,
  "workbench.editor.limitMemoryPerWindow": 4096,
  
  "// TYPESCRIPT SPEEDUP": "",
  "typescript.preferences.includePackageJsonAutoImports": "off",
  "typescript.tsserver.maxTsServerMemory": 4096,
  
  "// DÉSACTIVER FEATURES LOURDES": "",
  "git.autofetch": false,
  "telemetry.telemetryLevel": "off",
  "workbench.startupEditor": "none",
  "extensions.autoUpdate": false,
  
  "// TERMINAL": "",
  "terminal.integrated.scrollback": 5000,
  "terminal.integrated.gpuAcceleration": "on",
  
  "// EDITOR PERFORMANCE": "",
  "editor.minimap.enabled": false,
  "editor.renderWhitespace": "none",
  "editor.smoothScrolling": false,
  "editor.cursorBlinking": "solid",
  "workbench.list.smoothScrolling": false
}
```

---

## 📄 .cursorignore (Projet Jerome)

Créer à la racine du projet:

```gitignore
# Dépendances
node_modules/
.pnpm-store/

# Build outputs
dist/
build/
.next/
out/

# Caches
.cache/
*.log
.DS_Store

# Archives volumineuses (déjà analysées)
ARCHIVES-GROUPE-LEBOEUF/03-PIECES-JOINTES/
*-PIECES-JOINTES/
*-ORGANISE/

# Fichiers binaires
*.pdf
*.docx
*.xlsx
*.zip
*.dmg

# Git
.git/

# IDE
.idea/
*.swp
*.swo

# Données sensibles
.env
.env.*
*.key
infisical-secrets.json
```

---

## 🧠 CLAUDE.md OPTIMISÉ PERFORMANCE

Mettre à jour `CLAUDE.md`:

```markdown
# CLAUDE.md - Projet JEROME - Performance Maximale

## Configuration Performance
- NODE_OPTIONS: --max-old-space-size=8192
- UV_THREADPOOL_SIZE: 12
- MCP_TIMEOUT: 300
- MAX_THINKING_TOKENS: 8192

## Mode Opératoire
- AUTONOMIE MAXIMALE
- PARALLÉLISME: Maximiser appels simultanés
- RÉPONSES COMPACTES: Éviter verbosité

## Règles Performance
- Fichiers < 700 lignes pour agent optimal
- Chunker gros fichiers avant modification
- Utiliser @Codebase pour recherche sémantique
- /clear régulièrement pour reset contexte

## MCP Servers Optimisés
- supabase-jerome: DB dédiée
- gmail-jsleboeuf: Emails
- perplexity: Recherches
- github: Versioning
- context7: Docs techniques
- sequential-thinking: Raisonnement

## Workflow Agentic
1. Analyser (comprendre)
2. Rechercher (parallèle)
3. Structurer (organiser)
4. Exécuter (implémenter)
5. Vérifier (valider)
```

---

## 🗄️ QDRANT LOCAL (Vector DB)

### Installation

```bash
# Via Docker (recommandé)
docker pull qdrant/qdrant

# Lancer avec stockage persistant
docker run -d \
  --name qdrant \
  -p 6333:6333 \
  -p 6334:6334 \
  -v ~/GitHub/jerome/data/vectors:/qdrant/storage \
  --memory="2g" \
  --cpus="2" \
  qdrant/qdrant

# Vérifier
curl http://localhost:6333/health
```

### Configuration Optimisée

```json
{
  "storage": {
    "performance": {
      "max_search_threads": 4,
      "optimizer_cpu_budget": 2
    }
  },
  "collection": {
    "vectors": {
      "size": 1536,
      "distance": "Cosine"
    },
    "optimizers_config": {
      "memmap_threshold": 20000,
      "indexing_threshold": 10000
    },
    "quantization_config": {
      "scalar": {
        "type": "int8",
        "always_ram": true
      }
    }
  }
}
```

---

## 🔧 SCRIPT DE DÉMARRAGE DEV

Créer `~/GitHub/jerome/start-dev.sh`:

```bash
#!/bin/bash
# Script de démarrage environnement dev optimisé

echo "🚀 DÉMARRAGE ENVIRONNEMENT DEV OPTIMISÉ"
echo "========================================"

# 1. Charger variables d'environnement
source ~/.zshrc

# 2. Vérifier Node.js
echo "📦 Node.js: $(node -v)"
echo "📦 Heap Max: $NODE_OPTIONS"
echo "📦 Thread Pool: $UV_THREADPOOL_SIZE"

# 3. Démarrer Qdrant si pas déjà actif
if ! docker ps | grep -q qdrant; then
    echo "🗄️ Démarrage Qdrant..."
    docker start qdrant 2>/dev/null || \
    docker run -d --name qdrant -p 6333:6333 -p 6334:6334 \
        -v ~/GitHub/jerome/data/vectors:/qdrant/storage \
        --memory="2g" --cpus="2" qdrant/qdrant
fi

# 4. Vérifier espace disque
DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')
echo "💾 Espace disque disponible: $DISK_FREE"

# 5. Vérifier mémoire
MEM_FREE=$(vm_stat | grep "Pages free" | awk '{print $3}' | tr -d '.')
echo "🧠 Pages mémoire libres: $MEM_FREE"

# 6. Désactiver Spotlight pour le projet
sudo mdutil -i off ~/GitHub/jerome 2>/dev/null

echo ""
echo "✅ Environnement prêt!"
echo "📂 cd ~/GitHub/jerome"
echo "🖥️ Ouvrir Cursor: cursor ."
```

Rendre exécutable:
```bash
chmod +x ~/GitHub/jerome/start-dev.sh
```

---

## 📊 MONITORING PERFORMANCE

### Commandes utiles

```bash
# Mémoire Node.js en temps réel
node -e "setInterval(() => console.log(process.memoryUsage()), 1000)"

# CPU par processus
top -o cpu

# Mémoire système
vm_stat

# I/O disque
iostat -w 1

# Processus Node.js
ps aux | grep node

# Docker stats
docker stats qdrant
```

### Activity Monitor
- Ouvrir Activity Monitor
- Onglet Memory → Vérifier "Memory Pressure" = Vert
- Onglet CPU → Vérifier < 80% sustained

---

## ✅ CHECKLIST D'OPTIMISATION

### Fait une fois:
- [ ] Variables ~/.zshrc configurées
- [ ] source ~/.zshrc exécuté
- [ ] Spotlight désactivé pour ~/GitHub
- [ ] Docker + Qdrant installés
- [ ] .cursorignore créé
- [ ] settings.json Cursor configuré
- [ ] CLAUDE.md mis à jour
- [ ] start-dev.sh créé

### Avant chaque session:
- [ ] `./start-dev.sh` exécuté
- [ ] Memory Pressure = Vert
- [ ] Espace disque > 10 Go
- [ ] MCP servers connectés

### Périodiquement:
- [ ] `brew cleanup`
- [ ] `npm cache clean --force`
- [ ] Vider ~/Library/Caches
- [ ] Vider corbeille

---

## 🎯 GAINS ATTENDUS

| Métrique | Avant | Après | Gain |
|----------|-------|-------|------|
| Indexation codebase | 5-10 min | 1-2 min | 5x |
| Recherche sémantique | 1-2s | 100-300ms | 5-10x |
| Agent response | 5-10s | 2-5s | 2x |
| MCP latency | 500ms+ | <100ms | 5x |
| Memory pressure | Jaune/Rouge | Vert | Stable |

---

*Guide Setup Environnement - Performance Maximale*
*Projet JEROME - 21 décembre 2025*


