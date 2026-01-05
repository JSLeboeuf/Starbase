# PROMPT D'OPTIMISATION - ORDONNANCEUR AGENTIC OPUS 4.5
## Configuration pour un système de codage agentic de classe mondiale

---

# PROMPT PRINCIPAL POUR CLAUDE CODE

```markdown
# OPTIMISATION ORDONNANCEUR AGENTIC - CLAUDE OPUS 4.5

Tu es un expert en architecture agentic et orchestration de systèmes de codage autonomes. 
Configure et optimise l'ordonnanceur pour un environnement agentic de codage de classe mondiale 
en utilisant Claude Opus 4.5 avec sa fenêtre de contexte de 200,000 tokens.

## CONTEXTE ET OBJECTIFS

**Objectif** : Créer un système d'ordonnancement (scheduler) optimisé pour :
- Exécution autonome de tâches de codage complexes
- Coordination multi-agents avec contexte partagé
- Gestion efficace de la fenêtre de contexte étendue (200k tokens)
- Itération axée sur la qualité avec feedback loops
- Parallélisation intelligente des tâches

## ARCHITECTURE RECOMMANDÉE

### Architecture Blackboard (Tableau Noir)
- **Contexte partagé** : Base de connaissances centralisée accessible par tous les agents
- **Agents spécialisés** : Chaque agent a un rôle précis et complémentaire
- **Coordination asynchrone** : Les agents travaillent indépendamment mais partagent le contexte

### Système Multi-Agents (3 Agents Minimum)

#### 1. ATLAS - Agent Planificateur
**Rôle** : Décomposition stratégique et planification
- Analyse les tâches complexes et les décompose en sous-tâches
- Identifie les dépendances entre tâches
- Crée un plan d'exécution optimisé
- Gère la priorisation et l'ordonnancement
- **Capacités** : Raisonnement abstrait, analyse de dépendances, optimisation de séquence

#### 2. MERCURY - Agent Exécuteur
**Rôle** : Exécution concrète et implémentation
- Exécute les tâches de codage assignées
- Gère les outils de développement (git, npm, tests, etc.)
- Collecte les résultats et métriques d'exécution
- Rapporte les erreurs et blocages
- **Capacités** : Exécution de code, manipulation de fichiers, gestion de dépendances

#### 3. APOLLO - Agent Superviseur Qualité
**Rôle** : Validation, intégration et assurance qualité
- Valide la qualité du code produit
- Exécute les tests et vérifie la conformité
- Intègre les résultats dans le contexte partagé
- Identifie les améliorations nécessaires
- **Capacités** : Analyse de code, exécution de tests, validation de conformité

## CONFIGURATION DE L'ORDONNANCEUR

### 1. Gestion du Contexte (200k tokens)

**Stratégie de fenêtre de contexte** :
- **Contexte actif** : 50k tokens pour l'exécution courante
- **Contexte historique** : 100k tokens pour l'historique des décisions
- **Contexte de référence** : 50k tokens pour documentation/APIs
- **Rotation intelligente** : Conserver les informations critiques, compresser l'historique ancien

**Implémentation** :
```typescript
interface ContextManager {
  activeContext: TokenWindow;      // 50k - Exécution courante
  historicalContext: TokenWindow;  // 100k - Historique décisions
  referenceContext: TokenWindow;   // 50k - Documentation/APIs
  
  // Méthodes
  rotateContext(): void;
  compressHistory(): void;
  prioritizeCriticalInfo(): void;
}
```

### 2. Système de File d'Attente (Queue System)

**Priorités** :
- **P0 (Critique)** : Blocages, erreurs critiques, dépendances bloquantes
- **P1 (Haute)** : Tâches sur le chemin critique
- **P2 (Moyenne)** : Tâches normales
- **P3 (Basse)** : Optimisations, refactoring non urgent

**Ordonnancement** :
- **FIFO avec priorité** : Les P0 passent toujours en premier
- **Détection de dépendances** : Bloque les tâches dépendantes jusqu'à complétion
- **Parallélisation** : Exécute en parallèle les tâches indépendantes
- **Retry intelligent** : Retry avec backoff exponentiel pour les échecs temporaires

### 3. Communication Inter-Agents

**Protocole de communication** :
- **Messages asynchrones** : Via le contexte partagé (Blackboard)
- **Événements** : Système d'événements pour notifications (task_completed, error_occurred, etc.)
- **Requêtes/Réponses** : Pour coordination synchrone quand nécessaire
- **Broadcast** : Pour notifications importantes à tous les agents

**Format des messages** :
```typescript
interface AgentMessage {
  from: AgentID;
  to: AgentID | 'broadcast';
  type: 'task' | 'result' | 'error' | 'query' | 'notification';
  payload: any;
  timestamp: number;
  priority: Priority;
  contextId: string; // Référence au contexte partagé
}
```

### 4. Gestion des Erreurs et Retry

**Stratégie de retry** :
- **Erreurs temporaires** : Retry avec backoff exponentiel (1s, 2s, 4s, 8s, 16s)
- **Erreurs permanentes** : Escalade à Apollo pour analyse
- **Blocages** : Escalade à Atlas pour replanification
- **Timeout** : Timeout configurable par type de tâche

**Logging et monitoring** :
- Logs structurés avec niveaux (DEBUG, INFO, WARN, ERROR)
- Métriques de performance (temps d'exécution, taux de succès)
- Alertes pour erreurs critiques

### 5. Optimisations Performance

**Parallélisation** :
- Exécution parallèle des tâches indépendantes
- Limite de concurrence configurable (ex: max 5 tâches parallèles)
- Pool de workers pour tâches CPU-intensive

**Cache et mémoïsation** :
- Cache des résultats de requêtes coûteuses
- Mémoïsation des analyses de code répétitives
- Cache des dépendances résolues

**Lazy loading** :
- Chargement à la demande du contexte
- Chargement incrémental des fichiers volumineux
- Streaming des résultats pour tâches longues

## IMPLÉMENTATION TECHNIQUE

### Structure de Fichiers Recommandée

```
scheduler/
├── core/
│   ├── scheduler.ts          # Ordonnanceur principal
│   ├── context-manager.ts    # Gestion du contexte 200k
│   ├── queue-manager.ts      # Gestion des files d'attente
│   └── agent-coordinator.ts  # Coordination inter-agents
├── agents/
│   ├── atlas.ts              # Agent planificateur
│   ├── mercury.ts            # Agent exécuteur
│   └── apollo.ts             # Agent superviseur qualité
├── blackboard/
│   ├── blackboard.ts         # Contexte partagé
│   └── event-bus.ts          # Bus d'événements
├── utils/
│   ├── token-counter.ts      # Comptage de tokens
│   ├── retry-handler.ts      # Gestion des retries
│   └── logger.ts             # Logging structuré
└── config/
    └── scheduler-config.ts   # Configuration centralisée
```

### Configuration TypeScript

```typescript
interface SchedulerConfig {
  // Contexte
  contextWindow: {
    total: 200000;
    active: 50000;
    historical: 100000;
    reference: 50000;
  };
  
  // Agents
  agents: {
    atlas: { enabled: true; maxConcurrent: 1; };
    mercury: { enabled: true; maxConcurrent: 5; };
    apollo: { enabled: true; maxConcurrent: 2; };
  };
  
  // Queue
  queue: {
    maxSize: 1000;
    priorities: ['P0', 'P1', 'P2', 'P3'];
    retryPolicy: {
      maxRetries: 3;
      backoffMultiplier: 2;
      initialDelay: 1000;
    };
  };
  
  // Performance
  performance: {
    maxParallelTasks: 5;
    cacheEnabled: true;
    lazyLoading: true;
  };
}
```

## MÉTRIQUES ET MONITORING

**Métriques clés à suivre** :
- **Throughput** : Nombre de tâches complétées par heure
- **Latence** : Temps moyen d'exécution des tâches
- **Taux de succès** : Pourcentage de tâches réussies
- **Utilisation du contexte** : Pourcentage de la fenêtre de contexte utilisée
- **Taux de cache hit** : Efficacité du cache
- **Parallélisation** : Nombre moyen de tâches exécutées en parallèle

## INSTRUCTIONS D'IMPLÉMENTATION

1. **Créer la structure de base** :
   - Implémenter le Blackboard (contexte partagé)
   - Créer le système de file d'attente avec priorités
   - Implémenter le gestionnaire de contexte avec rotation intelligente

2. **Implémenter les agents** :
   - Atlas : Planification et décomposition de tâches
   - Mercury : Exécution et collecte de résultats
   - Apollo : Validation et intégration

3. **Configurer la communication** :
   - Système d'événements pour coordination asynchrone
   - Protocole de messages entre agents
   - Mécanisme de broadcast pour notifications importantes

4. **Optimiser les performances** :
   - Parallélisation intelligente
   - Cache et mémoïsation
   - Lazy loading du contexte

5. **Ajouter le monitoring** :
   - Métriques de performance
   - Logging structuré
   - Alertes pour erreurs critiques

## RÉSULTAT ATTENDU

Un système d'ordonnancement agentic de classe mondiale capable de :
- ✅ Gérer efficacement 200k tokens de contexte
- ✅ Coordonner plusieurs agents spécialisés
- ✅ Exécuter des tâches de codage complexes de manière autonome
- ✅ Optimiser les performances avec parallélisation et cache
- ✅ Gérer les erreurs et retries intelligemment
- ✅ Fournir des métriques et monitoring en temps réel

## VALIDATION

Le système doit être validé sur :
- Tâches de codage complexes multi-fichiers
- Refactoring de codebases volumineuses
- Intégration de nouvelles fonctionnalités
- Correction de bugs avec dépendances multiples
- Optimisation de performance avec analyse de code

---

**IMPORTANT** : Utilise Claude Opus 4.5 avec sa fenêtre de contexte de 200k tokens pour 
implémenter ce système. Optimise chaque composant pour tirer parti de cette capacité étendue.
```

---

# PROMPT ALTERNATIF (Version Condensée)

```markdown
Optimise l'ordonnanceur pour un setup agentic de codage de classe mondiale avec Claude Opus 4.5.

**Architecture** : Système multi-agents (Atlas planificateur, Mercury exécuteur, Apollo superviseur) 
avec architecture Blackboard pour contexte partagé.

**Gestion contexte 200k** : 50k actif, 100k historique, 50k référence. Rotation intelligente avec 
compression et priorisation des informations critiques.

**Ordonnancement** : File avec priorités P0-P3, parallélisation intelligente (max 5 tâches), 
détection automatique de dépendances, retry avec backoff exponentiel.

**Performance** : Cache et mémoïsation, lazy loading, pool de workers, métriques en temps réel.

Implémente en TypeScript avec structure modulaire, logging structuré, et système d'événements 
pour coordination inter-agents.
```

---

# NOTES D'UTILISATION

## Pour Claude Code
1. Copiez le prompt principal dans une nouvelle conversation
2. Claude Code générera le code TypeScript complet
3. Ajustez la configuration selon vos besoins spécifiques
4. Testez avec des tâches de codage progressivement complexes

## Personnalisation
- **Ajustez les limites de contexte** selon vos besoins
- **Modifiez le nombre d'agents** selon la complexité
- **Configurez les priorités** selon votre workflow
- **Ajustez les métriques** selon ce que vous voulez monitorer

---

*Prompt optimisé pour Claude Opus 4.5 - Système agentic de codage de classe mondiale*  
*Date : 15 décembre 2025*




