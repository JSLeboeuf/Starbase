# 🎮 WAR GAME COMPLET - TOUTES LES OPTIONS
## Arbre de décision, simulations multi-parties, et stratégies

---

# PARTIE 1 : VOS OPTIONS DE DÉPART

## ARBRE DES OPTIONS INITIALES

```
                           VOUS (Jean-Samuel)
                                  |
         ┌────────────┬───────────┼───────────┬────────────┐
         |            |           |           |            |
      OPTION A     OPTION B    OPTION C    OPTION D     OPTION E
      REFUS       REFUS +     CONTRE-     ACCEPTER    NUCLÉAIRE
      TOTAL       ACTION      OFFRE       (17%)       (Sortie)
         |            |           |           |            |
    [Détails]    [Détails]   [Détails]   [Détails]    [Détails]
```

---

## OPTION A : REFUS TOTAL (Statu quo)

**Ce que vous dites** :
> "Non. Tu gardes ton 6% + 80k$/an. Fin de la discussion."

**Probabilité de succès** : 40%
**Risque** : Coalition contre vous
**Coût** : 0$

---

## OPTION B : REFUS + ACTION PRÉVENTIVE

**Ce que vous faites** :
1. Refuser par écrit
2. Parler à Cédric et Félix AVANT Jérôme
3. Demander convention d'actionnaire
4. Documenter tout

**Probabilité de succès** : 70%
**Risque** : Conflit ouvert
**Coût** : 0$ + temps

---

## OPTION C : CONTRE-OFFRES (5 variantes)

### C1 : 5% GRATUIT
> "Je te donne 5%. Va chercher le reste ailleurs."

### C2 : 5% CONDITIONNEL
> "5% avec vesting 4 ans + convention signée."

### C3 : 10% CONTRE SALAIRE + CLINIQUES
> "10% si tu coupes ton salaire et bâtis 10 cliniques en 5 ans."

### C4 : RACHAT AU MARCHÉ
> "Tu veux des parts? Rachète-les à 170k$/%. Cash."

### C5 : BONUS PERFORMANCE
> "Pas de parts, mais bonus de 50k$/clinique construite."

---

## OPTION D : ACCEPTER (17%)

**Ce que vous dites** :
> "OK, on fait le switch."

**Probabilité que ça s'arrête là** : 20%
**Risque** : Escalade garantie
**Coût** : 1,700,000$

---

## OPTION E : NUCLÉAIRE (Sortie)

**Ce que vous faites** :
1. Demander rachat de vos parts
2. Sortie complète de l'immobilier
3. Focus sur Veta uniquement

**Probabilité de paix** : 90%
**Coût** : Perte d'opportunité immobilier

---

# PARTIE 2 : RÉPONSES DE JÉRÔME

## MATRICE : VOS OPTIONS × RÉPONSES JÉRÔME

| Votre option | Jérôme accepte | Jérôme refuse | Jérôme escalade |
|--------------|----------------|---------------|-----------------|
| **A: Refus total** | 30% - Statu quo | 20% - Il part | 50% - Coalition |
| **B: Refus + action** | 50% - Statu quo | 20% - Il part | 30% - Conflit |
| **C1: 5% gratuit** | 40% - Satisfait | 40% - Veut plus | 20% - Escalade |
| **C2: 5% conditionnel** | 30% - Accepte | 50% - Refuse | 20% - Escalade |
| **C3: 10% + cliniques** | 20% - Accepte | 60% - Refuse | 20% - Négocie |
| **C4: Rachat marché** | 5% - Achète | 90% - Refuse | 5% - Escalade |
| **C5: Bonus perf** | 25% - Accepte | 50% - Refuse | 25% - Négocie |
| **D: Accepter 17%** | 80% - Satisfait court terme | N/A | 80% - Redemande |
| **E: Nucléaire** | N/A | N/A | N/A - Vous partez |

---

## ARBRE : SI JÉRÔME ACCEPTE

```
JÉRÔME ACCEPTE
      |
      ├── Court terme (0-6 mois)
      |         |
      |         └── Satisfait, coopère
      |
      ├── Moyen terme (6-18 mois)
      |         |
      |         ├── 30% - Reste satisfait
      |         └── 70% - Nouvelle demande
      |
      └── Long terme (18+ mois)
                |
                ├── 20% - Partenaire loyal
                └── 80% - Escalade continue
```

---

## ARBRE : SI JÉRÔME REFUSE

```
JÉRÔME REFUSE
      |
      ├── Option 1 : Il part (20%)
      |         |
      |         ├── Vous : Trouvez remplacement
      |         └── Lui : Perd 6% + 80k$/an
      |
      ├── Option 2 : Il accepte statu quo (30%)
      |         |
      |         └── Frustré mais reste
      |
      └── Option 3 : Il escalade (50%)
                |
                ├── Monte Félix contre vous
                ├── Monte Cédric contre vous
                └── Crée coalition
```

---

## ARBRE : SI JÉRÔME ESCALADE

```
JÉRÔME ESCALADE
      |
      ├── Tactique 1 : Monte Félix
      |         |
      |         ├── Félix vous soutient (40%)
      |         ├── Félix reste neutre (30%)
      |         └── Félix soutient Jérôme (30%)
      |
      ├── Tactique 2 : Monte Cédric
      |         |
      |         ├── Cédric vous soutient (50%)
      |         ├── Cédric reste neutre (30%)
      |         └── Cédric soutient Jérôme (20%)
      |
      └── Tactique 3 : Coalition
                |
                ├── Coalition échoue (60%)
                └── Coalition réussit (40%)
                          |
                          ├── Vote pour vous réduire
                          └── Vote pour vous exclure
```

---

# PARTIE 3 : RÉPONSES DE CÉDRIC

## POSITIONS POSSIBLES DE CÉDRIC

| Position | Probabilité | Ce qu'il dit |
|----------|-------------|--------------|
| **Vous soutient** | 40% | "Jean-Samuel a raison, Jérôme abuse" |
| **Reste neutre** | 35% | "Réglez ça entre vous" |
| **Soutient Jérôme** | 15% | "Jérôme a un point" |
| **Retourne sa veste** | 10% | "C'est de ta faute, pas de convention" |

---

## ARBRE : RÉACTIONS DE CÉDRIC

```
                        CÉDRIC
                          |
    ┌─────────┬───────────┼───────────┬─────────┐
    |         |           |           |         |
  SOUTIENT  NEUTRE    MÉDIATEUR   SOUTIENT  RETOURNE
   VOUS     PASSIF                 JÉRÔME   VESTE
   (40%)    (25%)      (10%)       (15%)    (10%)
    |         |           |           |         |
 [Actions] [Actions]  [Actions]  [Actions] [Actions]
```

### Si Cédric vous soutient (40%)
- Jérôme isolé
- Félix doit choisir (ami vs business)
- Situation stabilisée

### Si Cédric reste neutre (25%)
- Pas d'arbitrage
- Conflit prolongé
- Incertitude

### Si Cédric médie (10%)
- Propose compromis
- Potentiellement en votre défaveur
- Pression pour "céder un peu"

### Si Cédric soutient Jérôme (15%)
- Alliance Cédric-Jérôme
- Vous isolé
- Danger majeur

### Si Cédric retourne sa veste (10%)
- "C'est de ta faute"
- Vous blâme
- Potentielle éviction

---

# PARTIE 4 : RÉPONSES DE FÉLIX

## POSITIONS POSSIBLES DE FÉLIX

| Position | Probabilité | Ce qu'il dit |
|----------|-------------|--------------|
| **Vous soutient** | 25% | "Jérôme exagère" |
| **Reste neutre** | 35% | "Je veux pas m'en mêler" |
| **Soutient Jérôme (ami)** | 35% | "Jérôme a raison, il travaille plus" |
| **Opportuniste** | 5% | Profite du conflit |

---

## ARBRE : RÉACTIONS DE FÉLIX

```
                        FÉLIX
                          |
    ┌─────────┬───────────┼───────────┬─────────┐
    |         |           |           |         |
  SOUTIENT  NEUTRE    TIRAILLÉ    SOUTIENT  OPPORTUN
   VOUS     PASSIF    (ami vs     JÉRÔME    -ISTE
   (25%)    (30%)     business)    (35%)     (10%)
                       (10%)
```

### Si Félix vous soutient (25%)
- Jérôme très isolé
- Probable départ de Jérôme
- Stabilité

### Si Félix reste neutre (30%)
- Pas d'aide mais pas d'opposition
- Conflit Jérôme vs Vous
- Issue dépend de Cédric

### Si Félix est tiraillé (10%)
- Tente médiation
- Pression pour compromis
- Potentiel compromis défavorable

### Si Félix soutient Jérôme (35%)
- Alliance Félix-Jérôme
- Vous devez avoir Cédric
- Conflit majeur

### Si Félix est opportuniste (5%)
- Profite pour augmenter son pouvoir
- Wild card
- Imprévisible

---

# PARTIE 5 : COALITIONS POSSIBLES

## MATRICE DES COALITIONS

| Coalition | Probabilité | Issue pour vous |
|-----------|-------------|-----------------|
| **Vous + Cédric + Félix** | 15% | ✅ VICTOIRE TOTALE |
| **Vous + Cédric** | 30% | ✅ Victoire solide |
| **Vous + Félix** | 10% | ⚠️ Dépend de Cédric |
| **Vous seul** | 20% | ⚠️ Difficile mais tenable |
| **Jérôme + Félix** | 15% | ❌ Vous isolé, dépend Cédric |
| **Jérôme + Cédric** | 5% | ❌ DANGER MAJEUR |
| **Jérôme + Félix + Cédric** | 5% | ❌ GAME OVER |

---

## ARBRE DES COALITIONS

```
                    COALITIONS
                        |
        ┌───────────────┼───────────────┐
        |               |               |
    VOUS GAGNEZ     STALEMATE      VOUS PERDEZ
      (45%)           (30%)          (25%)
        |               |               |
   ┌────┴────┐     ┌────┴────┐     ┌────┴────┐
   |         |     |         |     |         |
Vous+C+F  Vous+C  Vous    J+F    J+C      J+F+C
  seul    seul   (Cédric  (Vous    (GAME
                 neutre)  isolé)   OVER)
```

---

# PARTIE 6 : VALEURS ATTENDUES PAR OPTION

## CALCUL COMPLET

### OPTION A : Refus total

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Statu quo | 30% | 0$ | 0$ |
| Jérôme part | 20% | +50,000$ (économie) | +10,000$ |
| Coalition contre vous | 50% | -500,000$ | -250,000$ |
| **VALEUR ATTENDUE** | | | **-240,000$** |

---

### OPTION B : Refus + action préventive

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Statu quo renforcé | 50% | +100,000$ | +50,000$ |
| Jérôme part | 20% | +50,000$ | +10,000$ |
| Conflit mais vous gagnez | 20% | -50,000$ | -10,000$ |
| Coalition (échoue) | 10% | -200,000$ | -20,000$ |
| **VALEUR ATTENDUE** | | | **+30,000$** |

---

### OPTION C1 : 5% gratuit

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Satisfait | 40% | -500,000$ | -200,000$ |
| Veut plus | 40% | -500,000$ - escalade | -300,000$ |
| Escalade | 20% | -500,000$ - conflit | -150,000$ |
| **VALEUR ATTENDUE** | | | **-650,000$** |

---

### OPTION C2 : 5% conditionnel

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Accepte conditions | 30% | -500,000$ + protection | -350,000$ |
| Refuse | 50% | 0$ | 0$ |
| Escalade | 20% | -200,000$ | -40,000$ |
| **VALEUR ATTENDUE** | | | **-390,000$** |

---

### OPTION C3 : 10% contre salaire + 10 cliniques ⭐

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Accepte ET livre | 15% | -600,000$ + 10 cliniques (~5M$) | +660,000$ |
| Accepte ET échoue | 5% | +400,000$ (salaire) + clawback | +20,000$ |
| Refuse (révèle intentions) | 60% | 0$ + clarté | +50,000$ |
| Négocie | 20% | Variable | 0$ |
| **VALEUR ATTENDUE** | | | **+730,000$** ⭐ |

---

### OPTION C4 : Rachat au marché

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Il achète | 5% | +850,000$ (cash) | +42,500$ |
| Il refuse | 90% | 0$ | 0$ |
| Escalade | 5% | -100,000$ | -5,000$ |
| **VALEUR ATTENDUE** | | | **+37,500$** |

---

### OPTION C5 : Bonus performance

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Accepte | 25% | -250,000$ (5 cliniques) + cliniques | +100,000$ |
| Refuse | 50% | 0$ | 0$ |
| Négocie | 25% | Variable | 0$ |
| **VALEUR ATTENDUE** | | | **+100,000$** |

---

### OPTION D : Accepter 17%

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Satisfait (fin) | 20% | -1,700,000$ | -340,000$ |
| Nouvelle demande | 80% | -1,700,000$ - plus | -1,700,000$ |
| **VALEUR ATTENDUE** | | | **-2,040,000$** |

---

### OPTION E : Nucléaire (sortie)

| Issue | Probabilité | Valeur | Valeur pondérée |
|-------|-------------|--------|-----------------|
| Sortie propre | 70% | Valeur parts - opportunité | Variable |
| Sortie conflictuelle | 30% | Valeur parts - frais légaux | Variable |
| **VALEUR ATTENDUE** | | | **Dépend de l'évaluation** |

---

## CLASSEMENT DES OPTIONS

| Rang | Option | Valeur attendue |
|------|--------|-----------------|
| 🥇 | **C3 : 10% + cliniques** | **+730,000$** |
| 🥈 | C5 : Bonus performance | +100,000$ |
| 🥉 | C4 : Rachat marché | +37,500$ |
| 4 | B : Refus + action | +30,000$ |
| 5 | A : Refus total | -240,000$ |
| 6 | C2 : 5% conditionnel | -390,000$ |
| 7 | C1 : 5% gratuit | -650,000$ |
| 8 | D : Accepter 17% | -2,040,000$ |

---

# PARTIE 7 : SCRIPTS POUR CHAQUE SCÉNARIO

## SCRIPT A : REFUS TOTAL

> "Non, Jérôme. Le switch n'est pas une option.
> 
> Tu as 6% + 80k$/an. C'est ton package. Si ça ne te convient pas, tu peux partir.
> 
> Cette conversation est terminée."

---

## SCRIPT B : REFUS + ACTION

> "Non au switch. Mais voici ce que je fais :
> 1. Email à Cédric et Félix pour clarifier la situation
> 2. Demande de convention d'actionnaire à Nicolas
> 3. Documentation de toutes les contributions
> 
> Si tu veux contester, fais-le par écrit."

---

## SCRIPT C1 : 5% GRATUIT

> "Je peux te donner 5%. C'est tout. Le reste, va le chercher ailleurs.
> 
> Prends-le ou laisse-le."

---

## SCRIPT C2 : 5% CONDITIONNEL

> "5% supplémentaire, à ces conditions :
> 1. Vesting sur 4 ans
> 2. Convention d'actionnaire signée
> 3. Clause de non-concurrence
> 4. C'est ton dernier ajustement, par écrit
> 
> Sans ces conditions, c'est non."

---

## SCRIPT C3 : 10% CONTRE CLINIQUES ⭐

> "Voici ma proposition :
> 
> Tu veux des parts? Prouve que tu les mérites.
> 
> Je te donne 10% supplémentaire SI :
> 1. Tu coupes ton salaire (80k$ → 0$)
> 2. Tu t'engages à bâtir 10 cliniques vétérinaires en 5 ans
> 3. Tes parts du 48 plex sont en garantie
> 
> Si tu livres : tu as 16% + 10 cliniques à ton actif.
> Si tu échoues : tu perds tout.
> 
> C'est ça, un vrai partenariat. À toi de choisir."

---

## SCRIPT C4 : RACHAT MARCHÉ

> "Tu veux des parts? Achète-les.
> 
> Prix du marché : 170,000$ par point de pourcentage.
> Tu veux 17%? C'est 2,890,000$. Cash.
> 
> C'est comme ça que ça marche dans le vrai monde."

---

## SCRIPT C5 : BONUS PERFORMANCE

> "Pas de parts supplémentaires. Mais un bonus.
> 
> 50,000$ par clinique construite et opérationnelle.
> 10 cliniques = 500,000$ de bonus.
> 
> Tu veux de l'argent? Crée de la valeur."

---

## SCRIPT D : ACCEPTER (NON RECOMMANDÉ)

> "OK, on fait le switch."
> 
> [Attendez-vous à une nouvelle demande dans 6-12 mois]

---

## SCRIPT E : NUCLÉAIRE

> "Je me retire de l'immobilier.
> 
> Rachetez mes parts à la valeur marchande.
> Je me concentre sur Veta.
> 
> Faites ce que vous voulez avec Jérôme."

---

# PARTIE 8 : ARBRES DE DÉCISION DÉTAILLÉS

## ARBRE COMPLET - OPTION C3 (10% + CLINIQUES)

```
VOUS PROPOSEZ C3
        |
        ├── JÉRÔME ACCEPTE (20%)
        |         |
        |         ├── IL LIVRE (75% de ceux qui acceptent)
        |         |         |
        |         |         ├── 10 cliniques construites
        |         |         ├── Vous : +5M$ de valeur
        |         |         └── Lui : 16% mérité
        |         |
        |         └── IL ÉCHOUE (25% de ceux qui acceptent)
        |                   |
        |                   ├── Clawback activé
        |                   ├── Vous : récupérez ses parts
        |                   └── Lui : perd tout
        |
        ├── JÉRÔME REFUSE (60%)
        |         |
        |         ├── Révèle qu'il voulait parts gratuites
        |         ├── Vous : position morale forte
        |         └── Retour à Option A ou B
        |
        └── JÉRÔME NÉGOCIE (20%)
                  |
                  ├── Demande moins de cliniques
                  ├── Demande garder une partie du salaire
                  └── Vous : contre-négociez
```

---

## ARBRE COMPLET - ESCALADE

```
ESCALADE
    |
    ├── JÉRÔME VA VOIR FÉLIX
    |         |
    |         ├── Félix reste neutre (35%)
    |         |         └── Pas d'impact
    |         |
    |         ├── Félix soutient Jérôme (35%)
    |         |         |
    |         |         └── VOUS DEVEZ AVOIR CÉDRIC
    |         |                   |
    |         |                   ├── Cédric vous soutient (60%)
    |         |                   |         └── Stalemate ou victoire
    |         |                   |
    |         |                   └── Cédric neutre/contre (40%)
    |         |                             └── DANGER
    |         |
    |         └── Félix vous soutient (30%)
    |                   └── Jérôme isolé → il part ou accepte
    |
    └── JÉRÔME VA VOIR CÉDRIC
              |
              ├── Cédric vous soutient (50%)
              |         └── Jérôme isolé
              |
              ├── Cédric neutre (30%)
              |         └── Pas d'arbitrage
              |
              └── Cédric soutient Jérôme (20%)
                        └── DANGER MAJEUR
```

---

# PARTIE 9 : STRATÉGIE OPTIMALE

## RECOMMANDATION FINALE

### STRATÉGIE EN 3 PHASES

**PHASE 1 : PROPOSITION C3 (10% + cliniques)**
- Valeur attendue la plus élevée (+730,000$)
- Test d'engagement réel
- Position de force

**PHASE 2 : SI JÉRÔME REFUSE → OPTION B**
- Refus + action préventive
- Parler à Cédric et Félix
- Convention d'actionnaire

**PHASE 3 : SI ESCALADE → DÉFENSE**
- Documentation
- Alliances
- Prêt pour le conflit

---

## SÉQUENCE D'ACTIONS

```
JOUR 1 : Proposer C3 (10% + cliniques)
              |
              ├── Accepte → Rédiger convention avec Nicolas
              |
              └── Refuse → JOUR 3
                              |
JOUR 3 : Activer Option B
              |
              ├── Email à Cédric
              ├── Email à Félix
              └── Email à Nicolas (convention)
                              |
JOUR 7 : Évaluer réponses
              |
              ├── Coalition en votre faveur → Maintenir
              |
              └── Escalade → Défense juridique
```

---

## MESSAGE FINAL

> **Votre meilleure option : C3 (10% + cliniques)**
> 
> Si Jérôme accepte : Vous gagnez 10 cliniques, lui prouve sa valeur
> Si Jérôme refuse : Vous savez qu'il voulait des parts gratuites
> 
> Dans les deux cas, **vous gagnez**.

---

*War Game Complet - Toutes les options*
*Date : 15 décembre 2025*
*🎮 DOCUMENT STRATÉGIQUE ULTIME*





