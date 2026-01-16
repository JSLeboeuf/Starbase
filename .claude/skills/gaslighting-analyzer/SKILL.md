---
name: gaslighting-analyzer
description: |
  Ce skill détecte et analyse le gaslighting dans les communications.
  Utiliser quand l'utilisateur demande: "détecter gaslighting", "réécriture histoire",
  "manipulation réalité", "faire douter", "ça ne s'est jamais passé comme ça",
  "tu inventes", "analyser distorsion", "négation des faits", "mémoire manipulée".
---

# Gaslighting Analyzer

Skill spécialisé dans la détection du gaslighting - forme de manipulation psychologique
visant à faire douter la victime de sa propre perception de la réalité.

## Définition et Mécanisme

**Gaslighting**: Manipulation psychologique consistant à:
1. Nier des événements qui se sont produits
2. Réécrire l'histoire pour servir ses intérêts
3. Faire douter la victime de sa mémoire/perception
4. Invalider les émotions et expériences d'autrui

**Origine**: Du film "Gaslight" (1944) où un mari manipule sa femme pour lui faire croire qu'elle devient folle.

## Les 7 Techniques de Gaslighting

### 1. Négation Directe
**"Ça ne s'est jamais passé"**

Marqueurs:
- "Tu inventes"
- "Je n'ai jamais dit ça"
- "Tu délires complètement"
- "Ta mémoire te joue des tours"

**Exemple:**
> Email du 15 mars: "Je m'engage à te verser 30% des profits"
> Email du 20 juin: "Je n'ai JAMAIS promis ça, tu as dû mal comprendre"

### 2. Minimisation
**"Tu exagères"**

Marqueurs:
- "Ce n'est pas si grave"
- "Tu en fais tout un plat"
- "Tu es trop sensible"
- "C'était juste une blague"

### 3. Diversion
**Changer de sujet pour éviter la confrontation**

Marqueurs:
- Contre-accusations ("Et toi alors?")
- Changement de sujet abrupt
- Attaques personnelles au lieu de répondre
- Création de nouveaux conflits

### 4. Réécriture de l'Histoire
**Modifier les faits passés**

Marqueurs:
- Versions contradictoires des mêmes événements
- Ajout de détails inexistants
- Omission sélective de faits importants
- "Tu te souviens mal, voici ce qui s'est vraiment passé"

### 5. Invalidation Émotionnelle
**"Tu ne devrais pas te sentir comme ça"**

Marqueurs:
- "Tu es trop émotif"
- "Tu réagis de façon disproportionnée"
- "Une personne normale ne réagirait pas ainsi"
- "Tu as un problème"

### 6. Isolation
**Couper des sources de validation externe**

Marqueurs:
- Critique des amis/famille
- "Personne ne te croira"
- "Les autres pensent comme moi"
- Création de méfiance envers les alliés

### 7. Projection de la Manipulation
**"C'est TOI qui me manipules"**

Marqueurs:
- Accuser l'autre de gaslighting
- "Tu essaies de me rendre fou"
- Renversement systématique des rôles

## Processus d'Analyse

### Phase 1: Établir la Baseline Factuelle

```
1. Collecter les FAITS documentés:
   - Emails avec dates/heures
   - Contrats signés
   - Témoignages tiers
   - Preuves matérielles

2. Créer une timeline factuelle vérifiable
```

### Phase 2: Identifier les Contradictions

| Date | Affirmation | Contradiction | Source |
|------|-------------|---------------|--------|
| | | | |

### Phase 3: Analyser les Patterns Linguistiques

**Red Flags dans le langage:**
- Utilisation fréquente de "tu" accusateur
- Généralisations ("tu TOUJOURS", "tu JAMAIS")
- Certitude excessive sur la mémoire d'autrui
- Dévalorisation systématique des perceptions

### Phase 4: Corroboration

Pour chaque incident de gaslighting suspecté:
1. Y a-t-il des preuves documentées?
2. Y a-t-il des témoins?
3. Y a-t-il un pattern répétitif?
4. Qui bénéficie de cette version des faits?

## Scoring du Gaslighting

| Critère | Score 0-3 |
|---------|-----------|
| Négation de faits documentés | |
| Contradictions avec preuves écrites | |
| Invalidation émotionnelle répétée | |
| Réécriture d'événements prouvés | |
| Accusations de folie/délire | |
| Pattern répétitif (>3 incidents) | |

**Score > 12**: Gaslighting systématique
**Score 8-12**: Gaslighting probable
**Score 4-8**: Indicateurs présents
**Score < 4**: Insuffisant

## Output Format

```markdown
## Analyse Gaslighting - [Communication/Période]

### Incidents Documentés

#### Incident 1: [Date]
- **Fait établi**: [preuve]
- **Version gaslightée**: [citation]
- **Contradiction**: [explication]
- **Technique utilisée**: [type]

### Tableau Comparatif Réalité vs Version Manipulée

| Fait Réel (prouvé) | Version du Gaslighter | Preuve |
|--------------------|----------------------|--------|
| | | |

### Pattern Global
[Description du pattern répétitif identifié]

### Impact Documenté
[Comment le gaslighting affecte la victime/situation]

### Score: X/18
```

## Scripts Utilitaires

Voir `scripts/compare_versions.py` pour comparer automatiquement les versions
contradictoires d'événements dans un corpus d'emails.

## Ressources

- `references/techniques-gaslighting.md` - Techniques détaillées
- `references/reponses-gaslighting.md` - Comment répondre
- `references/documentation-preuve.md` - Documenter pour preuves légales
