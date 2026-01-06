---
name: power-dynamic-visualizer
description: |
  Ce skill visualise les dynamiques de pouvoir dans les relations professionnelles.
  Utiliser quand l'utilisateur demande: "dynamiques de pouvoir", "qui contrôle quoi",
  "rapport de force", "structure de pouvoir", "influence cachée", "qui décide vraiment",
  "cartographie influence", "asymétrie pouvoir", "analyse politique interne".
---

# Power Dynamic Visualizer

Skill pour analyser et visualiser les dynamiques de pouvoir dans les contextes
professionnels, particulièrement en cas de manipulation narcissique.

## Dimensions du Pouvoir

### 1. Pouvoir Formel

**Sources:**
- Titre/Position hiérarchique
- Parts/Actions détenues
- Pouvoir de signature
- Mandats officiels

### 2. Pouvoir Informel

**Sources:**
- Réseau relationnel
- Information détenue
- Expertise perçue
- Charisme/influence

### 3. Pouvoir Économique

**Sources:**
- Contrôle des finances
- Accès au capital
- Dépendance financière des autres
- Capacité de financement

### 4. Pouvoir Coercitif

**Sources:**
- Capacité de nuire
- Information compromettante
- Menaces (explicites ou implicites)
- Contrôle de ressources critiques

### 5. Pouvoir d'Obstruction

**Sources:**
- Droit de veto
- Capacité de bloquer
- Contrôle de goulots d'étranglement
- Position de "gatekeeper"

## Analyse des Dynamiques

### Template d'Analyse de Pouvoir

```
CONTEXTE: _______________
DATE D'ANALYSE: _______________

ACTEURS:
| Acteur | Position | Parts | Pouvoir Formel |
|--------|----------|-------|----------------|
| | | | |

MATRICE DE POUVOIR:

| Acteur | Formel | Informel | Économique | Coercitif | Obstruction | TOTAL |
|--------|--------|----------|------------|-----------|-------------|-------|
| A | /10 | /10 | /10 | /10 | /10 | /50 |
| B | /10 | /10 | /10 | /10 | /10 | /50 |

SOURCES DE POUVOIR DÉTAILLÉES:

Acteur A:
- Formel: [Sources]
- Informel: [Sources]
- Économique: [Sources]
- Coercitif: [Sources]
- Obstruction: [Sources]

DÉPENDANCES:
| De | Vers | Type | Intensité |
|----|------|------|-----------|
| A | B | Financière | Haute |
| B | A | Information | Moyenne |

ASYMÉTRIES CRITIQUES:
1. [Description]
2. [Description]
```

### Cartographie Relationnelle

```
RELATIONS DE POUVOIR:

[A] ====> [B]    (A domine B)
[C] <---> [D]    (Équilibre)
[E] - - -> [F]   (Influence subtile)

ALLIANCES:
[A]----[B]    (Alliance formelle)
[C]....[D]    (Alliance tacite)

CONFLITS:
[A] ><>< [B]  (Conflit ouvert)
[C] ~~~~ [D]  (Tension latente)
```

## Types de Dynamiques Narcissiques

### 1. Centralisation du Pouvoir

**Pattern:**
- Toutes les décisions passent par N
- Information filtrée par N
- Dépendance créée artificiellement

**Visualisation:**
```
     [B]
      |
[C]--[N]--[D]
      |
     [E]

N = point de passage obligé
```

### 2. Diviser pour Régner

**Pattern:**
- N crée conflits entre autres
- Alliances empêchées
- N seul "médiateur"

**Visualisation:**
```
[A] ><>< [B]
    \  /
     [N]    <- contrôle le conflit
    /  \
[C] ><>< [D]
```

### 3. Contrôle par la Dépendance

**Pattern:**
- Dépendance financière
- Dépendance informationnelle
- Dépendance émotionnelle

**Visualisation:**
```
[N] ==$$==> [A]  (A dépend financièrement de N)
[N] ==info=> [B] (B dépend de l'info de N)
```

### 4. Coalition Asymétrique

**Pattern:**
- N + alliés vs cibles isolées
- Votes/décisions préparés
- Opposition marginalisée

**Visualisation:**
```
Coalition: [N]----[FM1]----[FM2]
                  vs
           [Cible] (isolée)
```

## Scoring de Déséquilibre

| Dimension | Acteur Fort | Acteur Faible | Écart |
|-----------|-------------|---------------|-------|
| Formel | | | |
| Informel | | | |
| Économique | | | |
| Coercitif | | | |
| Obstruction | | | |

**Écart total > 20**: Déséquilibre critique
**Écart 10-20**: Déséquilibre significatif
**Écart < 10**: Relatif équilibre

## Output Format

```markdown
## Analyse Dynamiques de Pouvoir - [Contexte]

### Acteurs

| Acteur | Rôle Officiel | Parts | Description |
|--------|---------------|-------|-------------|
| | | | |

### Matrice de Pouvoir

| Acteur | Formel | Informel | Économique | Coercitif | Obstruction | TOTAL |
|--------|--------|----------|------------|-----------|-------------|-------|
| | | | | | | |

### Carte des Relations

```
[Diagramme ASCII]
```

### Sources de Pouvoir Détaillées

#### [Acteur Principal]
- **Pouvoir formel**: ...
- **Pouvoir informel**: ...
- **Pouvoir économique**: ...
- **Pouvoir coercitif**: ...
- **Pouvoir d'obstruction**: ...

### Dynamiques Identifiées

1. **[Type de dynamique]**
   - Description: ...
   - Impact: ...
   - Bénéficiaire: ...

### Dépendances Critiques

| De | Vers | Type | Effet |
|----|------|------|-------|
| | | | |

### Vulnérabilités

| Acteur | Vulnérabilité | Exploitée par |
|--------|---------------|---------------|
| | | |

### Recommandations Stratégiques

Pour rééquilibrer le pouvoir:
1. ...
2. ...
3. ...
```

## Applications Stratégiques

### 1. Identifier où Vous Êtes

- Votre score de pouvoir total
- Vos sources principales
- Vos dépendances critiques

### 2. Identifier les Leviers

- Quelles sources de pouvoir pouvez-vous développer?
- Quelles dépendances pouvez-vous réduire?
- Quelles alliances sont possibles?

### 3. Anticiper les Mouvements

- Comment le narcissique maintient-il son pouvoir?
- Quelles menaces représentez-vous?
- Quelles réactions attendre?

### 4. Planifier le Rééquilibrage

- Actions à court terme
- Actions à moyen terme
- Exit strategy si nécessaire

## Ressources

- `references/sources-pouvoir.md` - Sources de pouvoir détaillées
- `references/reequilibrage.md` - Stratégies de rééquilibrage
- `scripts/power_map.py` - Génération de cartes de pouvoir
