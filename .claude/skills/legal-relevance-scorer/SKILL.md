---
name: legal-relevance-scorer
description: |
  Ce skill évalue la pertinence juridique des preuves et situations.
  Utiliser quand l'utilisateur demande: "valeur juridique", "preuve légale",
  "recevable en cour", "base pour poursuite", "cas juridique", "avocat",
  "tribunal", "litige", "force probante", "admissibilité preuve".
---

# Legal Relevance Scorer

Skill pour évaluer la pertinence et la force juridique des preuves et
situations documentées dans les cas de manipulation narcissique.

## Avertissement Important

> **Ce skill fournit des indications générales et ne remplace pas
> l'avis d'un avocat qualifié. Consultez toujours un professionnel
> du droit pour des conseils juridiques spécifiques.**

## Objectifs

1. **Évaluer** la force probante des documents
2. **Identifier** les éléments juridiquement pertinents
3. **Prioriser** les preuves pour un dossier juridique
4. **Préparer** la documentation pour consultation légale

## Domaines Juridiques Concernés

### 1. Droit des Sociétés

| Situation | Recours possibles |
|-----------|-------------------|
| Abus de majorité | Action en nullité, dommages |
| Oppression des minoritaires | Recours en oppression |
| Mauvaise gestion | Responsabilité des administrateurs |
| Fraude actionnaires | Action civile/pénale |

### 2. Droit du Travail

| Situation | Recours possibles |
|-----------|-------------------|
| Harcèlement psychologique | Plainte CNESST, civil |
| Congédiement déguisé | Recours en dommages |
| Non-paiement | Réclamation salariale |

### 3. Droit Civil

| Situation | Recours possibles |
|-----------|-------------------|
| Diffamation | Dommages compensatoires |
| Fraude | Annulation, dommages |
| Rupture contractuelle | Exécution forcée, dommages |
| Abus de confiance | Dommages, restitution |

### 4. Droit Pénal

| Situation | Infraction possible |
|-----------|---------------------|
| Faux documents | Faux et usage de faux |
| Détournement | Abus de confiance |
| Menaces | Intimidation |
| Harcèlement | Harcèlement criminel |

## Critères d'Évaluation des Preuves

### 1. Admissibilité

| Critère | Score 1-5 |
|---------|-----------|
| **Authenticité** - Origine vérifiable | |
| **Intégrité** - Non modifiée | |
| **Légalité** - Obtenue légalement | |
| **Pertinence** - Liée aux faits | |

### 2. Force Probante

| Critère | Score 1-5 |
|---------|-----------|
| **Directe** - Prouve directement le fait | |
| **Corroborée** - Confirmée par autres sources | |
| **Contemporaine** - Proche des événements | |
| **Précise** - Détails vérifiables | |

### 3. Utilité Stratégique

| Critère | Score 1-5 |
|---------|-----------|
| **Impact** - Force du message | |
| **Clarté** - Facile à comprendre | |
| **Crédibilité** - Source fiable | |
| **Exclusivité** - Seule preuve de ce fait | |

## Scoring par Type de Preuve

### Documents Écrits

| Type | Admissibilité | Force | Notes |
|------|---------------|-------|-------|
| Contrat signé | 5/5 | 5/5 | Preuve parfaite |
| Email (avec métadonnées) | 4/5 | 4/5 | Horodatage crucial |
| SMS (screenshot) | 3/5 | 3/5 | Contexte nécessaire |
| Notes manuscrites | 3/5 | 2/5 | Si datées |
| Document non signé | 2/5 | 2/5 | Dépend du contexte |

### Communications Électroniques

| Type | Admissibilité | Force | Notes |
|------|---------------|-------|-------|
| Email original (.eml) | 5/5 | 4/5 | Headers préservés |
| Email imprimé | 3/5 | 3/5 | Headers visibles |
| Chat exporté | 4/5 | 3/5 | Plateforme identifiable |
| Screenshot | 2/5 | 2/5 | Facilement falsifiable |

### Témoignages

| Type | Admissibilité | Force | Notes |
|------|---------------|-------|-------|
| Témoignage assermenté | 5/5 | 4/5 | Sous serment |
| Déclaration écrite signée | 4/5 | 3/5 | Engagement formel |
| Témoignage oral | 3/5 | 2/5 | Dépend du témoin |
| Ouï-dire | 1/5 | 1/5 | Généralement inadmissible |

### Enregistrements

| Type | Admissibilité | Force | Notes |
|------|---------------|-------|-------|
| Vidéo (consentement) | 5/5 | 5/5 | Très forte |
| Audio (consentement) | 5/5 | 4/5 | Identification voix |
| Audio (sans consentement) | 1/5 | N/A | Potentiellement illégal |

## Template d'Évaluation

```markdown
## Évaluation Juridique - [Document/Fait]

### Identification

| Élément | Détail |
|---------|--------|
| Type | |
| Date | |
| Source | |
| Référence | |

### Fait Prouvé

[Description du fait que cette preuve établit]

### Scoring

#### Admissibilité (/20)
| Critère | Score |
|---------|-------|
| Authenticité | /5 |
| Intégrité | /5 |
| Légalité | /5 |
| Pertinence | /5 |
| **Total** | /20 |

#### Force Probante (/20)
| Critère | Score |
|---------|-------|
| Directe | /5 |
| Corroborée | /5 |
| Contemporaine | /5 |
| Précise | /5 |
| **Total** | /20 |

#### Utilité (/20)
| Critère | Score |
|---------|-------|
| Impact | /5 |
| Clarté | /5 |
| Crédibilité | /5 |
| Exclusivité | /5 |
| **Total** | /20 |

### Score Global: X/60

### Interprétation

| Score | Signification |
|-------|---------------|
| > 50 | Preuve très solide |
| 40-50 | Preuve solide |
| 30-40 | Preuve utile |
| 20-30 | Preuve à renforcer |
| < 20 | Preuve faible |

### Domaines Juridiques Pertinents

| Domaine | Pertinence | Recours possible |
|---------|------------|------------------|
| | | |

### Recommandations

1. **Renforcer**: ...
2. **Corroborer avec**: ...
3. **Consulter avocat pour**: ...
```

## Output Format Dossier Complet

```markdown
## Évaluation Juridique Globale - [Contexte]

### Résumé du Dossier

| Métrique | Valeur |
|----------|--------|
| Preuves évaluées | |
| Score moyen | |
| Preuves solides (>40/60) | |
| Domaine juridique principal | |

### Inventaire des Preuves

| Réf | Type | Fait prouvé | Score | Priorité |
|-----|------|-------------|-------|----------|
| | | | /60 | |

### Analyse par Domaine

#### Droit des Sociétés
- **Éléments prouvés**: ...
- **Preuves clés**: ...
- **Score dossier**: ...
- **Recours possible**: ...

#### Droit Civil
...

### Forces du Dossier

1. [Preuve forte #1]
2. [Preuve forte #2]

### Faiblesses du Dossier

1. [Lacune #1]
2. [Lacune #2]

### Gaps à Combler

| Fait à prouver | Preuve manquante | Priorité |
|----------------|------------------|----------|
| | | |

### Risques Juridiques

| Risque | Probabilité | Impact | Mitigation |
|--------|-------------|--------|------------|
| | | | |

### Recommandations Stratégiques

1. **Priorité haute**: ...
2. **Avant consultation avocat**: ...
3. **Actions immédiates**: ...

### Questions pour l'Avocat

1. [Question juridique spécifique]
2. [Question sur la stratégie]
3. [Question sur les délais]
```

## Délais de Prescription

### Droit Civil (Québec)

| Type d'action | Délai |
|---------------|-------|
| Responsabilité contractuelle | 3 ans |
| Responsabilité extracontractuelle | 3 ans |
| Droit réel immobilier | 10 ans |

### Droit Pénal

| Infraction | Délai |
|------------|-------|
| Acte criminel | Variable/aucun |
| Infraction sommaire | 6 mois généralement |

> **Important**: Les délais commencent généralement à la découverte du préjudice.

## Préparation pour l'Avocat

### Documents à Préparer

1. **Chronologie des faits** (voir Timeline Builder)
2. **Inventaire des preuves** avec scores
3. **Résumé exécutif** (1-2 pages)
4. **Questions spécifiques** préparées
5. **Objectifs** clairement définis

### Questions à Poser

> "Quelle est la force de mon dossier?"
> "Quels sont mes recours possibles?"
> "Quels sont les risques?"
> "Quels sont les coûts estimés?"
> "Quels sont les délais?"
> "Qu'est-ce qui manque à mon dossier?"

## Ressources

- `references/legal-frameworks.md` - Cadres juridiques applicables
- `references/precedents.md` - Cas de jurisprudence pertinents
- `scripts/legal_scorer.py` - Calcul automatique des scores
