/**
 * CONFIGURATION EXEMPLE - ORDONNANCEUR AGENTIC OPUS 4.5
 * Configuration optimisée pour système de codage agentic de classe mondiale
 */

export interface SchedulerConfig {
  // Gestion du contexte (200k tokens total)
  contextWindow: {
    total: 200000;
    active: 50000;      // Contexte d'exécution courante
    historical: 100000;  // Historique des décisions
    reference: 50000;   // Documentation/APIs
    rotationStrategy: 'intelligent' | 'fifo' | 'lru';
    compressionThreshold: 0.8; // Compresse quand >80% utilisé
  };

  // Configuration des agents
  agents: {
    atlas: {
      enabled: true;
      maxConcurrent: 1;        // Un seul planificateur
      timeout: 300000;          // 5 minutes max par planification
      capabilities: ['planning', 'decomposition', 'dependency-analysis'];
    };
    mercury: {
      enabled: true;
      maxConcurrent: 5;         // 5 exécutions parallèles max
      timeout: 600000;          // 10 minutes max par tâche
      capabilities: ['execution', 'file-operations', 'git-operations', 'npm-operations'];
    };
    apollo: {
      enabled: true;
      maxConcurrent: 2;         // 2 validations parallèles
      timeout: 180000;          // 3 minutes max par validation
      capabilities: ['validation', 'testing', 'code-analysis', 'integration'];
    };
  };

  // Système de file d'attente
  queue: {
    maxSize: 1000;
    priorities: ['P0', 'P1', 'P2', 'P3'] as const;
    defaultPriority: 'P2';
    retryPolicy: {
      maxRetries: 3;
      backoffMultiplier: 2;
      initialDelay: 1000;       // 1 seconde
      maxDelay: 60000;         // 60 secondes max
    };
    dependencyDetection: {
      enabled: true;
      autoBlock: true;          // Bloque automatiquement les dépendances
    };
  };

  // Optimisations performance
  performance: {
    maxParallelTasks: 5;
    cacheEnabled: true;
    cacheTTL: 3600000;          // 1 heure
    lazyLoading: true;
    workerPoolSize: 4;           // Pool de workers pour tâches CPU-intensive
  };

  // Logging et monitoring
  logging: {
    level: 'INFO' | 'DEBUG' | 'WARN' | 'ERROR';
    structured: true;
    file: './logs/scheduler.log';
    maxFileSize: 10485760;       // 10 MB
    maxFiles: 5;
  };

  // Métriques
  metrics: {
    enabled: true;
    collectionInterval: 60000;   // 1 minute
    metrics: [
      'throughput',
      'latency',
      'success_rate',
      'context_usage',
      'cache_hit_rate',
      'parallelization_rate'
    ];
  };
}

// Configuration par défaut optimisée pour Opus 4.5
export const defaultConfig: SchedulerConfig = {
  contextWindow: {
    total: 200000,
    active: 50000,
    historical: 100000,
    reference: 50000,
    rotationStrategy: 'intelligent',
    compressionThreshold: 0.8,
  },
  agents: {
    atlas: {
      enabled: true,
      maxConcurrent: 1,
      timeout: 300000,
      capabilities: ['planning', 'decomposition', 'dependency-analysis'],
    },
    mercury: {
      enabled: true,
      maxConcurrent: 5,
      timeout: 600000,
      capabilities: ['execution', 'file-operations', 'git-operations', 'npm-operations'],
    },
    apollo: {
      enabled: true,
      maxConcurrent: 2,
      timeout: 180000,
      capabilities: ['validation', 'testing', 'code-analysis', 'integration'],
    },
  },
  queue: {
    maxSize: 1000,
    priorities: ['P0', 'P1', 'P2', 'P3'],
    defaultPriority: 'P2',
    retryPolicy: {
      maxRetries: 3,
      backoffMultiplier: 2,
      initialDelay: 1000,
      maxDelay: 60000,
    },
    dependencyDetection: {
      enabled: true,
      autoBlock: true,
    },
  },
  performance: {
    maxParallelTasks: 5,
    cacheEnabled: true,
    cacheTTL: 3600000,
    lazyLoading: true,
    workerPoolSize: 4,
  },
  logging: {
    level: 'INFO',
    structured: true,
    file: './logs/scheduler.log',
    maxFileSize: 10485760,
    maxFiles: 5,
  },
  metrics: {
    enabled: true,
    collectionInterval: 60000,
    metrics: [
      'throughput',
      'latency',
      'success_rate',
      'context_usage',
      'cache_hit_rate',
      'parallelization_rate',
    ],
  },
};

// Configuration pour développement (moins de ressources)
export const devConfig: SchedulerConfig = {
  ...defaultConfig,
  contextWindow: {
    ...defaultConfig.contextWindow,
    active: 25000,
    historical: 50000,
    reference: 25000,
  },
  agents: {
    ...defaultConfig.agents,
    mercury: {
      ...defaultConfig.agents.mercury,
      maxConcurrent: 2,
    },
  },
  performance: {
    ...defaultConfig.performance,
    maxParallelTasks: 2,
    workerPoolSize: 2,
  },
};

// Configuration pour production (optimisée)
export const prodConfig: SchedulerConfig = {
  ...defaultConfig,
  logging: {
    ...defaultConfig.logging,
    level: 'WARN',
  },
  metrics: {
    ...defaultConfig.metrics,
    collectionInterval: 30000, // Plus fréquent en prod
  },
};




