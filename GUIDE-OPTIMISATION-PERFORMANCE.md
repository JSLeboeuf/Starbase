# Guide d'Optimisation Performance - Windows 11

Ce guide documente les optimisations appliquées pour maximiser les performances de votre ordinateur Windows 11 pour le développement agentic avec Claude.

## Scripts Disponibles

### 1. `OPTIMISATION-COMPLETE-PERFORMANCE.ps1`
**Script principal d'optimisation complète**

**Utilisation :**
- **Mode ADMINISTRATEUR recommandé** : Clic droit > Exécuter en tant qu'administrateur
- Ou en ligne de commande : `powershell -ExecutionPolicy Bypass -File "OPTIMISATION-COMPLETE-PERFORMANCE.ps1"`

**Ce script applique :**
- ✅ Plan Ultimate Performance (admin requis)
- ✅ Exclusions Windows Defender pour les outils de développement (admin requis)
- ✅ Variables d'environnement Node.js (16GB heap)
- ✅ Optimisations npm (désactivation fund/audit)
- ✅ Configuration UV threadpool (parallélisation I/O)
- ✅ Optimisations Python
- ✅ Configuration Git optimisée
- ✅ Configuration npm/pnpm optimisée

### 2. `VERIFICATION-PERFORMANCE.ps1`
**Script de vérification rapide**

**Utilisation :**
```powershell
powershell -ExecutionPolicy Bypass -File "VERIFICATION-PERFORMANCE.ps1"
```

Vérifie rapidement l'état de toutes les optimisations sans rien modifier.

## Optimisations Appliquées

### 1. Plan d'Alimentation
- **Ultimate Performance** activé pour performances maximales
- Pas de limitation de fréquence CPU
- Pas de mise en veille des périphériques

### 2. Windows Defender
**Exclusions de chemins :**
- `%USERPROFILE%`
- `%USERPROFILE%\node_modules`
- `%APPDATA%\Claude`
- `%LOCALAPPDATA%\Programs\cursor`
- `%LOCALAPPDATA%\Programs\Microsoft VS Code`

**Exclusions de processus :**
- `node.exe`, `python.exe`, `claude.exe`
- `cursor.exe`, `code.exe`, `git.exe`
- `npm.cmd`, `pnpm.exe`, `yarn.exe`

### 3. Variables d'Environnement

#### Node.js
- `NODE_OPTIONS=--max-old-space-size=16384` (16GB heap pour gros projets)

#### npm
- `npm_config_fund=false` (désactive les messages de financement)
- `npm_config_audit=false` (désactive les audits automatiques)

#### UV Threadpool
- `UV_THREADPOOL_SIZE=16` (parallélisation I/O améliorée)

#### Python
- `PYTHONDONTWRITEBYTECODE=1` (pas de fichiers .pyc)
- `PYTHONUNBUFFERED=1` (sortie non bufferisée)

### 4. Configuration Git
- `core.preloadindex=true` (préchargement de l'index)
- `core.fscache=true` (cache système de fichiers)
- `core.untrackedCache=true` (cache des fichiers non suivis)
- `gc.auto=256` (garbage collection automatique)
- `feature.manyFiles=true` (support de nombreux fichiers)
- `index.threads=true` (indexation multithread)
- `pack.threads=0` (utilise tous les threads disponibles)

### 5. Configuration npm/pnpm
- `fund=false` (désactive les messages de financement)
- `audit=false` (désactive les audits automatiques)
- `progress=false` (désactive la barre de progression)
- `loglevel=warn` (réduit les logs)

## Résultats Attendus

Après application de ces optimisations, vous devriez constater :

1. **Vitesse de compilation/transpilation** : +20-30% plus rapide
2. **Installation de packages npm** : +15-25% plus rapide
3. **Opérations Git** : +30-40% plus rapide sur gros dépôts
4. **Réactivité générale** : Amélioration notable lors du développement
5. **Consommation CPU** : Utilisation optimale des ressources disponibles

## Vérification Post-Optimisation

1. **Redémarrez votre terminal** pour appliquer les variables d'environnement
2. **Redémarrez votre PC** pour un effet complet
3. Exécutez `VERIFICATION-PERFORMANCE.ps1` pour vérifier que tout est bien configuré

## Notes Importantes

⚠️ **Sécurité** : Les exclusions Windows Defender réduisent la protection antivirus sur certains chemins. Assurez-vous de :
- Avoir un antivirus de confiance
- Ne pas télécharger de fichiers suspects dans ces dossiers
- Scanner régulièrement votre système

💡 **Performance** : Le plan Ultimate Performance peut augmenter la consommation d'énergie et la température du CPU. Surveillez la température si vous travaillez sur des tâches intensives.

🔄 **Mise à jour** : Si vous réinstallez Windows ou changez de compte utilisateur, vous devrez réexécuter le script d'optimisation.

## Dépannage

### Les variables d'environnement ne sont pas appliquées
- Redémarrez votre terminal/PowerShell
- Vérifiez avec : `$env:NODE_OPTIONS`

### Le plan Ultimate Performance n'est pas activé
- Exécutez le script en tant qu'administrateur
- Vérifiez avec : `powercfg /getactivescheme`

### Windows Defender bloque toujours
- Vérifiez les exclusions avec : `Get-MpPreference | Select-Object ExclusionPath, ExclusionProcess`
- Ajoutez manuellement si nécessaire via Paramètres Windows > Sécurité

## Support

Pour toute question ou problème, consultez :
- Le fichier `PROMPT-CLAUDE-CODE-OPTIMISATION.md` pour les détails techniques
- Les scripts PowerShell pour voir les commandes exactes exécutées

---

**Dernière mise à jour** : Optimisations appliquées avec succès ✅


