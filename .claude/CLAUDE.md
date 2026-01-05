# CLAUDE.md - Configuration Projet Jerome

## Mode Performance Maximum

Ce projet est configure pour une autonomie et performance maximales.

### Settings Actifs
- **Model**: Opus 4.5 (le plus puissant)
- **Thinking**: Toujours active (32K tokens max)
- **Permissions**: Toutes auto-approuvees
- **Sandbox**: Desactive (acces complet)
- **Caching**: Active (optimise couts/perf)

### Timeouts Etendus
- Bash: 5 minutes (300,000ms)
- Max Bash: 10 minutes (600,000ms)
- MCP: 60 secondes
- Output: 16K tokens

### Plugins Actifs
- GitHub (repos, PRs, issues)
- Supabase (base jerome-analysis)
- Notion (workspace)
- Playwright (automatisation web)
- Context7 (documentation)

## Contexte Projet

Voir `../CLAUDE.md` pour le contexte complet du projet.

## Regles d'Execution

1. **JAMAIS** demander confirmation pour les operations fichiers
2. **TOUJOURS** executer en parallele quand possible
3. **TOUJOURS** utiliser PowerShell (pas bash/sh)
4. **TOUJOURS** utiliser le thinking pour les taches complexes
5. **AUTOMATIQUEMENT** corriger les erreurs de linter
