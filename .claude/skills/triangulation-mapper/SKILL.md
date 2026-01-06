---
name: triangulation-mapper
description: |
  Ce skill cartographie les triangulations narcissiques dans les relations.
  Utiliser quand l'utilisateur demande: "triangulation", "il monte les gens les uns contre les autres",
  "manipulation relationnelle", "diviser pour régner", "flying monkeys", "coalition contre moi",
  "il parle de moi aux autres", "rumeurs", "alliance toxique", "cartographier relations".
---

# Triangulation Mapper

Skill pour identifier et cartographier les triangulations narcissiques -
manipulation impliquant des tierces parties pour contrôler et déstabiliser.

## Qu'est-ce que la Triangulation?

**Triangulation**: Technique de manipulation où le narcissique implique une ou
plusieurs tierces parties pour:
- Créer jalousie/insécurité
- Valider sa position
- Isoler la cible
- Maintenir le contrôle
- Éviter la confrontation directe

## Types de Triangulation

### 1. Triangulation Romantique/Relationnelle

**Objectif**: Créer insécurité et compétition

**Exemple business:**
> "J'ai parlé avec [autre actionnaire] et lui comprend parfaitement ma vision,
> contrairement à toi qui bloques toujours tout."

### 2. Flying Monkeys (Singes Volants)

**Définition**: Personnes recrutées pour harceler/surveiller la cible

**Rôles possibles:**
- Espion (rapporte les faits et gestes)
- Messager (transmet les critiques)
- Défenseur (prend parti publiquement)
- Saboteur (nuit activement)

### 3. Triangulation par Comparaison

**Pattern:**
> "Avec [personne X], ça se passe toujours bien. Pourquoi avec toi c'est toujours compliqué?"

### 4. Triangulation d'Information

**Objectif**: Contrôler l'information entre les parties

**Pattern:**
- Dit à A que B a dit quelque chose
- Dit à B que A a dit autre chose
- Crée conflit entre A et B
- Se positionne en arbitre/victime

### 5. Triangulation de Coalition

**Objectif**: Créer une alliance contre la cible

**Exemple:**
- Réunions "informelles" excluant une personne
- Décisions prises "en petit comité"
- Front uni contre un actionnaire

## Cartographie des Triangulations

### Étape 1: Identifier les Acteurs

```
NARCISSIQUE (N): _______________
CIBLE (C): _______________
TIERS IMPLIQUÉS:
  - T1: _______________ [Rôle: Flying Monkey / Témoin / Neutre]
  - T2: _______________ [Rôle: ]
  - T3: _______________ [Rôle: ]
```

### Étape 2: Mapper les Communications

```
        [T1]
       /    \
      /      \
    [N]------[C]
      \      /
       \    /
        [T2]

Flèches:
→ Communication directe
⇢ Communication rapportée
⇠ Information manipulée
```

### Étape 3: Timeline des Triangulations

| Date | De | À | Message | Triangulation |
|------|-----|---|---------|---------------|
| | N | T1 | "C est impossible à gérer" | Recrutement FM |
| | T1 | C | "N m'a dit que tu..." | Transmission |
| | N | C | "Même T1 pense que..." | Validation externe |

### Étape 4: Identifier les Patterns

**Pattern 1: Divide & Conquer**
```
N dit à A: "B parle mal de toi"
N dit à B: "A parle mal de toi"
Résultat: A et B en conflit, N contrôle
```

**Pattern 2: Good Cop / Bad Cop**
```
N critique C directement
T1 "console" C en renforçant le message de N
Résultat: Message renforcé, N semble moins responsable
```

**Pattern 3: Isolation Progressive**
```
N recrute T1 contre C
N recrute T2 contre C
N recrute T3 contre C
Résultat: C isolé, sans alliés
```

## Scoring de Triangulation

| Indicateur | Score 0-3 |
|------------|-----------|
| Présence de flying monkeys identifiés | |
| Communications rapportées déformées | |
| Coalitions exclusives observées | |
| Comparaisons avec tiers pour dévaloriser | |
| Information contradictoire entre parties | |
| Isolation progressive documentée | |

**Score > 12**: Triangulation systémique
**Score 8-12**: Triangulation active
**Score < 8**: Indicateurs isolés

## Output Format

```markdown
## Cartographie Triangulation - [Contexte]

### Acteurs Identifiés

| Rôle | Personne | Fonction dans la triangulation |
|------|----------|-------------------------------|
| Narcissique | | |
| Cible | | |
| Flying Monkey 1 | | |
| Témoin passif | | |

### Schéma Relationnel

[Diagramme ASCII des relations]

### Incidents de Triangulation

#### Incident 1: [Date]
- **Type**: [Flying Monkey / Comparison / Information / Coalition]
- **Parties impliquées**: ...
- **Message transmis**: "..."
- **Message réel vs déformé**: ...
- **Impact sur la cible**: ...

### Patterns Identifiés
1. [Pattern avec fréquence]
2. ...

### Recommandations
- Personnes à informer directement (court-circuiter)
- Communications à documenter
- Alliés potentiels à préserver

### Score: X/18
```

## Contre-Mesures

### 1. Communication Directe

Toujours vérifier l'information à la source:
> "J'ai entendu que tu aurais dit X. Peux-tu me confirmer directement?"

### 2. Documentation des Sources

Pour chaque information rapportée, noter:
- Qui a dit
- Quand
- Contexte exact
- Témoin présent?

### 3. Groupe de Communication Ouvert

Privilégier communications de groupe (email CC all) plutôt que bilatérales.

### 4. Éducation des Tiers

Informer discrètement les flying monkeys potentiels:
> "Sais-tu que N dit des choses différentes à chacun?"

### 5. Grey Rock avec les FM

Réponses minimales, neutres, ennuyeuses aux flying monkeys.

## Ressources

- `references/flying-monkeys.md` - Identifier et gérer les FM
- `references/isolation-patterns.md` - Patterns d'isolation
- `scripts/relationship_map.py` - Générer cartes relationnelles
