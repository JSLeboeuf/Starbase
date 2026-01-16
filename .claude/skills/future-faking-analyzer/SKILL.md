---
name: future-faking-analyzer
description: |
  Ce skill analyse le "future faking" - fausses promesses pour maintenir le contrôle.
  Utiliser quand l'utilisateur demande: "future faking", "promesses non tenues",
  "il promet toujours", "jamais de suite", "projets jamais réalisés", "carotte et bâton",
  "il dit qu'il va faire", "paroles sans actes", "promesses vides".
---

# Future Faking Analyzer

Skill pour identifier le "Future Faking" - technique de manipulation consistant
à faire des promesses attractives sans intention de les tenir.

## Qu'est-ce que le Future Faking?

**Future Faking**: Faire des promesses sur l'avenir pour:
- Maintenir l'engagement de la cible
- Éviter les conflits présents
- Gagner du temps
- Obtenir quelque chose maintenant
- Créer de faux espoirs

**Caractéristique clé**: Les promesses ne se concrétisent jamais ou
sont constamment reportées.

## Types de Future Faking

### 1. Promesses Relationnelles

**Exemples:**
- "Un jour on fera X ensemble"
- "Quand les choses seront calmes..."
- "Je t'ai toujours prévu dans mes plans"

### 2. Promesses Financières

**Exemples:**
- "Tu auras ta part quand..."
- "Le bonus arrivera au prochain trimestre"
- "L'augmentation est prévue pour..."

### 3. Promesses de Changement

**Exemples:**
- "Je vais changer, donne-moi du temps"
- "C'est temporaire, ça va s'améliorer"
- "Après ce projet, ce sera différent"

### 4. Promesses de Reconnaissance

**Exemples:**
- "Tu seras officiellement promu quand..."
- "Je te présenterai comme associé à..."
- "Ton nom sera sur le contrat après..."

### 5. Promesses Conditionnelles

**Exemples:**
- "Si tu fais X, alors je ferai Y"
- "Quand tu auras prouvé que..., alors..."
- "Dès que la situation le permettra..."

## Pattern du Future Faking

```
1. PROMESSE
   "Je vais te donner 30% des parts l'année prochaine"

2. MAINTIEN (keep on the hook)
   La cible reste engagée en attendant

3. REPORT/EXCUSE
   "Le marché n'est pas bon, reportons à..."

4. NOUVELLE PROMESSE
   "Mais je te promets que d'ici 6 mois..."

5. CYCLE RÉPÉTÉ
   Le même pattern se répète indéfiniment
```

## Red Flags du Future Faking

| Signal | Signification |
|--------|---------------|
| Promesses vagues sans détails | Aucune intention de réaliser |
| Conditions changeantes | Goal posts mobiles |
| Timing toujours repoussé | Jamais le "bon moment" |
| Excuses systématiques | Responsabilité externalisée |
| Rien par écrit | Deniabilité |
| Promesses après conflits | Apaisement temporaire |
| Promesses publiques vs privées | Incohérence |

## Analyse du Pattern

### Template de Suivi

```
PROMESSE #___

DATE DE LA PROMESSE: _______________
CONTENU EXACT: "_______________"
ÉCHÉANCE PROMISE: _______________

SUIVI:
| Date | Action | Résultat |
|------|--------|----------|
| | Relance | Report à... |
| | Relance | Nouvelle excuse |
| | Relance | Nouvelle promesse |

EXCUSES UTILISÉES:
[ ] Marché/économie
[ ] Timing
[ ] Conditions externes
[ ] Faute de la cible
[ ] Autre: ___

STATUT FINAL:
[ ] Réalisée
[ ] Partiellement réalisée
[ ] Jamais réalisée
[ ] Transformée en autre promesse

TEMPS ÉCOULÉ DEPUIS PROMESSE: _______________
```

### Scoring Future Faking

| Critère | Score 0-3 |
|---------|-----------|
| Promesses répétées non tenues (>3) | |
| Échéances systématiquement repoussées | |
| Conditions qui changent | |
| Excuses externalisées | |
| Pattern identique sur plusieurs promesses | |
| Absence de documentation/engagement écrit | |

**Score > 12**: Future faking systématique
**Score 8-12**: Pattern de future faking
**Score < 8**: Promesses non tenues isolées

## Output Format

```markdown
## Analyse Future Faking - [Sujet/Période]

### Inventaire des Promesses

| # | Promesse | Date | Échéance | Statut | Reports |
|---|----------|------|----------|--------|---------|
| 1 | | | | | |
| 2 | | | | | |

### Analyse par Promesse

#### Promesse #1: "[Contenu]"
- **Date initiale**: ...
- **Échéance promise**: ...
- **Timeline des reports**:
  - [Date]: Excuse: "..."
  - [Date]: Nouvelle échéance: ...
  - [Date]: Excuse: "..."
- **Statut actuel**: [Non réalisée depuis X mois]
- **Pattern**: [Goal posts / Excuses externes / Conditions]

### Patterns Identifiés

1. **[Pattern]**: Observé dans promesses #, #, #
2. **[Pattern]**: ...

### Statistiques

- Total promesses analysées: X
- Promesses tenues: X (X%)
- Promesses non tenues: X (X%)
- Délai moyen de report: X mois
- Excuses les plus fréquentes: ...

### Score Future Faking: X/18

### Conclusions
[Ce que ce pattern révèle sur les intentions]
```

## Différencier Future Faking vs Intentions Réelles

### Signes d'Intention Réelle

| Critère | Présent |
|---------|---------|
| Détails spécifiques et concrets | |
| Échéancier réaliste | |
| Actions préparatoires visibles | |
| Engagement écrit/formel | |
| Cohérence dans le temps | |
| Réalisation de promesses passées | |

### Signes de Future Faking

| Critère | Présent |
|---------|---------|
| Promesses vagues | |
| "Bientôt" sans date | |
| Conditions changeantes | |
| Historique de non-réalisation | |
| Promesses après conflits | |
| Résistance à formaliser | |

## Contre-Mesures

### 1. Exiger des Écrits

> "Super, peux-tu me confirmer ça par email avec les détails?"

### 2. Demander le Spécifique

> "Concrètement, quelle date exacte? Quelles conditions précises?"

### 3. Documenter le Pattern

Tenir un journal des promesses avec dates et suivis.

### 4. Fixer des Deadlines

> "Si ce n'est pas fait d'ici [date], je considérerai que..."

### 5. Évaluer sur les Actes

> "Je préfère qu'on parle de ce qui a été fait plutôt que de ce qui sera fait."

## Ressources

- `references/promesses-tracking.md` - Template de suivi
- `references/negotiation-tactics.md` - Obtenir des engagements
- `scripts/promise_tracker.py` - Tracker automatique de promesses
