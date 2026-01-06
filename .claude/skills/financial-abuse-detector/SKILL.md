---
name: financial-abuse-detector
description: |
  Ce skill détecte l'abus financier narcissique en contexte business/personnel.
  Utiliser quand l'utilisateur demande: "abus financier", "manipulation argent",
  "contrôle financier", "exploitation économique", "il contrôle l'argent",
  "pas accès aux comptes", "cautionnement inégal", "risque financier asymétrique".
---

# Financial Abuse Detector

Skill pour identifier l'abus financier narcissique - utilisation de l'argent
comme outil de contrôle, manipulation et exploitation.

## Qu'est-ce que l'Abus Financier Narcissique?

**Définition**: Utilisation stratégique des ressources financières pour:
- Maintenir le contrôle sur les autres
- Créer une dépendance
- Punir ou récompenser
- Exploiter le travail/ressources d'autrui
- Masquer des activités frauduleuses

## Formes d'Abus Financier

### 1. Contrôle d'Accès

| Comportement | Exemple |
|--------------|---------|
| Restriction info financière | "Tu n'as pas besoin de voir les comptes" |
| Accès limité aux fonds | Approbation requise pour chaque dépense |
| Exclusion des décisions | Décisions financières unilatérales |
| Comptes secrets | Fonds cachés non déclarés |

### 2. Exploitation

| Comportement | Exemple |
|--------------|---------|
| Travail non rémunéré | Contributions non compensées |
| Appropriation des revenus | "Tes gains vont au compte commun que je contrôle" |
| Dettes au nom d'autrui | Engagements signés par la cible |
| Cautionnement asymétrique | Risque porté par certains seulement |

### 3. Sabotage Économique

| Comportement | Exemple |
|--------------|---------|
| Destruction de carrière | Empêcher avancement professionnel |
| Sabotage d'opportunités | Faire échouer des deals |
| Dépenses cachées | Vidage de comptes |
| Dette créée | Endettement de la cible sans consentement |

### 4. Manipulation par l'Argent

| Comportement | Exemple |
|--------------|---------|
| Argent comme récompense | Générosité après soumission |
| Argent comme punition | Retrait de ressources |
| Promesses financières | Future faking économique |
| Chantage financier | "Si tu pars, tu perds tout" |

## En Contexte d'Actionnariat

### Red Flags Spécifiques

| Signal | Signification |
|--------|---------------|
| Cautionnement inégal | Risque asymétrique entre actionnaires |
| Exemptions non justifiées | Certains exemptés sans raison valide |
| Opacité comptable | Refus de partager informations |
| Décisions financières unilatérales | Pas de consultation |
| Rémunération inégale | Travail égal, compensation inégale |
| Dividendes sélectifs | Distribution favorisant certains |
| Prêts forcés | Pressions pour cautionner |

### Cas: Cautionnement Inégal

**Situation type:**
- Actionnaires A et B: Cautionnement personnel illimité
- Actionnaires C et D: Exemptés de cautionnement
- Parts: A=48%, B=23%, C=23%, D=6%

**Questions d'analyse:**
1. Qui porte le risque? (A et B = 71% des parts, 100% du risque)
2. Qui est protégé? (C et D = 29% des parts, 0% du risque)
3. Quelle justification officielle?
4. Qui bénéficie de cette structure?

## Template d'Analyse

```
CONTEXTE FINANCIER
==================

Structure actuelle:
| Actionnaire | Parts | Cautionnement | Risque réel |
|-------------|-------|---------------|-------------|
| | | | |

INDICATEURS D'ABUS FINANCIER

1. CONTRÔLE D'ACCÈS
   [ ] Accès aux comptes restreint
   [ ] Information financière cachée
   [ ] Décisions unilatérales
   Preuves: _______________

2. EXPLOITATION
   [ ] Travail non/sous-compensé
   [ ] Appropriation de revenus
   [ ] Cautionnement asymétrique
   Preuves: _______________

3. SABOTAGE
   [ ] Opportunités bloquées
   [ ] Dépenses cachées
   [ ] Création de dettes
   Preuves: _______________

4. MANIPULATION
   [ ] Argent comme récompense/punition
   [ ] Promesses non tenues
   [ ] Chantage financier
   Preuves: _______________

BÉNÉFICIAIRES: _______________
VICTIMES: _______________
```

## Scoring Abus Financier

| Critère | Score 0-3 |
|---------|-----------|
| Asymétrie risque/bénéfice documentée | |
| Opacité sur informations financières | |
| Décisions unilatérales répétées | |
| Promesses financières non tenues | |
| Exploitation du travail d'autrui | |
| Utilisation de l'argent pour contrôler | |

**Score > 12**: Abus financier systémique
**Score 8-12**: Abus financier probable
**Score < 8**: Indicateurs à surveiller

## Output Format

```markdown
## Analyse Abus Financier - [Contexte]

### Structure Financière

| Partie | Apport | Parts | Risques | Bénéfices |
|--------|--------|-------|---------|-----------|
| | | | | |

### Asymétries Identifiées

#### 1. [Type d'asymétrie]
- **Description**: ...
- **Impact quantifié**: ...
- **Bénéficiaire**: ...
- **Victime**: ...
- **Preuves**: ...

### Calcul d'Équité

```
Contribution A: X%
Risque porté A: Y%
Bénéfices reçus A: Z%

Ratio équité: ...
```

### Timeline des Incidents

| Date | Incident | Impact Financier | Preuve |
|------|----------|------------------|--------|
| | | | |

### Score Abus Financier: X/18

### Implications
[Légales, pratiques, stratégiques]

### Recommandations
1. ...
2. ...
```

## Indicateurs Quantitatifs

### Ratio Risque/Bénéfice

```
Score = (Risque porté / Parts détenues) × 100

Équitable: Score proche de 100 pour tous
Déséquilibré: Scores très différents entre parties

Exemple:
- A: 100% risque / 48% parts = 208 (sur-exposé)
- B: 100% risque / 23% parts = 435 (très sur-exposé)
- C: 0% risque / 23% parts = 0 (protégé)
- D: 0% risque / 6% parts = 0 (protégé)
```

### Écart de Compensation

```
Travail effectué vs Compensation reçue
Heures × Valeur marché vs Salaire/Dividendes
```

## Contre-Mesures

### 1. Documentation

- Garder traces de toutes contributions
- Documenter heures travaillées
- Conserver preuves de promesses

### 2. Formalisation

- Exiger accords écrits
- Demander conventions d'actionnaires claires
- Faire auditer les comptes

### 3. Conseil Professionnel

- Consulter avocat spécialisé
- Comptable indépendant
- Expert en évaluation

### 4. Exit Strategy

- Calculer coût réel de la situation
- Évaluer options de sortie
- Préparer renégociation ou rupture

## Ressources

- `references/asymetries-financieres.md` - Types d'asymétries
- `references/calculs-equite.md` - Formules d'équité
- `scripts/equity_calculator.py` - Calculateur d'équité
