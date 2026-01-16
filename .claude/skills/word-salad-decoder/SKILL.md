---
name: word-salad-decoder
description: |
  Ce skill décode le "word salad" - communication confuse intentionnelle des narcissiques.
  Utiliser quand l'utilisateur demande: "décoder word salad", "salade de mots",
  "communication confuse", "il ne répond jamais vraiment", "réponse qui n'a pas de sens",
  "confusion verbale", "circular talking", "il tourne autour du pot", "non-réponse".
---

# Word Salad Decoder

Skill pour analyser et décoder le "word salad" narcissique - technique de confusion
verbale délibérée visant à épuiser l'interlocuteur et éviter la responsabilité.

## Qu'est-ce que le Word Salad?

**Word Salad (Salade de Mots)**: Communication délibérément confuse caractérisée par:
- Réponses qui ne répondent pas à la question
- Logique circulaire
- Changements de sujet constants
- Contradictions internes
- Sur-complication de sujets simples

**Objectif**: Créer confusion et épuisement pour éviter toute accountability.

## Les 8 Techniques de Word Salad

### 1. Circular Talking (Discours Circulaire)

**Définition**: Tourner en rond sans jamais arriver à une conclusion

**Pattern:**
```
Question → Réponse vague → Retour au début → Nouvelle tangente → Retour au début
```

**Exemple:**
> Q: "Pourquoi n'ai-je pas reçu ma part des bénéfices?"
> R: "Les bénéfices, c'est complexe. Il y a la situation du marché, et puis
> les investissements qu'on a faits. Tu sais comment c'est. Et les bénéfices,
> ça dépend de beaucoup de facteurs. Le marché surtout."

**Marqueurs:**
- Retour au point de départ
- Aucune information nouvelle
- Sentiment de déjà-vu

### 2. Moving the Goalposts (Déplacer les Critères)

**Définition**: Changer les critères de satisfaction à chaque réponse

**Exemple:**
> "Tu voulais les chiffres, les voici"
> "Ce ne sont pas les bons chiffres"
> "Voici les bons"
> "Mais pas dans le bon format"
> "Voici le bon format"
> "Mais c'est trop tard maintenant"

### 3. Gish Gallop

**Définition**: Submerger de multiples arguments faibles impossibles à tous réfuter

**Caractéristiques:**
- Avalanche de points différents
- Mélange vrai/faux/hors-sujet
- Impossible de tout adresser
- Victoire par épuisement

### 4. Non Sequitur

**Définition**: Conclusions qui ne suivent pas logiquement les prémisses

**Exemple:**
> "Puisque j'ai fondé l'entreprise, il est normal que je décide seul des salaires"
> (La fondation n'implique pas le pouvoir unilatéral sur les salaires)

### 5. Tu Quoque (Toi Aussi)

**Définition**: Dévier en accusant l'autre du même comportement

**Exemple:**
> Q: "Tu n'as pas respecté le contrat"
> R: "Et toi? Tu n'as pas toujours été parfait non plus!"

### 6. Strawman (Homme de Paille)

**Définition**: Déformer l'argument de l'autre pour le réfuter plus facilement

**Exemple:**
> Accusation réelle: "Tu n'as pas partagé les profits comme convenu"
> Strawman: "Tu m'accuses d'être un voleur! Comment oses-tu!"

### 7. Ad Hominem Déguisé

**Définition**: Attaquer la personne plutôt que l'argument, de façon subtile

**Exemple:**
> "Je comprends que quelqu'un avec ton parcours puisse voir les choses ainsi..."
> (Sous-entendu: tu n'es pas qualifié pour comprendre)

### 8. Faux Dilemme

**Définition**: Présenter seulement 2 options quand d'autres existent

**Exemple:**
> "Soit tu me fais confiance complètement, soit tu quittes l'entreprise"
> (Ignore: faire confiance avec vérification, renégocier, etc.)

## Processus de Décodage

### Étape 1: Isoler la Question Originale

```
Question claire posée: ________________________________
Réponse obtenue: ________________________________
La réponse répond-elle à la question? OUI / NON
```

### Étape 2: Identifier les Techniques

| Passage | Technique | Effet Recherché |
|---------|-----------|-----------------|
| "..." | Circular Talking | Éviter de répondre |
| "..." | Tu Quoque | Dévier la responsabilité |

### Étape 3: Extraire le Non-Dit

**Ce qui est dit**: "..."
**Ce qui est évité**: "..."
**Ce que ça révèle**: "..."

### Étape 4: Reformuler la Question

Après chaque word salad, reformuler la question de façon encore plus précise
et documentée pour forcer une vraie réponse.

## Scoring Word Salad

| Critère | Score 0-3 |
|---------|-----------|
| Réponse ne répond pas à la question | |
| Logique circulaire présente | |
| Changements de sujet (>2) | |
| Contradictions internes | |
| Attaques personnelles déguisées | |
| Faux dilemmes présentés | |

**Score > 12**: Word salad systématique
**Score 8-12**: Communication problématique
**Score < 8**: Confusion possible non intentionnelle

## Output Format

```markdown
## Analyse Word Salad - [Communication]

### Question Originale
> "[Question exacte posée]"

### Réponse Analysée
> "[Réponse complète]"

### Techniques Identifiées

| # | Passage | Technique | Objectif |
|---|---------|-----------|----------|
| 1 | "..." | [Type] | [But] |
| 2 | "..." | [Type] | [But] |

### Décodage

**Ce qui est dit**: ...
**Ce qui est évité**: ...
**Vraie réponse probable**: ...

### Questions de Suivi Recommandées
1. [Question précise fermée]
2. [Question avec deadline]
3. [Question nécessitant preuve documentaire]

### Score: X/18
```

## Contre-Mesures

### Technique du Disque Rayé

Répéter exactement la même question jusqu'à obtenir réponse:
> "Je comprends, mais ma question était: [répéter exactement]"

### Questions Fermées

Transformer questions ouvertes en questions oui/non:
> Au lieu de: "Que penses-tu des résultats?"
> Demander: "Les résultats montrent-ils une perte? Oui ou non?"

### Demander par Écrit

> "Peux-tu me répondre par email pour que j'aie une trace?"

### Deadline Explicite

> "J'ai besoin d'une réponse claire d'ici vendredi 17h, sans quoi je considérerai que..."

## Ressources

- `references/techniques-word-salad.md` - Techniques détaillées
- `references/reponses-efficaces.md` - Comment répondre
- `scripts/analyze_response.py` - Analyse automatique de cohérence
