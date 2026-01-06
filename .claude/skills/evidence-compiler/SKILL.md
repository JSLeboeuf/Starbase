---
name: evidence-compiler
description: |
  Ce skill compile et organise les preuves de manipulation narcissique.
  Utiliser quand l'utilisateur demande: "compiler preuves", "organiser evidence",
  "dossier de preuves", "rassembler documentation", "préparer dossier juridique",
  "créer dossier", "evidence package", "chronologie preuves", "classifier preuves".
---

# Evidence Compiler

Skill pour compiler, organiser et présenter les preuves de manipulation
narcissique de manière professionnelle et juridiquement pertinente.

## Objectifs du Compilateur

1. **Centraliser** toutes les preuves dispersées
2. **Organiser** par type, date, gravité
3. **Corréler** les preuves entre elles
4. **Présenter** de manière claire et professionnelle
5. **Préparer** pour usage juridique potentiel

## Types de Preuves à Compiler

### 1. Communications Écrites

| Type | Format | Valeur Probante |
|------|--------|-----------------|
| Emails | .eml, .msg | Haute (horodatés) |
| SMS/Messages | Screenshots | Moyenne (contexte) |
| Documents signés | PDF, scans | Très haute |
| Notes de réunion | .doc, .md | Moyenne |

### 2. Documents Financiers

| Type | Importance |
|------|------------|
| Contrats/Conventions | Critique |
| Relevés bancaires | Haute |
| Factures | Moyenne |
| Déclarations fiscales | Haute |

### 3. Témoignages

| Type | Format Recommandé |
|------|-------------------|
| Déclarations écrites | Document daté et signé |
| Enregistrements | Audio/vidéo horodatés |
| Témoins identifiés | Liste avec contacts |

### 4. Preuves Comportementales

| Type | Documentation |
|------|---------------|
| Incidents datés | Journal avec détails |
| Patterns récurrents | Tableau de synthèse |
| Contradictions | Comparaison côte à côte |

## Structure du Dossier de Preuves

```
DOSSIER-PREUVES-[NOM]-[DATE]/
│
├── 00-INDEX/
│   ├── INDEX-PRINCIPAL.md      <- Navigation centrale
│   ├── RESUME-EXECUTIF.md      <- Synthèse pour avocat
│   └── TIMELINE-GLOBALE.md     <- Chronologie complète
│
├── 10-COMMUNICATIONS/
│   ├── EMAILS/
│   │   ├── [DATE]-[SUJET].eml
│   │   └── INDEX-EMAILS.md
│   ├── MESSAGES/
│   │   └── INDEX-MESSAGES.md
│   └── ANALYSE-COMMUNICATIONS.md
│
├── 20-DOCUMENTS-FINANCIERS/
│   ├── CONTRATS/
│   ├── RELEVES/
│   └── ANALYSE-FINANCIERE.md
│
├── 30-TEMOIGNAGES/
│   ├── DECLARATIONS/
│   ├── ENREGISTREMENTS/
│   └── LISTE-TEMOINS.md
│
├── 40-INCIDENTS/
│   ├── JOURNAL-INCIDENTS.md
│   └── ANALYSES-PATTERNS.md
│
├── 50-ANALYSES/
│   ├── ANALYSE-MANIPULATION.md
│   ├── ANALYSE-FINANCIERE.md
│   ├── ANALYSE-JURIDIQUE.md
│   └── CORRELATIONS.md
│
└── 60-ANNEXES/
    ├── GLOSSAIRE.md
    ├── METHODOLOGIE.md
    └── SOURCES.md
```

## Template Index Principal

```markdown
# Dossier de Preuves - [Contexte]

## Informations Générales

| Élément | Détail |
|---------|--------|
| Sujet | |
| Période couverte | |
| Date compilation | |
| Compilé par | |

## Résumé Exécutif

[3-5 paragraphes résumant la situation et les preuves clés]

## Statistiques du Dossier

| Catégorie | Nombre | Pages |
|-----------|--------|-------|
| Emails | | |
| Documents financiers | | |
| Témoignages | | |
| Incidents documentés | | |
| **TOTAL** | | |

## Preuves Clés (Top 10)

1. **[Titre preuve]** - [Réf] - [Impact]
2. ...

## Navigation

- [Communications](./10-COMMUNICATIONS/)
- [Documents Financiers](./20-DOCUMENTS-FINANCIERS/)
- [Témoignages](./30-TEMOIGNAGES/)
- [Incidents](./40-INCIDENTS/)
- [Analyses](./50-ANALYSES/)

## Chronologie

Voir [TIMELINE-GLOBALE.md](./TIMELINE-GLOBALE.md)
```

## Template Résumé Exécutif

```markdown
# Résumé Exécutif - À l'attention de [Avocat/Tribunal]

## Contexte

[Description factuelle de la situation]

## Parties Impliquées

| Nom | Rôle | Relation |
|-----|------|----------|
| | | |

## Faits Principaux

### 1. [Premier fait majeur]
- **Date**:
- **Description**:
- **Preuves**: Réf [XX-001]

### 2. [Deuxième fait majeur]
...

## Préjudices Subis

| Type | Description | Montant estimé |
|------|-------------|----------------|
| Financier | | |
| Moral | | |
| Professionnel | | |

## Demandes / Objectifs

1. [Demande principale]
2. [Demande secondaire]

## Preuves Disponibles

[Résumé des preuves les plus solides]

## Conclusion

[Synthèse et recommandations]
```

## Système de Référencement

### Format de Référence

```
[CATEGORIE]-[ANNEE][NUMERO]-[TYPE]

Exemples:
- COM-2024-001-EMAIL (Communication, 2024, #1, Email)
- FIN-2023-015-CONTRAT (Financier, 2023, #15, Contrat)
- TEM-2024-003-DECL (Témoignage, 2024, #3, Déclaration)
- INC-2024-042-GASL (Incident, 2024, #42, Gaslighting)
```

### Catégories

| Code | Catégorie |
|------|-----------|
| COM | Communications |
| FIN | Financier |
| TEM | Témoignages |
| INC | Incidents |
| DOC | Documents officiels |
| ANA | Analyses |

## Scoring des Preuves

| Critère | Score 1-5 |
|---------|-----------|
| Authenticité (preuve d'origine) | |
| Horodatage (date vérifiable) | |
| Contexte (compréhensible seul) | |
| Corroboration (autres preuves) | |
| Pertinence juridique | |
| **TOTAL** | /25 |

**Score > 20**: Preuve très solide
**Score 15-20**: Preuve solide
**Score 10-15**: Preuve utile
**Score < 10**: Preuve faible

## Output Format

```markdown
## Compilation de Preuves - [Contexte]

### Vue d'Ensemble

| Métrique | Valeur |
|----------|--------|
| Preuves totales | |
| Preuves solides (>15/25) | |
| Période couverte | |
| Patterns identifiés | |

### Preuves par Catégorie

#### Communications (X documents)

| Réf | Date | Type | Score | Résumé |
|-----|------|------|-------|--------|
| | | | | |

#### Financier (X documents)
...

### Corrélations Identifiées

1. **Corrélation #1**: [Preuves liées]
2. ...

### Gaps Identifiés

| Gap | Impact | Solution possible |
|-----|--------|-------------------|
| | | |

### Recommandations

1. Preuves à renforcer: ...
2. Preuves à obtenir: ...
3. Preuves à protéger: ...
```

## Meilleures Pratiques

### 1. Authenticité

- Conserver les originaux
- Ne pas modifier les fichiers
- Documenter la chaîne de possession

### 2. Organisation

- Un fichier = une preuve
- Nommage cohérent
- Index à jour

### 3. Redondance

- Backups multiples
- Cloud + local
- Copies chez avocat

### 4. Confidentialité

- Accès restreint
- Chiffrement si nécessaire
- Partage contrôlé

## Ressources

- `references/legal-requirements.md` - Exigences légales
- `references/authentication.md` - Authentification des preuves
- `scripts/evidence_indexer.py` - Indexation automatique
