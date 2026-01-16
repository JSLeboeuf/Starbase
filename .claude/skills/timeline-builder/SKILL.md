---
name: timeline-builder
description: |
  Ce skill construit des chronologies détaillées d'événements et manipulations.
  Utiliser quand l'utilisateur demande: "chronologie", "timeline", "ordre des événements",
  "quand est-ce arrivé", "séquence", "historique", "reconstruire l'histoire",
  "avant/après", "évolution dans le temps", "dates clés".
---

# Timeline Builder

Skill pour construire des chronologies détaillées permettant de visualiser
l'évolution des manipulations narcissiques dans le temps.

## Importance de la Chronologie

### Pourquoi Construire une Timeline?

1. **Révéler les patterns** - Comportements répétitifs visibles
2. **Établir la causalité** - Cause → Effet clairement liés
3. **Prouver l'intention** - Planification vs "accidents"
4. **Documenter l'escalade** - Aggravation progressive
5. **Support juridique** - Faits ordonnés chronologiquement

## Types de Timelines

### 1. Timeline Globale

Vue d'ensemble de toute la relation/situation.

```
[Début relation] -----> [Événements clés] -----> [Situation actuelle]
     |                        |                        |
   Lune de miel         Manipulation              Confrontation
```

### 2. Timeline d'Incident

Zoom sur un événement spécifique.

```
[Avant] --> [Déclencheur] --> [Incident] --> [Réaction N] --> [Conséquences]
```

### 3. Timeline Comparative

Comparer la version du narcissique vs réalité.

```
Version N:  [A] --> [B] --> [C]
Réalité:    [X] --> [Y] --> [Z]
                    ^
                    Contradiction
```

### 4. Timeline de Pattern

Montrer la répétition d'un comportement.

```
Incident 1: [Phase 1] --> [Phase 2] --> [Phase 3]
Incident 2: [Phase 1] --> [Phase 2] --> [Phase 3]
Incident 3: [Phase 1] --> [Phase 2] --> [Phase 3]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                    Pattern identique
```

## Template de Construction

### Étape 1: Collecte des Événements

```
| Date | Événement | Source | Vérifiable | Impact |
|------|-----------|--------|------------|--------|
| | | | | |
```

### Étape 2: Catégorisation

```
ÉVÉNEMENTS PAR TYPE:

Décisions:
- [Date]: [Décision] - [Par qui]

Communications:
- [Date]: [Type] - [De/Vers] - [Contenu clé]

Incidents:
- [Date]: [Description] - [Témoins]

Changements:
- [Date]: [Avant] → [Après]
```

### Étape 3: Identification des Pivots

```
MOMENTS PIVOTS:

1. [Date]: [Événement pivot]
   - Avant: [Situation]
   - Après: [Nouvelle situation]
   - Signification: [Analyse]

2. ...
```

## Format de Timeline Textuelle

### Timeline Simple

```
CHRONOLOGIE - [Sujet]
==================

[ANNÉE]

[Mois] [Jour]
├── [Événement 1]
│   └── Détail: ...
│   └── Source: ...
│
├── [Événement 2]
│
└── [Événement 3]

[Mois suivant] [Jour]
├── [Événement 4]
...
```

### Timeline Annotée

```
CHRONOLOGIE ANNOTÉE
===================

DATE        | ÉVÉNEMENT                 | ANALYSE
------------|---------------------------|------------------
2023-01-15  | Signature convention      | Début engagement
2023-02-20  | Premier refus info        | 🚩 Red flag #1
2023-03-10  | Promesse dividendes       | Future faking
2023-04-05  | Promesse non tenue        | Pattern confirmé
...
```

### Timeline Visuelle (ASCII)

```
2023                                    2024
|-------|-------|-------|-------|-------|-------|
J   F   M   A   M   J   J   A   S   O   N   D   J
    |       |           |               |       |
    A       B           C               D       E

A: Signature contrat
B: Premier incident
C: Escalade
D: Confrontation
E: Situation actuelle
```

## Template Output Complet

```markdown
## Chronologie - [Contexte]

### Métadonnées

| Élément | Valeur |
|---------|--------|
| Période | [Début] à [Fin] |
| Durée | X mois/années |
| Événements | N total |
| Sources | N documents |

### Phases Identifiées

#### Phase 1: [Nom] (Date début - Date fin)
Caractéristiques: ...

#### Phase 2: [Nom] (Date début - Date fin)
Caractéristiques: ...

### Timeline Détaillée

#### [Année]

**[Mois]**

| Jour | Événement | Type | Réf |
|------|-----------|------|-----|
| | | | |

**Analyse du mois**: [Observations]

#### [Année suivante]
...

### Moments Pivots

1. **[Date]**: [Événement]
   - Signification: ...
   - Preuves: ...

### Patterns Temporels

| Pattern | Fréquence | Dernière occurrence |
|---------|-----------|---------------------|
| | | |

### Visualisation

```
[Représentation ASCII de la timeline]
```

### Corrélations Temporelles

- [Événement A] précède toujours [Événement B]
- [Pattern] se répète tous les [intervalle]
- Escalade observée entre [Date] et [Date]

### Lacunes/Zones d'Ombre

| Période | Information manquante |
|---------|----------------------|
| | |

### Conclusions Chronologiques

1. [Conclusion basée sur la séquence]
2. [Pattern temporel significatif]
3. [Projection possible]
```

## Techniques d'Analyse Temporelle

### 1. Analyse de Fréquence

```
Incidents par mois:
Jan: ██ (2)
Fév: ████ (4)
Mar: ██████ (6)    <- Escalade
Avr: ████████ (8)
```

### 2. Analyse de Délai

```
Promesse → Non-respect: Délai moyen = X jours
Incident → Réconciliation: Délai moyen = Y jours
Cycle complet: Durée moyenne = Z semaines
```

### 3. Analyse de Corrélation

```
Quand [A] se produit, [B] suit dans X% des cas
Intervalle moyen entre [A] et [B]: N jours
```

### 4. Analyse d'Escalade

```
Gravité des incidents dans le temps:

Gravité
   ^
 5 |              *  *
 4 |           *        *
 3 |        *
 2 |     *
 1 |  *
   +-------------------------> Temps
      T1  T2  T3  T4  T5  T6
```

## Intégration avec Autres Skills

- **Pattern Detector** → Alimente la timeline avec les incidents
- **Evidence Compiler** → Fournit les sources datées
- **Correlation Engine** → Identifie les liens temporels

## Ressources

- `references/timeline-formats.md` - Formats de timeline
- `references/temporal-analysis.md` - Techniques d'analyse
- `scripts/timeline_generator.py` - Génération automatique
