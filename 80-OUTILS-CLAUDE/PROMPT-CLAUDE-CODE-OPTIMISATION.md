# PROMPT OPTIMISÉ POUR CLAUDE CODE
## Copier-coller ce prompt dans Claude Code

---

```
Tu es un expert en optimisation système Windows pour le développement agentic avec Claude Opus 4.5.

## CONTEXTE
- OS: Windows 11
- Objectif: Setup agentic coding de classe mondiale
- Priorités: Vitesse, stabilité, performance maximale

## TÂCHES À EXÉCUTER

### 1. OPTIMISATIONS SYSTÈME (ADMIN REQUIS)

Exécute ces commandes PowerShell en admin:

```powershell
# Plan Ultimate Performance
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# Exclusions Windows Defender (critique pour perf)
Add-MpPreference -ExclusionPath "$env:USERPROFILE"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\node_modules"
Add-MpPreference -ExclusionPath "$env:APPDATA\Claude"
Add-MpPreference -ExclusionProcess "node.exe"
Add-MpPreference -ExclusionProcess "python.exe"
Add-MpPreference -ExclusionProcess "claude.exe"
Add-MpPreference -ExclusionProcess "cursor.exe"
Add-MpPreference -ExclusionProcess "code.exe"
```

### 2. VARIABLES D'ENVIRONNEMENT (USER)

```powershell
# Node.js - 16GB heap pour gros projets
[Environment]::SetEnvironmentVariable("NODE_OPTIONS", "--max-old-space-size=16384", "User")

# npm - Désactiver ralentissements
[Environment]::SetEnvironmentVariable("npm_config_fund", "false", "User")
[Environment]::SetEnvironmentVariable("npm_config_audit", "false", "User")

# UV threadpool - Parallélisation I/O
[Environment]::SetEnvironmentVariable("UV_THREADPOOL_SIZE", "16", "User")

# Python - Optimisations
[Environment]::SetEnvironmentVariable("PYTHONDONTWRITEBYTECODE", "1", "User")
[Environment]::SetEnvironmentVariable("PYTHONUNBUFFERED", "1", "User")
```

### 3. CONFIGURATION GIT OPTIMISÉE

```bash
git config --global core.preloadindex true
git config --global core.fscache true
git config --global core.untrackedCache true
git config --global gc.auto 256
git config --global feature.manyFiles true
git config --global index.threads true
git config --global pack.threads 0
```

### 4. CONFIGURATION NPM/PNPM

```bash
# Utiliser pnpm (plus rapide que npm)
npm install -g pnpm

# Config npm optimisée
npm config set fund false
npm config set audit false
npm config set progress false
npm config set loglevel warn
```

### 5. VÉRIFICATION FINALE

Affiche un rapport avec:
- Plan alimentation actif
- Variables d'environnement configurées
- Exclusions Defender actives
- RAM/CPU disponibles
- Recommandations supplémentaires

## FORMAT DE SORTIE

Pour chaque étape:
1. ✅ ou ❌ selon succès
2. Commande exécutée
3. Résultat

À la fin: Résumé des optimisations appliquées et prochaines étapes.
```

---

# VERSION COURTE (1 ligne)

```
Optimise ce PC Windows 11 pour agentic coding: Plan Ultimate Performance, exclusions Defender (node, python, claude, cursor), NODE_OPTIONS=16GB, UV_THREADPOOL=16, git optimisé, npm/pnpm config. Exécute en admin et affiche rapport final.
```

---

# VERSION ULTRA-COURTE

```
Setup agentic coding Windows: Ultimate Performance + Defender exclusions + Node 16GB + Git optimisé. Exécute tout en admin.
```



go




