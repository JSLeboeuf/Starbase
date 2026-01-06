# OPTIMISATION CONTEXTE 100% - CURSOR + CLAUDE CODE
## Guide Complet - Extraction Maximale du Contexte (2025)

---

## 🎯 RÉSUMÉ EXÉCUTIF

Pour extraire 100% du contexte d'un projet, il faut combiner:
1. **MCPs spécialisés** pour chaque type de données
2. **Vector databases** pour recherche sémantique
3. **CLAUDE.md optimisé** comme système de prompts
4. **Workflows multi-agents** pour tâches complexes
5. **Memory systems** pour persistance cross-session

---

## 🔧 MCPs RECOMMANDÉS POUR CONTEXTE MAXIMAL

### 1. DÉJÀ CONFIGURÉS ✅
| MCP | Fonction |
|-----|----------|
| `supabase-jerome` | Base de données structurée |
| `gmail-jsleboeuf` | Extraction emails |
| `perplexity` | Recherches web/juridiques |
| `github` | Versioning |
| `context7` | Documentation technique |
| `sequential-thinking` | Raisonnement structuré |

### 2. À AJOUTER POUR 100% CONTEXTE 🚀

#### Chroma MCP - Recherche Sémantique Locale
```json
"chroma": {
  "command": "uvx",
  "args": ["chroma-mcp-server"],
  "env": {
    "CHROMA_CLIENT_TYPE": "persistent",
    "CHROMA_DATA_DIR": "/Users/thecreator/GitHub/jerome/data/vectors"
  }
}
```
**Fonction**: Indexer 8500+ emails pour recherche sémantique locale

#### Pinecone MCP - Vector Database Cloud
```json
"pinecone": {
  "command": "npx",
  "args": ["-y", "@anthropics/pinecone-mcp"],
  "env": {
    "PINECONE_API_KEY": "<YOUR_KEY>"
  }
}
```
**Fonction**: Recherche sémantique à grande échelle (millions de vecteurs)

#### Graphiti MCP - Mémoire Temporelle
```json
"graphiti": {
  "command": "npx",
  "args": ["-y", "@zep-ai/graphiti-mcp"],
  "env": {
    "ZEP_API_KEY": "<YOUR_KEY>"
  }
}
```
**Fonction**: Knowledge graph temporel - suit l'évolution des décisions

#### AST MCP - Analyse Structurelle Code
```json
"ast-analyzer": {
  "command": "npx",
  "args": ["-y", "ast-mcp-server"]
}
```
**Fonction**: Analyse syntaxique du code (fonctions, dépendances, scope)

---

## 📊 STRATÉGIES DE CHUNKING

### Pour Code (AST-based)
- Chunker par fonction/classe/module
- Respecter les frontières syntaxiques
- Metadata: file path, line numbers, component type

### Pour Emails (Semantic)
- Chunker par thread de conversation
- Metadata: date, expéditeur, catégorie
- Enrichir avec contexte: "cet email concerne le switch de parts"

### Pour Documents Juridiques
- Chunker par section/article
- Metadata: source, date, pertinence légale
- Liens vers articles de loi cités

---

## 🧠 CLAUDE.md OPTIMISÉ (Best Practices)

### Structure Recommandée
```markdown
# CLAUDE.md - [Projet]

## Contexte Projet
- Description courte (50 mots max)
- Stack technique
- Objectif principal

## Architecture
- Schéma simplifié
- Composants clés
- Dépendances

## Conventions
- Style de code
- Nommage fichiers
- Patterns utilisés

## Commandes Fréquentes
- Build: `npm run build`
- Test: `npm test`
- Deploy: `npm run deploy`

## Workflow Agentic
1. Analyser → 2. Planifier → 3. Exécuter → 4. Vérifier

## Règles Strictes
- NE PAS demander confirmation
- TOUJOURS citer sources
- MAXIMISER parallélisme
```

### Optimisation par Prompt Learning
1. Collecter données sur succès/échecs
2. Analyser patterns avec LLM évaluateur
3. Générer améliorations CLAUDE.md
4. Tester sur set de validation
5. Itérer

---

## 🔍 RECHERCHE SÉMANTIQUE HYBRIDE

### Pattern Optimal
```
Keyword Search (BM25) + Vector Search (Embeddings) + Metadata Filters
```

### Modèles d'Embeddings Recommandés
| Modèle | Usage | Dimensions |
|--------|-------|------------|
| **VoyageCode3** | Code (300+ langages) | 2048/1024/512 |
| **Jina V4** | Multimodal (texte+images) | Variable |
| **Nomic Embed** | Open-source, local | 7B params |

### Implémentation Cursor
```
@Codebase "où gérons-nous l'authentification?"
→ Embedding de la question
→ Recherche similitude dans index
→ Top-K résultats avec metadata
→ Claude analyse et répond
```

---

## 🤖 WORKFLOWS MULTI-AGENTS

### Architecture Recommandée
```
┌─────────────┐
│ Orchestrator │
└──────┬──────┘
       │
┌──────┴──────┐
│             │
▼             ▼
┌─────┐   ┌─────┐   ┌─────┐   ┌─────┐
│Spec │   │Impl │   │Test │   │Review│
│Agent│   │Agent│   │Agent│   │Agent │
└─────┘   └─────┘   └─────┘   └─────┘
```

### Subagents Claude Code
- **Analyzer**: Investigation code, propose refactoring
- **Test Runner**: Exécute tests, fixe failures
- **Reviewer**: Quality check avant commit

### Frameworks
- **LangGraph**: Workflows graph-based
- **CrewAI**: Équipes d'agents avec rôles

---

## 💾 SYSTÈMES DE MÉMOIRE PERSISTANTE

### Graphiti (Temporal Knowledge Graph)
- Entités: Requirements, Preferences, Procedures
- Relations avec timestamps
- Évolution des décisions dans le temps

### AgentCore Memory (AWS Bedrock)
- Short-term: Données brutes par session
- Long-term: Insights extraits async
- Stratégies: Semantic, User Preference, Summary

### OpenSearch Agentic Memory
- Full-text + metadata + semantic search
- Namespaces hiérarchiques
- `/project/preferences`, `/project/architecture`

---

## ⚡ TECHNIQUES CUTTING-EDGE 2025

### 1. Extended Thinking (Claude 4.5)
- Raisonnement transparent avant réponse
- Coût: plus de tokens
- Gain: meilleure qualité pour décisions complexes

### 2. Files API
- Référencer fichiers sans occuper context window
- Accès on-demand illimité
- Économie massive de tokens

### 3. Context Awareness (Claude 4+)
- Modèle conscient de son budget tokens restant
- Ajuste comportement selon espace disponible
- Résume info non-critique quand limite approche

### 4. Hybrid Search
- BM25 (keywords) + Vector (semantic) combinés
- Meilleur que chaque technique seule
- Implémenté dans Weaviate, Pinecone

### 5. Prompt Learning
- Optimisation automatique de CLAUDE.md
- +10% performance avec tuning systématique
- Équivalent à upgrade de modèle

---

## 🔒 SÉCURITÉ

### .cursorignore
```
# Fichiers sensibles
.env
.env.*
*.key
credentials.json
secrets/
aws.json

# Données confidentielles
private/
confidential/
```

### Best Practices
- Credentials dans env vars, pas dans config
- Self-hosted pour données ultra-sensibles
- Audit régulier des accès MCP

---

## 📈 MÉTRIQUES DE SUCCÈS

| Métrique | Cible | Mesure |
|----------|-------|--------|
| **Recall sémantique** | >90% | Questions trouvent réponses pertinentes |
| **Latence recherche** | <100ms | Temps de réponse vector search |
| **Couverture index** | 100% | Tous fichiers pertinents indexés |
| **Mémoire cross-session** | Persistante | Décisions rappelées après restart |
| **Multi-agent efficacy** | >80% | Tâches complétées sans intervention |

---

## 🚀 PLAN D'IMPLÉMENTATION

### Phase 1: Fondation (Aujourd'hui)
- [x] MCPs de base configurés
- [x] CLAUDE.md optimisé
- [ ] Créer structure dossiers data/vectors

### Phase 2: Vector Search (Semaine 1)
- [ ] Installer Chroma MCP
- [ ] Indexer 8500 emails
- [ ] Tester recherche sémantique

### Phase 3: Memory (Semaine 2)
- [ ] Configurer Graphiti ou équivalent
- [ ] Définir entités projet (acteurs, décisions, timeline)
- [ ] Tester persistance cross-session

### Phase 4: Multi-Agent (Semaine 3)
- [ ] Définir subagents spécialisés
- [ ] Créer workflow analyse → argument → rapport
- [ ] Automatiser génération rapports juridiques

---

## 📚 SOURCES

- Anthropic Engineering: Claude Code Best Practices
- Cursor Docs: Codebase Indexing, MCP, Semantic Search
- Pinecone: Chunking Strategies, MCP Server
- Zep/Graphiti: Temporal Knowledge Graphs
- Arize: Prompt Learning for CLAUDE.md

---

*Guide Optimisation Contexte 100% - Projet JEROME*
*21 décembre 2025*


