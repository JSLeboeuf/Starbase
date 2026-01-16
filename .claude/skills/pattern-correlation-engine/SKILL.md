---
name: pattern-correlation-engine
description: |
  Ce skill identifie les corrélations entre différents patterns de manipulation.
  Utiliser quand l'utilisateur demande: "liens entre incidents", "corrélation",
  "pattern récurrent", "comportement systématique", "analyse croisée",
  "interconnexions", "relation cause-effet", "prédire comportement".
---

# Pattern Correlation Engine

Skill pour identifier et analyser les corrélations entre différents patterns
de manipulation narcissique, révélant le système sous-jacent.

## Objectif

Transformer des incidents isolés en compréhension systémique du comportement
manipulatoire en identifiant:
- Les déclencheurs récurrents
- Les séquences prévisibles
- Les cibles privilégiées
- Les contextes à risque

## Types de Corrélations

### 1. Corrélation Temporelle

**Question**: Quand A se produit, B suit-il?

```
Événement A ────[délai]────> Événement B
   (cause)                    (effet)

Exemple:
Critique publique ──[24-48h]──> Silent treatment
```

### 2. Corrélation Contextuelle

**Question**: Dans quel contexte X se produit-il?

```
Contexte              → Comportement probable
─────────────────────────────────────────────
Réunion avec témoins  → Charme, générosité
Seul avec cible       → Dévalorisation
Stress financier      → Blame shifting
```

### 3. Corrélation de Cible

**Question**: Qui est ciblé et quand?

```
Cible A: Ciblée quand [conditions]
Cible B: Ciblée quand [autres conditions]
Cible C: Épargnée (flying monkey)
```

### 4. Corrélation Tactique

**Question**: Quelles tactiques sont combinées?

```
Tactique 1 + Tactique 2 = Combinaison fréquente

Exemple:
Gaslighting + Isolation = Contrôle renforcé
Future faking + Love bombing = Cycle d'abus
```

## Matrice de Corrélation

### Template Principal

```
              | Gasl | DARVO | Silent | Triang | Blame |
─────────────────────────────────────────────────────────
Gaslighting   |  -   |  0.8  |  0.3   |  0.6   |  0.7  |
DARVO         | 0.8  |   -   |  0.5   |  0.4   |  0.9  |
Silent Treat  | 0.3  |  0.5  |   -    |  0.2   |  0.4  |
Triangulation | 0.6  |  0.4  |  0.2   |   -    |  0.5  |
Blame Shift   | 0.7  |  0.9  |  0.4   |  0.5   |   -   |

Score: 0 = jamais ensemble, 1 = toujours ensemble
```

### Interprétation

```
Score > 0.7: Corrélation forte (tactiques liées)
Score 0.4-0.7: Corrélation modérée
Score < 0.4: Corrélation faible (indépendantes)
```

## Analyse de Séquences

### Identifier les Chaînes

```
SÉQUENCE TYPIQUE IDENTIFIÉE:

1. [Déclencheur]
   ↓
2. [Réaction narcissique initiale]
   ↓
3. [Tactique principale]
   ↓
4. [Si résistance] → [Escalade]
   ↓
5. [Résolution/Réconciliation]
   ↓
6. [Retour au calme]
   ↓
7. [Nouveau cycle]
```

### Template Séquence

```
SÉQUENCE #___: [Nom descriptif]

DÉCLENCHEUR(S):
- [Événement/situation qui déclenche]

PHASE 1: [Description]
- Comportement observé:
- Durée typique:
- Exemples:

PHASE 2: [Description]
...

VARIANTES OBSERVÉES:
- Si [condition]: [variation]
- Si [autre condition]: [autre variation]

FRÉQUENCE: X fois sur période Y
PRÉVISIBILITÉ: [Haute/Moyenne/Faible]
```

## Analyse des Déclencheurs

### Catégorisation

```
DÉCLENCHEURS IDENTIFIÉS:

1. MENACE À L'EGO
   - Critique (même constructive)
   - Comparaison défavorable
   - Échec public
   → Réaction: [Tactiques observées]

2. PERTE DE CONTRÔLE
   - Décision sans lui
   - Information non partagée
   - Indépendance de la cible
   → Réaction: [Tactiques observées]

3. BESOIN DE SUPPLY
   - Stress externe
   - Ennui
   - Baisse d'attention
   → Réaction: [Tactiques observées]

4. CONFRONTATION
   - Preuves présentées
   - Limites posées
   - Remise en question
   → Réaction: [Tactiques observées]
```

### Matrice Déclencheur-Réaction

```
              | Rage | Silent | Gasl | Charm | Blame |
──────────────────────────────────────────────────────
Critique      |  H   |   M    |  H   |   L   |   H   |
Indépendance  |  M   |   H    |  M   |   H   |   M   |
Confrontation |  H   |   H    |  H   |   L   |   H   |
Stress        |  M   |   L    |  M   |   L   |   H   |

H = Haute probabilité, M = Moyenne, L = Faible
```

## Output Format

```markdown
## Analyse de Corrélation - [Contexte]

### Vue d'Ensemble

| Métrique | Valeur |
|----------|--------|
| Incidents analysés | |
| Patterns identifiés | |
| Corrélations fortes | |
| Prévisibilité globale | |

### Matrice de Corrélation

[Matrice des tactiques]

### Corrélations Significatives

#### Corrélation #1: [Tactique A] ↔ [Tactique B]
- **Force**: X.XX
- **Signification**: ...
- **Exemples**: ...

#### Corrélation #2: ...

### Séquences Identifiées

#### Séquence "Nom"
```
[Visualisation de la séquence]
```
- **Fréquence**: X occurrences
- **Déclencheur**: ...
- **Durée moyenne**: ...

### Analyse des Déclencheurs

| Déclencheur | Réaction principale | Probabilité |
|-------------|---------------------|-------------|
| | | |

### Cibles et Contextes

| Cible | Contexte à risque | Tactique favorite |
|-------|-------------------|-------------------|
| | | |

### Prédictions

Basé sur l'analyse:
1. Si [condition], alors probablement [comportement]
2. ...

### Vulnérabilités du Système

Points faibles du pattern manipulatoire:
1. [Vulnérabilité identifiée]
2. ...

### Recommandations

1. **Anticiper**: ...
2. **Préparer**: ...
3. **Répondre**: ...
```

## Métriques de Corrélation

### Coefficient de Corrélation

```
r = Σ(xi - x̄)(yi - ȳ) / √[Σ(xi - x̄)² × Σ(yi - ȳ)²]

Interprétation:
r > 0.7: Corrélation forte positive
r 0.3-0.7: Corrélation modérée
r < 0.3: Corrélation faible
r < 0: Corrélation négative (quand A↑, B↓)
```

### Probabilité Conditionnelle

```
P(B|A) = Probabilité de B sachant que A s'est produit

Exemple:
P(Silent treatment | Critique) = 0.75
→ 75% de chance de silent treatment après une critique
```

## Utilisation Pratique

### 1. Anticipation

Utiliser les corrélations pour prévoir les réactions:
> "Demain je vais [action]. Basé sur les patterns, je peux m'attendre à [réaction]."

### 2. Préparation

Préparer des réponses aux séquences prévisibles:
> "Quand il commence [Phase 1], je sais que [Phase 2] va suivre. Ma réponse sera..."

### 3. Documentation

Documenter en temps réel pour valider les patterns:
> "Comme prévu par la corrélation, [événement] a suivi [déclencheur]."

### 4. Communication

Expliquer les patterns à d'autres (avocat, thérapeute):
> "Ce n'est pas un incident isolé. Voici la corrélation avec X autres incidents..."

## Ressources

- `references/correlation-methods.md` - Méthodes statistiques
- `references/pattern-templates.md` - Templates de patterns
- `scripts/correlation_analyzer.py` - Calcul automatique
