---
name: witness-statement-analyzer
description: |
  Ce skill analyse et organise les témoignages dans les cas de manipulation.
  Utiliser quand l'utilisateur demande: "témoignage", "déclaration témoin",
  "ce qu'il a dit", "version des faits", "contradictions témoignages",
  "qui peut confirmer", "corroborer histoire", "crédibilité témoin".
---

# Witness Statement Analyzer

Skill pour analyser, comparer et évaluer les témoignages dans les situations
de manipulation narcissique.

## Objectifs

1. **Collecter** les témoignages de manière structurée
2. **Analyser** la cohérence et crédibilité
3. **Comparer** les versions entre témoins
4. **Identifier** corroborations et contradictions
5. **Évaluer** la force probante

## Types de Témoins

### 1. Témoins Directs

Ont assisté aux événements en personne.

| Critère | Impact sur valeur |
|---------|-------------------|
| Présent lors des faits | ++ |
| Pas de lien avec parties | ++ |
| Détails précis et vérifiables | ++ |
| Témoignage contemporain | ++ |

### 2. Témoins Indirects

Ont entendu parler des événements.

| Critère | Impact sur valeur |
|---------|-------------------|
| Source directe identifiée | + |
| Cohérent avec autres preuves | + |
| Contemporain des faits | + |
| Ouï-dire (source non identifiée) | - |

### 3. Témoins de Caractère

Peuvent attester des patterns comportementaux.

| Critère | Impact sur valeur |
|---------|-------------------|
| Connaît la personne depuis longtemps | + |
| A observé comportements similaires | + |
| Indépendant des faits spécifiques | +/- |

### 4. Témoins Experts

Professionnels pouvant contextualiser.

| Type | Apport |
|------|--------|
| Psychologue | Validation patterns NPD |
| Comptable | Analyse financière |
| Avocat | Implications légales |

## Template de Déclaration

```
DÉCLARATION DE TÉMOIN
====================

INFORMATIONS DU TÉMOIN
─────────────────────
Nom complet: _______________
Date de naissance: _______________
Adresse: _______________
Relation avec les parties: _______________
Contact: _______________

CONTEXTE
────────
Date de la déclaration: _______________
Lieu: _______________
Recueillie par: _______________

DÉCLARATION
───────────
[Texte libre du témoin, dans ses propres mots]

Je déclare que les informations ci-dessus sont vraies et exactes
au meilleur de ma connaissance.

Signature: _______________
Date: _______________

NOTES DU COLLECTEUR
───────────────────
[Observations sur le témoin, son attitude, hésitations, etc.]
```

## Analyse de Crédibilité

### Critères d'Évaluation

| Critère | Score 1-5 | Observations |
|---------|-----------|--------------|
| **Cohérence interne** | | Pas de contradictions |
| **Détails vérifiables** | | Faits pouvant être confirmés |
| **Spontanéité** | | Réponses naturelles |
| **Neutralité apparente** | | Pas de parti pris évident |
| **Contemporanéité** | | Proche des faits |
| **Corroboration** | | Confirmé par autres sources |

### Calcul du Score

```
Score total / 30 × 100 = % de crédibilité

> 80%: Témoin très crédible
60-80%: Témoin crédible
40-60%: Crédibilité à vérifier
< 40%: Témoin peu fiable
```

### Red Flags de Crédibilité

| Signal | Signification |
|--------|---------------|
| Changements de version | Possible fabrication |
| Détails impossibles | Exagération ou mensonge |
| Trop parfait | Possiblement préparé |
| Intérêt personnel | Biais potentiel |
| Hostilité visible | Motivation de vengeance |
| Refus de détailler | Possible dissimulation |

## Comparaison des Témoignages

### Matrice de Cohérence

```
         | Témoin A | Témoin B | Témoin C | Documents |
─────────────────────────────────────────────────────────
Fait 1   |    ✓     |    ✓     |    ?     |     ✓     |
Fait 2   |    ✓     |    ✗     |    ✓     |     ✓     |
Fait 3   |    ✓     |    ✓     |    ✓     |     -     |
Date     |    ✓     |    ~     |    ✓     |     ✓     |
Lieu     |    ✓     |    ✓     |    ✓     |     ✓     |

✓ = Confirme  ✗ = Contredit  ? = Ne sait pas  ~ = Approximatif  - = N/A
```

### Analyse des Divergences

```
DIVERGENCE #___

Fait concerné: _______________

Version Témoin A: _______________
Version Témoin B: _______________

Type de divergence:
[ ] Contradiction directe
[ ] Détail différent (mineur)
[ ] Omission (l'un ne mentionne pas)
[ ] Interprétation différente

Résolution possible:
[ ] Perspective différente (même fait)
[ ] Erreur de mémoire probable
[ ] Mensonge probable (qui?)
[ ] Impossible à résoudre

Impact sur le dossier: [Faible/Moyen/Fort]
```

## Template d'Analyse Complète

```markdown
## Analyse des Témoignages - [Contexte]

### Témoins Identifiés

| # | Nom | Type | Relation | Crédibilité |
|---|-----|------|----------|-------------|
| 1 | | Direct/Indirect | | %|
| 2 | | | | |

### Résumé par Témoin

#### Témoin 1: [Nom]

**Profil**
- Relation: ...
- Connaissance des faits: ...
- Biais potentiel: ...

**Points clés du témoignage**
1. ...
2. ...

**Évaluation crédibilité**: X/30 (Y%)

#### Témoin 2: [Nom]
...

### Matrice de Cohérence

[Tableau de comparaison]

### Points Corroborés

| Fait | Corroboré par | Force |
|------|---------------|-------|
| | | |

### Divergences Identifiées

#### Divergence #1
- **Fait**: ...
- **Versions**: ...
- **Analyse**: ...
- **Impact**: ...

### Témoins Manquants

| Personne | Pourrait témoigner sur | Pourquoi manquant |
|----------|------------------------|-------------------|
| | | |

### Synthèse

**Forces du dossier testimonial**:
1. ...

**Faiblesses**:
1. ...

### Recommandations

1. Témoins à recontacter: ...
2. Témoins à rechercher: ...
3. Points à clarifier: ...
```

## Gestion des Témoins Hostiles

### Flying Monkeys

Témoins manipulés par le narcissique.

**Identification:**
- Répète verbatim les arguments du N
- Information impossible à connaître autrement
- Hostilité disproportionnée

**Stratégie:**
- Documenter leurs déclarations
- Identifier la source de leur information
- Ne pas confronter directement

### Témoins Intimidés

**Signes:**
- Hésitation soudaine
- Rétractation de déclarations antérieures
- Peur visible

**Stratégie:**
- Rassurer sur la confidentialité
- Documenter les déclarations originales
- Considérer protection légale

## Questions d'Entrevue

### Ouverture

> "Pouvez-vous me raconter ce que vous avez observé, dans vos propres mots?"

### Précision

> "Quand exactement cela s'est-il passé?"
> "Où étiez-vous physiquement?"
> "Qui d'autre était présent?"

### Vérification

> "Comment savez-vous cela?"
> "L'avez-vous vu directement ou on vous l'a raconté?"
> "Avez-vous des preuves de ce que vous décrivez?"

### Contradiction (si nécessaire)

> "[Autre source] indique que [version différente]. Pouvez-vous expliquer?"

## Ressources

- `references/interview-techniques.md` - Techniques d'entrevue
- `references/credibility-assessment.md` - Évaluation de crédibilité
- `scripts/testimony_comparer.py` - Comparaison automatique
