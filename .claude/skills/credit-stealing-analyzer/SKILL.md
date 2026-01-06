---
name: credit-stealing-analyzer
description: |
  Ce skill analyse l'appropriation du mérite d'autrui par le narcissique.
  Utiliser quand l'utilisateur demande: "vol de crédit", "il s'attribue mon travail",
  "appropriation mérite", "prend le crédit", "c'est grâce à lui soi-disant",
  "mes idées deviennent les siennes", "invisible contributor", "pas reconnu".
---

# Credit Stealing Analyzer

Skill pour identifier et documenter l'appropriation systématique du mérite
d'autrui - comportement narcissique classique.

## Qu'est-ce que le Credit Stealing?

**Credit Stealing**: Appropriation des succès, idées et contributions des autres
pour alimenter sa propre image et son narcissistic supply.

**Motivation narcissique:**
- Maintenir image de supériorité
- Obtenir admiration (supply)
- Minimiser les autres (maintenir contrôle)
- Justifier position/avantages

## Formes d'Appropriation

### 1. Vol d'Idées Direct

**Pattern:**
> Réunion: Vous proposez idée X
> Plus tard: "J'ai eu une idée géniale: X"
> Résultat: Vous n'êtes pas crédité

**Variantes:**
- Reformuler votre idée comme la sienne
- Présenter en votre absence
- Ajouter détail mineur pour "personnaliser"

### 2. Appropriation de Projets

**Pattern:**
- Projet réalisé par équipe/individu
- Présenté comme "mon projet"
- Contributors invisibilisés

**Exemple:**
> "MON entreprise" (construite par plusieurs)
> "MON système" (développé par d'autres)

### 3. Réécriture Historique

**Pattern:**
- Succès passés réattribués
- "J'étais là depuis le début" (faux)
- Minimisation des autres fondateurs

### 4. Credit Sharing Sélectif

**Pattern:**
- Succès = "J'ai fait"
- Échecs = "Nous avons fait" ou "Ils ont fait"

### 5. Invisibilisation

**Pattern:**
- Ne jamais mentionner les contributions
- "Je ne me souviens pas qui a suggéré ça"
- Oublier systématiquement certaines personnes

## Documentation du Credit Stealing

### Template d'Incident

```
INCIDENT #___

DATE: _______________
CONTEXTE: _______________

CONTRIBUTION ORIGINALE:
- Auteur réel: _______________
- Date: _______________
- Nature: [Idée/Projet/Travail/Code/Stratégie]
- Description: _______________
- Témoins: _______________

APPROPRIATION:
- Par qui: _______________
- Date: _______________
- Comment: [Présentation/Email/Réunion/Document]
- Citation exacte: "_______________"
- Audience: _______________

PREUVES DE L'ORIGINALITÉ:
- Emails antérieurs: [Oui/Non] - Date: ___
- Documents datés: [Oui/Non] - Ref: ___
- Témoins: [Oui/Non] - Noms: ___
- Autres: _______________

RECONNAISSANCE DONNÉE: [Oui/Non/Partielle]
Si non: Comment ça a été présenté: _______________
```

### Suivi Cumulatif

| # | Contribution | Auteur | Date | Approprié par | Preuve |
|---|--------------|--------|------|---------------|--------|
| 1 | | | | | |
| 2 | | | | | |

## Patterns à Identifier

### Pattern 1: Le Présentateur

Toujours celui qui présente les résultats (donc associé aux succès)
même quand le travail est fait par d'autres.

### Pattern 2: Le Filtre

Toutes les informations passent par lui, permettant reformulation
et réattribution.

### Pattern 3: L'Historien

Réécrit l'histoire de l'entreprise/projet en se positionnant
comme figure centrale.

### Pattern 4: Le Minimiseur

Reconnaît les contributions mais les minimise:
- "Tu as aidé" vs "Tu as fait"
- "On a travaillé ensemble" (60-40 devient 50-50 devient "je")

## Scoring Credit Stealing

| Critère | Score 0-3 |
|---------|-----------|
| Incidents multiples documentés (>3) | |
| Pattern systématique (même victime) | |
| Absence de reconnaissance malgré rappels | |
| Réécriture historique prouvée | |
| Témoins confirmant l'appropriation | |
| Impact sur carrière/réputation de la victime | |

**Score > 12**: Credit stealing systémique
**Score 8-12**: Pattern de credit stealing
**Score < 8**: Incidents isolés

## Output Format

```markdown
## Analyse Credit Stealing - [Sujet/Période]

### Vue d'Ensemble

| Statistique | Valeur |
|-------------|--------|
| Incidents documentés | |
| Période | |
| Victimes identifiées | |
| Valeur estimée appropriée | |

### Incidents Détaillés

#### Incident #1: [Titre]
- **Contribution originale**: ...
- **Auteur**: ...
- **Date création**: ...
- **Appropriation par**: ...
- **Date appropriation**: ...
- **Méthode**: ...
- **Preuves**: ...

### Pattern Global

[Description du pattern récurrent]

### Impact

- Sur [Personne X]: ...
- Sur l'entreprise: ...
- Valeur totale appropriée: ...

### Score: X/18

### Recommandations
1. Documentation future: ...
2. Confrontation: ...
3. Protection: ...
```

## Contre-Mesures

### 1. Documentation Préventive

**Avant de partager une idée:**
- Email à soi-même daté
- Document daté sur cloud
- Partager par écrit (trace)

**Exemple:**
> Envoyer email avant réunion:
> "Voici les points que je vais présenter: [idées]"

### 2. Créer des Traces

- Toujours communiquer par écrit (CC pertinent)
- Dater et signer les documents
- Impliquer témoins dans les discussions importantes

### 3. Réclamer le Crédit Poliment

> "Merci d'avoir présenté l'idée que j'avais proposée en [date].
> Pour le suivi, je peux prendre le lead sur l'implémentation?"

### 4. Confrontation Documentée

> Email:
> "Je note que [projet X] a été présenté comme ton initiative.
> Pour rappel, j'ai proposé cette approche le [date] (voir email joint).
> Comment souhaites-tu que nous présentions cela à l'équipe?"

### 5. Escalade si Nécessaire

Si le pattern persiste:
- Documentation complète
- Présentation à RH/supérieur
- Ou conseil juridique si impact significatif

## Ressources

- `references/documentation-credit.md` - Méthodes de documentation
- `references/confrontation-scripts.md` - Scripts de confrontation
- `scripts/contribution_tracker.py` - Tracker de contributions
