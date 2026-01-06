---
name: narcissistic-pattern-detector
description: |
  Ce skill détecte les patterns de comportement narcissique dans les communications écrites.
  Utiliser quand l'utilisateur demande: "analyse narcissique", "détecter manipulation",
  "patterns narcissiques", "identifier NPD", "comportement toxique", "red flags narcissisme",
  "analyser emails manipulateurs", "trouver signes narcissisme".
---

# Narcissistic Pattern Detector

Skill d'analyse pour identifier les patterns de Trouble de la Personnalité Narcissique (NPD)
dans les communications professionnelles et personnelles.

## Fondements Théoriques

### Critères DSM-5 du NPD (5+ requis)

1. **Grandiosité** - Sens exagéré de sa propre importance
2. **Fantasmes** - Préoccupation par fantasmes de succès illimité, pouvoir
3. **Spécialité** - Croyance d'être "spécial" et unique
4. **Admiration excessive** - Besoin constant d'admiration
5. **Sentiment de droit** - Attentes déraisonnables de traitement favorable
6. **Exploitation** - Exploitation interpersonnelle pour atteindre ses fins
7. **Manque d'empathie** - Incapacité de reconnaître les sentiments d'autrui
8. **Envie** - Envieux des autres ou croit que les autres l'envient
9. **Arrogance** - Comportements ou attitudes arrogants et hautains

## Patterns à Détecter dans les Communications

### Pattern 1: Grandiosité Linguistique

**Marqueurs:**
- Usage excessif de "je", "moi", "mon"
- Minimisation des contributions d'autrui
- Auto-attribution de tous les succès
- Langage superlatif pour soi ("le meilleur", "le seul qui...")

**Exemple:**
> "C'est MOI qui ai bâti cette entreprise. Sans moi, vous ne seriez RIEN."

### Pattern 2: Dévaluation/Idéalisation

**Cycle caractéristique:**
1. Idéalisation initiale ("Tu es le meilleur partenaire")
2. Dévaluation progressive ("Tu ne comprends jamais rien")
3. Discard ("Tu n'as jamais été à la hauteur")

**Marqueurs dans les emails:**
- Changements brusques de ton
- Contradictions entre messages proches dans le temps
- Compliments suivis d'insultes déguisées

### Pattern 3: Projection

**Définition:** Attribuer à autrui ses propres défauts et comportements.

**Exemple:**
> "C'est TOI qui manipules tout le monde" (dit par le manipulateur)
> "Tu es obsédé par l'argent" (dit par celui qui exploite financièrement)

### Pattern 4: Word Salad (Salade de Mots)

**Caractéristiques:**
- Réponses qui ne répondent pas à la question
- Changements de sujet constants
- Contradictions logiques dans le même paragraphe
- Création délibérée de confusion

### Pattern 5: DARVO

**Deny-Attack-Reverse Victim and Offender:**
1. Nier le comportement problématique
2. Attaquer la crédibilité de l'accusateur
3. Inverser les rôles victime/agresseur

## Processus d'Analyse

### Étape 1: Collecte

```
Collecter toutes les communications de la personne analysée:
- Emails
- Messages texte
- Transcripts de réunions
- Documents écrits
```

### Étape 2: Codage

Pour chaque communication, identifier:
- [ ] Présence de grandiosité (score 0-3)
- [ ] Dévaluation d'autrui (score 0-3)
- [ ] Projection identifiée (oui/non + citation)
- [ ] Word salad détecté (oui/non)
- [ ] DARVO présent (oui/non)
- [ ] Manque d'empathie démontré (citations)
- [ ] Exploitation visible (contexte)

### Étape 3: Corrélation Temporelle

Mapper les patterns sur une timeline pour identifier:
- Cycles d'idéalisation/dévaluation
- Escalade des comportements
- Triggers des épisodes narcissiques

### Étape 4: Scoring

| Pattern | Fréquence | Sévérité | Score |
|---------|-----------|----------|-------|
| Grandiosité | Haute/Moyenne/Basse | 1-3 | |
| Dévaluation | Haute/Moyenne/Basse | 1-3 | |
| DARVO | Haute/Moyenne/Basse | 1-3 | |
| Projection | Haute/Moyenne/Basse | 1-3 | |
| Word Salad | Haute/Moyenne/Basse | 1-3 | |

**Score total > 12**: Pattern narcissique hautement probable
**Score 8-12**: Pattern narcissique possible
**Score < 8**: Insuffisant pour conclure

## Output Format

```markdown
## Analyse Narcissique - [Sujet]

### Résumé Exécutif
[1-2 phrases sur les findings principaux]

### Patterns Identifiés
1. [Pattern] - [Fréquence] - [Citations]
2. ...

### Preuves Clés
| Date | Source | Citation | Pattern |
|------|--------|----------|---------|
| | | | |

### Score Global: X/15
[Interprétation]

### Recommandations
- ...
```

## Ressources Additionnelles

- Pour patterns détaillés: voir `references/patterns-detailles.md`
- Pour exemples annotés: voir `references/exemples-annotes.md`
- Pour script d'analyse automatique: voir `scripts/analyze.py`

## Avertissement

Cette analyse est un outil d'aide à la compréhension, pas un diagnostic clinique.
Seul un professionnel de santé mentale peut diagnostiquer un NPD.
