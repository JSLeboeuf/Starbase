---
name: darvo-detector
description: |
  Ce skill détecte le pattern DARVO (Deny, Attack, Reverse Victim and Offender).
  Utiliser quand l'utilisateur demande: "détecter DARVO", "inversion victime agresseur",
  "il se fait passer pour la victime", "retournement de situation", "c'est moi la victime",
  "il m'accuse de ce qu'il fait", "renversement des rôles", "fausse victimisation".
---

# DARVO Detector

Skill d'identification du pattern DARVO, tactique de manipulation où l'agresseur
se positionne comme victime.

## Qu'est-ce que DARVO?

**DARVO** est un acronyme créé par la psychologue Jennifer Freyd:

- **D**eny (Nier)
- **A**ttack (Attaquer)
- **R**everse **V**ictim and **O**ffender (Inverser Victime et Agresseur)

C'est une réaction défensive typique des agresseurs confrontés à leurs actes.

## Les 3 Phases du DARVO

### Phase 1: DENY (Nier)

**Objectif**: Rejeter toute responsabilité

**Marqueurs linguistiques:**
- "Je n'ai jamais fait ça"
- "C'est complètement faux"
- "Tu inventes"
- "Ça ne s'est pas passé comme ça"
- "Tu déformes tout"

**Exemple dans emails business:**
> "Je n'ai JAMAIS dit que tu n'aurais pas de parts. C'est une invention pure."
> (Malgré des emails prouvant le contraire)

### Phase 2: ATTACK (Attaquer)

**Objectif**: Discréditer l'accusateur

**Types d'attaques:**

1. **Attaque de crédibilité**
   - "Tu as des problèmes de mémoire"
   - "Tu es instable"
   - "Personne ne te croit"

2. **Attaque de motivation**
   - "Tu fais ça pour l'argent"
   - "Tu cherches à me nuire"
   - "Tu es jaloux de ma réussite"

3. **Attaque de caractère**
   - "Tu as toujours été comme ça"
   - "Tu es toxique"
   - "Tu manipules tout le monde"

4. **Menaces voilées**
   - "Tu vas le regretter"
   - "Je pourrais raconter des choses sur toi"
   - "Tu ne sais pas à qui tu t'attaques"

### Phase 3: REVERSE VICTIM AND OFFENDER

**Objectif**: Se positionner comme la vraie victime

**Marqueurs:**
- "C'est MOI qui souffre ici"
- "Tu me persécutes"
- "Je suis la victime de tes attaques"
- "Tu me harcèles"
- "Après tout ce que j'ai fait pour toi"

**Narratifs typiques:**
- "J'ai tout sacrifié pour cette entreprise et c'est comme ça que tu me remercies"
- "Je suis épuisé par tes accusations constantes"
- "Tu détruis ma réputation"

## Analyse d'une Séquence DARVO

### Template d'Identification

```
CONTEXTE:
- Accusation initiale: [Qu'est-ce qui a été reproché?]
- Preuves disponibles: [Quelles preuves existent?]
- Réponse analysée: [Le message/communication à analyser]

PHASE DENY:
- Citation: "..."
- Fait nié: [Quel fait spécifique est nié?]
- Preuve contradictoire: [Quelle preuve contredit ce déni?]

PHASE ATTACK:
- Type d'attaque: [Crédibilité/Motivation/Caractère/Menace]
- Citation: "..."
- Cible de l'attaque: [Quoi/Qui est attaqué?]

PHASE REVERSE:
- Citation: "..."
- Rôle revendiqué: [Comment se présente-t-il comme victime?]
- Incohérence: [En quoi est-ce incohérent avec les faits?]
```

## Patterns DARVO en Business

### Contexte: Conflit d'Actionnariat

**Situation typique:**
Actionnaire majoritaire confronté sur des irrégularités

**DARVO type:**

| Phase | Exemple |
|-------|---------|
| DENY | "Les comptes sont parfaitement réguliers" |
| ATTACK | "Tu n'as jamais compris la finance, tu fais des accusations sans fondement" |
| REVERSE | "Je suis harcelé par un actionnaire qui veut détruire l'entreprise que j'ai construite" |

### Contexte: Cautionnement Inégal

**DARVO type:**

| Phase | Exemple |
|-------|---------|
| DENY | "Tout le monde a les mêmes conditions" |
| ATTACK | "Tu cherches des problèmes où il n'y en a pas, tu es paranoïaque" |
| REVERSE | "Je prends tous les risques pendant que tu critiques" |

## Scoring DARVO

| Élément | Présent | Score |
|---------|---------|-------|
| Déni explicite d'un fait prouvé | Oui/Non | 0-3 |
| Attaque sur la crédibilité | Oui/Non | 0-3 |
| Attaque sur les motivations | Oui/Non | 0-3 |
| Auto-victimisation | Oui/Non | 0-3 |
| Séquence D→A→R complète | Oui/Non | 0-3 |
| Pattern répété (>2 fois) | Oui/Non | 0-3 |

**Score > 12**: DARVO systématique
**Score 8-12**: DARVO probable
**Score < 8**: Éléments isolés

## Output Format

```markdown
## Analyse DARVO - [Source/Date]

### Contexte
- **Accusation originale**: ...
- **Preuves de l'accusation**: ...

### Séquence DARVO Identifiée

#### DENY
> "[Citation exacte]"
- Fait nié: ...
- Preuve contradictoire: ...

#### ATTACK
> "[Citation exacte]"
- Type: [Crédibilité/Motivation/Caractère]
- Cible: ...

#### REVERSE VICTIM/OFFENDER
> "[Citation exacte]"
- Rôle revendiqué: ...
- Incohérence factuelle: ...

### Analyse
[Pattern répétitif? Escalade? Contexte?]

### Score DARVO: X/18
```

## Contre-Mesures

Face au DARVO:
1. **Documenter** - Garder traces écrites de tout
2. **Ne pas JADE** - Ne pas Justify, Argue, Defend, Explain
3. **Revenir aux faits** - "Voici le document qui prouve X"
4. **Témoins** - Impliquer des tiers neutres
5. **Écrits** - Privilégier communication écrite

## Ressources

- `references/darvo-exemples.md` - Exemples détaillés
- `references/contre-darvo.md` - Stratégies de réponse
- `scripts/darvo_sequence.py` - Détection automatique de séquences
