# CLAUDE.md - Configuration Autonomie Maximale

## Mode Operatoire
- **AUTONOMIE MAXIMALE**: Executer sans demander confirmation
- **PARALLELISME**: Maximiser les appels d'outils en parallele
- **EFFICACITE**: Minimiser les allers-retours, battre les actions

## Permissions Auto-Approuvees
- Lecture/ecriture de tous les fichiers du workspace
- Execution de commandes PowerShell natives
- Operations Git (commit, push, branch)
- Recherche web et fetch d'URLs
- Tous les outils MCP configures

## Contexte du Projet
Ce workspace contient des scripts d'optimisation et des documents d'analyse.

## Standards de Code
- Utiliser PowerShell pour les scripts Windows (JAMAIS bash/sh/WSL)
- Commenter le code en francais
- Nommer les fichiers en MAJUSCULES avec tirets (ex: MON-SCRIPT.ps1)
- Utiliser l'encodage UTF-8

## Conventions
- Scripts PowerShell: extension .ps1
- Documentation: extension .md
- Pas d'emojis dans les scripts PowerShell (problemes d'encodage)
- Utiliser `cmd /c` pour wrapper les commandes npx

## Outils Preferes
- PowerShell 7+ pour les scripts
- Git pour le versioning
- pnpm au lieu de npm (plus rapide)
- Cursor IDE pour le developpement

## Instructions Performance
1. Executer les operations en parallele quand possible
2. Ne pas attendre de confirmation pour les operations de fichiers
3. Battre les modifications connexes dans un seul appel
4. Utiliser les outils de recherche semantique avant de lire des fichiers entiers
5. Compacter automatiquement quand le contexte depasse 80%

## Workflow Agentic Autonome
1. **Analyser** - Comprendre la demande completement
2. **Planifier** - Plan interne, pas de validation externe requise
3. **Executer** - Implementer tous les changements en batch
4. **Verifier** - Auto-validation des modifications
5. **Rapporter** - Resume des actions effectuees

## Performance Systeme
- NODE_OPTIONS: --max-old-space-size=16384
- UV_THREADPOOL_SIZE: 16
- BASH_DEFAULT_TIMEOUT_MS: 300000
- BASH_MAX_TIMEOUT_MS: 600000
- MCP_TIMEOUT: 60000

## Regles d'Autonomie
- NE PAS demander "voulez-vous que je..."
- NE PAS attendre de validation pour les edits de fichiers
- TOUJOURS executer les corrections de linter automatiquement
- TOUJOURS utiliser les todos pour les taches complexes
- MAXIMISER le parallelisme des appels d'outils

## Contact
Workspace: c:\Users\Utilisateur\jerome

