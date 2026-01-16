---
name: contract-manipulation-analyzer
description: |
  Ce skill analyse les manipulations dans les contrats et accords.
  Utiliser quand l'utilisateur demande: "manipulation contrat", "clause cachée",
  "convention actionnaires", "conditions inégales", "accord défavorable",
  "piège contractuel", "engagement asymétrique", "analyser contrat".
---

# Contract Manipulation Analyzer

Skill pour identifier les manipulations dans les contrats, conventions
d'actionnaires et accords commerciaux.

## Types de Manipulations Contractuelles

### 1. Clauses Asymétriques

**Définition**: Obligations différentes pour des parties censées être égales.

**Exemples:**
| Partie A | Partie B |
|----------|----------|
| Cautionnement illimité | Exempté |
| Non-concurrence 5 ans | Non-concurrence 1 an |
| Préavis 6 mois | Préavis immédiat |

### 2. Clauses Cachées/Enterrées

**Techniques:**
- Langage complexe pour obscurcir
- Clauses importantes en fin de document
- Références à annexes non fournies
- Modifications en petits caractères

### 3. Ambiguïtés Intentionnelles

**Objectif**: Permettre interprétation favorable au narcissique

**Exemples:**
- "Rémunération raisonnable" (qui définit "raisonnable"?)
- "Dans un délai approprié" (quel délai?)
- "Selon les performances" (quels critères?)

### 4. Clauses Léonines

**Définition**: Clauses excessivement déséquilibrées, parfois annulables.

**Exemples:**
- Pénalités de sortie disproportionnées
- Droits de véto asymétriques
- Conditions de rachat défavorables

### 5. Omissions Stratégiques

**Ce qui manque peut être aussi important:**
- Pas de clause de sortie
- Pas de mécanisme de résolution des conflits
- Pas de valorisation prédéfinie
- Pas de protection des minoritaires

## Analyse de Conventions d'Actionnaires

### Points Critiques à Examiner

```
1. RÉPARTITION DU CAPITAL
   - Parts initiales vs actuelles
   - Mécanisme de dilution
   - Droits de préemption

2. GOUVERNANCE
   - Qui décide quoi?
   - Quorum requis
   - Droit de véto

3. ENGAGEMENTS PERSONNELS
   - Cautionnements
   - Non-concurrence
   - Exclusivité

4. CONDITIONS DE SORTIE
   - Rachat forcé (conditions?)
   - Valorisation (quelle méthode?)
   - Délais de paiement

5. PARTAGE DES RISQUES
   - Qui cautionne quoi?
   - Répartition des pertes
   - Appels de fonds

6. PARTAGE DES BÉNÉFICES
   - Dividendes (conditions?)
   - Plus-values (répartition?)
   - Salaires/bonus
```

### Template d'Analyse

```
DOCUMENT ANALYSÉ: _______________
DATE: _______________
PARTIES: _______________

CLAUSES ASYMÉTRIQUES IDENTIFIÉES:

Clause #___: [Titre/Référence]
- Partie A: [Obligation]
- Partie B: [Obligation différente]
- Impact: [Qui est défavorisé et comment]
- Justification donnée: ___
- Justification réelle: ___

CLAUSES AMBIGUËS:

Clause #___: [Citation]
- Interprétation possible 1: ___
- Interprétation possible 2: ___
- Interprétation probable du N: ___
- Risque: ___

OMISSIONS IMPORTANTES:

- [Ce qui devrait être présent mais ne l'est pas]
- Impact: ___

CLAUSES POTENTIELLEMENT ABUSIVES:

Clause #___: [Citation]
- Pourquoi potentiellement abusive: ___
- Base légale de contestation: ___
```

## Scoring Manipulation Contractuelle

| Critère | Score 0-3 |
|---------|-----------|
| Clauses asymétriques identifiées | |
| Ambiguïtés stratégiques | |
| Omissions significatives | |
| Langage complexifié intentionnellement | |
| Pression à signer rapidement | |
| Modifications post-signature | |

**Score > 12**: Contrat manipulatoire
**Score 8-12**: Déséquilibres significatifs
**Score < 8**: Déséquilibres mineurs ou négociables

## Output Format

```markdown
## Analyse Contractuelle - [Document]

### Informations Générales

| Élément | Détail |
|---------|--------|
| Type de document | |
| Date | |
| Parties | |
| Objet | |

### Asymétries Identifiées

#### Asymétrie #1: [Sujet]

| | Partie A | Partie B |
|-|----------|----------|
| Obligation | | |
| Risque | | |
| Bénéfice | | |

**Impact**: ...
**Justification apparente**: ...
**Réalité probable**: ...

### Clauses Ambiguës

| Clause | Citation | Risque d'interprétation |
|--------|----------|------------------------|
| | | |

### Omissions Critiques

1. **[Élément manquant]**: Conséquence: ...
2. ...

### Clauses Potentiellement Abusives

| Clause | Raison | Base de contestation |
|--------|--------|---------------------|
| | | |

### Score Manipulation: X/18

### Synthèse des Risques

| Risque | Probabilité | Impact | Clause |
|--------|-------------|--------|--------|
| | | | |

### Recommandations

1. **Renégocier**: ...
2. **Clarifier**: ...
3. **Ajouter**: ...
4. **Consulter avocat pour**: ...
```

## Red Flags Lors de la Négociation

| Signal | Signification |
|--------|---------------|
| "Fais-moi confiance, pas besoin de lire" | Quelque chose à cacher |
| Pression temporelle | Éviter l'analyse |
| "C'est standard" | Peut ne pas l'être |
| Refus de modifications | Rigidité suspecte |
| "Les avocats compliquent tout" | Éviter le conseil |
| Changements de dernière minute | Modifications sournoises |

## Contre-Mesures

### 1. Avant de Signer

- Lire TOUT le document
- Faire relire par avocat indépendant
- Demander délai de réflexion
- Négocier les asymétries

### 2. Questions à Poser

> "Pourquoi cette clause est-elle différente pour moi?"
> "Que se passe-t-il si [scénario]?"
> "Comment est calculé/défini [terme ambigu]?"
> "Où est la clause sur [élément manquant]?"

### 3. Demander des Modifications

> "J'aimerais que la clause X soit identique pour tous"
> "J'aimerais ajouter une définition précise de Y"
> "J'aimerais une clause de sortie avec ces conditions"

### 4. Si Refus de Modifier

- Demander les raisons par écrit
- Évaluer si le deal vaut le risque
- Documenter les objections soulevées
- Considérer ne pas signer

## Ressources

- `references/clauses-types.md` - Clauses standard vs abusives
- `references/convention-actionnaires.md` - Guide conventions
- `scripts/contract_analyzer.py` - Analyse automatique de texte
