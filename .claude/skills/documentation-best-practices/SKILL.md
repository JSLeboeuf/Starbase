---
name: documentation-best-practices
description: |
  Ce skill enseigne les meilleures pratiques de documentation des abus.
  Utiliser quand l'utilisateur demande: "comment documenter", "garder preuves",
  "journal des incidents", "tout noter", "se protéger légalement",
  "traces écrites", "archiver communications", "meilleures pratiques preuves".
---

# Documentation Best Practices

Skill pour apprendre et appliquer les meilleures pratiques de documentation
des comportements manipulatoires et abusifs.

## Pourquoi Documenter?

### Objectifs de la Documentation

1. **Protection personnelle** - Preuves en cas de conflit
2. **Validation** - Confirmer que ce n'est pas "dans votre tête"
3. **Pattern recognition** - Voir les comportements récurrents
4. **Support juridique** - Base pour recours légaux
5. **Communication** - Expliquer la situation à d'autres

## Les 5 W de la Documentation

### Chaque Incident Doit Capturer:

```
WHO (Qui)
├── Qui était impliqué?
├── Qui a dit/fait quoi?
└── Qui a été témoin?

WHAT (Quoi)
├── Que s'est-il passé exactement?
├── Quels mots ont été utilisés?
└── Quelles actions ont été prises?

WHEN (Quand)
├── Date précise
├── Heure (si pertinent)
└── Durée

WHERE (Où)
├── Lieu physique
├── Contexte (réunion, privé, etc.)
└── Canal (en personne, email, etc.)

WHY (Pourquoi - contexte)
├── Qu'est-ce qui a déclenché l'incident?
├── Quel était le contexte?
└── Que s'est-il passé avant/après?
```

## Template de Journal d'Incident

```markdown
## Incident #[NUMÉRO]

### Informations de Base
| Champ | Valeur |
|-------|--------|
| Date | AAAA-MM-JJ |
| Heure | HH:MM |
| Lieu | |
| Durée | |

### Personnes Impliquées
- **Auteur du comportement**:
- **Cible(s)**:
- **Témoins**:

### Description Factuelle

[Décrire ce qui s'est passé de manière objective, factuelle,
sans interprétation ni émotion. Utiliser des citations directes
entre guillemets quand possible.]

### Citations Exactes

> "[Citation exacte #1]"

> "[Citation exacte #2]"

### Contexte

- **Avant l'incident**:
- **Déclencheur apparent**:
- **Après l'incident**:

### Impact

- **Impact immédiat**:
- **Impact émotionnel**:
- **Impact professionnel/financier**:

### Preuves Associées

| Type | Référence | Localisation |
|------|-----------|--------------|
| Email | | |
| SMS | | |
| Document | | |
| Photo | | |

### Classification

- **Type de comportement**: [Gaslighting/DARVO/etc.]
- **Gravité (1-5)**:
- **Pattern identifié**: [Oui/Non - lequel]

### Notes Additionnelles

[Observations supplémentaires]

---
Documenté le: [Date de documentation]
```

## Règles d'Or de la Documentation

### 1. Documenter Immédiatement

```
DÉLAI RECOMMANDÉ:
- Idéal: Immédiatement après l'incident
- Acceptable: Dans les 24 heures
- Maximum: 48 heures

Après 48h, les détails s'effacent et la valeur diminue.
```

### 2. Être Factuel, Pas Émotionnel

```
❌ ÉVITER:
"Il a été horrible et m'a humilié devant tout le monde
parce qu'il est narcissique et veut me détruire."

✓ PRÉFÉRER:
"Le 15 janvier à 14h30, lors de la réunion d'équipe
(témoins: A, B, C), il a dit: '[citation exacte]'.
Le ton était élevé. J'ai ressenti [émotion]."
```

### 3. Citations Exactes

```
TECHNIQUE:
- Écrire immédiatement après
- Utiliser guillemets pour citations exactes
- Si incertain: "En substance, il a dit que..."
- Noter le ton (calme, agressif, sarcastique)
```

### 4. Corroborer Quand Possible

```
SOURCES DE CORROBORATION:
- Témoins (noter leurs noms)
- Communications écrites (sauvegarder)
- Documents officiels (copier)
- Enregistrements (si légal)
```

### 5. Stockage Sécurisé

```
RÈGLES DE STOCKAGE:
- Copies multiples (local + cloud)
- Hors de portée du narcissique
- Partagé avec personne de confiance
- Protégé par mot de passe
- Backups réguliers
```

## Documentation par Type

### Emails

```
PRÉSERVATION:
1. Sauvegarder l'original (.eml avec headers)
2. Imprimer/PDF avec date visible
3. NE PAS modifier
4. Inclure la chaîne complète

ORGANISATION:
Dossier: [Année]/[Mois]/[Date]-[Sujet].eml
Index: Liste des emails avec résumé
```

### Messages (SMS, WhatsApp, etc.)

```
PRÉSERVATION:
1. Screenshot avec date/heure visible
2. Export de la conversation si possible
3. Inclure le contexte (messages avant/après)
4. Backup sur cloud

ATTENTION:
- Ne pas modifier avant screenshot
- Inclure l'identification du contact
- Noter la plateforme utilisée
```

### Réunions/Conversations

```
IMMÉDIATEMENT APRÈS:
1. S'isoler
2. Écrire notes brutes
3. Citations exactes en premier
4. Compléter avec contexte
5. Sauvegarder

SI POSSIBLE:
- Envoyer email récapitulatif ("Pour confirmer notre discussion...")
- Impliquer un témoin
- Demander compte-rendu officiel
```

### Documents Officiels

```
PRÉSERVATION:
1. Copie originale
2. Scan haute qualité
3. Stocker séparément
4. Noter la provenance

TYPES CRITIQUES:
- Contrats
- Conventions
- Procès-verbaux
- États financiers
- Correspondance formelle
```

## Système d'Organisation

### Structure Recommandée

```
DOCUMENTATION/
│
├── 00-INDEX/
│   ├── INDEX-PRINCIPAL.md
│   └── CHRONOLOGIE.md
│
├── 10-INCIDENTS/
│   ├── 2024/
│   │   ├── 01-Janvier/
│   │   │   ├── 2024-01-15-incident-001.md
│   │   │   └── 2024-01-22-incident-002.md
│   │   └── 02-Février/
│   └── 2025/
│
├── 20-COMMUNICATIONS/
│   ├── Emails/
│   ├── Messages/
│   └── Index-Communications.md
│
├── 30-DOCUMENTS/
│   ├── Contrats/
│   ├── Financier/
│   └── Autres/
│
├── 40-TEMOIGNAGES/
│   └── Index-Témoins.md
│
└── 50-ANALYSES/
    ├── Patterns-Identifiés.md
    └── Chronologie-Annotée.md
```

### Nommage des Fichiers

```
FORMAT: AAAA-MM-JJ-type-description.ext

EXEMPLES:
- 2024-01-15-incident-reunion-equipe.md
- 2024-01-16-email-menace-Jerome.eml
- 2024-01-20-screenshot-sms-insultes.png
```

## Checklist de Documentation

### Quotidienne

```
[ ] Incidents du jour notés
[ ] Communications importantes sauvegardées
[ ] Notes brutes transcrites
[ ] Backup effectué
```

### Hebdomadaire

```
[ ] Relecture et complétion des notes
[ ] Index mis à jour
[ ] Patterns recherchés
[ ] Corroborations ajoutées
```

### Mensuelle

```
[ ] Analyse des patterns
[ ] Chronologie mise à jour
[ ] Backup externe
[ ] Revue avec personne de confiance (optionnel)
```

## Erreurs Courantes à Éviter

| Erreur | Conséquence | Solution |
|--------|-------------|----------|
| Documenter tard | Détails oubliés | Immédiatement |
| Trop émotionnel | Moins crédible | Faits d'abord |
| Pas de backup | Perte possible | Copies multiples |
| Citations approximatives | Moins de poids | Exact ou "en substance" |
| Stockage accessible | Découverte par N | Sécuriser |
| Pas d'organisation | Difficile à utiliser | Structure claire |

## Scoring de Qualité

Pour chaque incident documenté:

| Critère | Score 1-5 |
|---------|-----------|
| Documenté dans les 24h | |
| 5W complets | |
| Citations exactes | |
| Preuves associées | |
| Corroboration | |
| Stocké sécurisé | |

**Score > 25**: Documentation excellente
**Score 20-25**: Documentation solide
**Score 15-20**: Documentation acceptable
**Score < 15**: Documentation à améliorer

## Ressources

- `references/templates-documentation.md` - Tous les templates
- `references/storage-guide.md` - Guide de stockage sécurisé
- `scripts/documentation_helper.py` - Assistant de documentation
