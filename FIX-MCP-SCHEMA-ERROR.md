# CORRECTION ERREUR SCHÉMA MCP - TOOL 51
## Erreur : Property keys should match pattern '^[a-zA-Z0-9_.-]{1,64}$'

---

## PROBLÈME IDENTIFIÉ

**Erreur API** :
```
tools.51.custom.input_schema.properties: Property keys should match pattern '^[a-zA-Z0-9_.-]{1,64}$'
```

**Cause** : Un outil personnalisé (tool 51) dans un serveur MCP a des propriétés dans son schéma d'entrée qui ne respectent pas le pattern requis.

**Pattern requis** : `^[a-zA-Z0-9_.-]{1,64}$`
- ✅ Autorisé : lettres (a-z, A-Z), chiffres (0-9), underscore (_), point (.), tiret (-)
- ❌ Interdit : espaces, caractères spéciaux, accents, caractères > 64

---

## DIAGNOSTIC

### 1. Identifier le Serveur MCP Problématique

L'outil 51 correspond probablement à un serveur MCP qui expose beaucoup d'outils. Voici les serveurs configurés qui pourraient être la cause :

| Serveur | Probabilité | Raison |
|---------|-------------|--------|
| **n8n-npx** | ⚠️ Élevée | Expose potentiellement beaucoup d'outils (workflows) |
| **github** | ⚠️ Moyenne | Expose plusieurs outils (repos, issues, PRs) |
| **supabase** | ⚠️ Moyenne | Expose plusieurs outils (DB, storage, functions) |
| **playwright** | ⚠️ Faible | Outils limités |
| **gmail** | ✅ Faible | Seulement 2 outils |

### 2. Vérifier les Schémas d'Outils

Les problèmes courants dans les schémas :

#### ❌ Noms Invalides
```json
{
  "properties": {
    "user name": { ... },           // ❌ Espace
    "user-name": { ... },           // ✅ Valide
    "userName": { ... },            // ✅ Valide
    "user_name": { ... },           // ✅ Valide
    "nom d'utilisateur": { ... },   // ❌ Espace + accent
    "a".repeat(65): { ... }        // ❌ Trop long (>64)
  }
}
```

#### ✅ Noms Valides
```json
{
  "properties": {
    "user_name": { ... },
    "user-name": { ... },
    "userName": { ... },
    "user.id": { ... },
    "max_results": { ... }
  }
}
```

---

## SOLUTIONS

### Solution 1 : Désactiver Temporairement les Serveurs Suspects

Modifier `claude_desktop_config.json` pour désactiver temporairement les serveurs suspects :

```json
{
  "mcpServers": {
    "n8n-npx_disabled": {
      // ... config existante
    }
  }
}
```

Puis redémarrer Claude Code pour voir si l'erreur disparaît.

### Solution 2 : Corriger le Serveur MCP Personnalisé

Si c'est un serveur MCP personnalisé (comme `gmail-mcp-server.js`), corriger les schémas :

#### Avant (Invalide)
```javascript
inputSchema: {
  type: 'object',
  properties: {
    'user name': { type: 'string' },        // ❌ Espace
    'max results': { type: 'number' }       // ❌ Espace
  }
}
```

#### Après (Valide)
```javascript
inputSchema: {
  type: 'object',
  properties: {
    'user_name': { type: 'string' },        // ✅ Underscore
    'max_results': { type: 'number' }       // ✅ Underscore
  }
}
```

### Solution 3 : Mettre à Jour les Packages MCP

Certains packages MCP peuvent avoir des bugs dans leurs schémas :

```bash
# Mettre à jour tous les packages MCP
npx -y @modelcontextprotocol/server-github@latest
npx -y @modelcontextprotocol/server-filesystem@latest
npx -y @playwright/mcp@latest
# etc.
```

### Solution 4 : Filtrer les Outils Problématiques

Si le problème vient d'un serveur externe que vous ne contrôlez pas, vous pouvez créer un wrapper qui filtre/corrige les schémas :

```javascript
// wrapper-mcp-server.js
function sanitizeSchema(schema) {
  if (schema.properties) {
    const sanitized = {};
    for (const [key, value] of Object.entries(schema.properties)) {
      // Remplacer les caractères invalides
      const sanitizedKey = key
        .replace(/\s+/g, '_')           // Espaces → underscore
        .replace(/[^a-zA-Z0-9_.-]/g, '') // Supprimer caractères invalides
        .substring(0, 64);               // Limiter à 64 caractères
      
      sanitized[sanitizedKey] = value;
    }
    schema.properties = sanitized;
  }
  return schema;
}
```

---

## ACTIONS IMMÉDIATES

### 1. Vérifier le Serveur Gmail (Le Plus Suspect)

Le serveur `gmail-mcp-server.js` est personnalisé et pourrait avoir le problème. Vérifiez les lignes 145-162 :

```javascript
// Ligne 145-151
inputSchema: {
  type: 'object',
  properties: {
    query: { type: 'string', description: 'Gmail search query' },
    maxResults: { type: 'number', description: 'Max results (default: 10)' }
  }
}
```

✅ Ces propriétés sont valides (`query`, `maxResults`).

### 2. Vérifier n8n-npx

Le serveur n8n peut exposer beaucoup d'outils dynamiques basés sur vos workflows. Si un workflow a des paramètres avec des noms invalides, cela causera l'erreur.

**Solution** : Vérifier vos workflows n8n et renommer les paramètres pour qu'ils respectent le pattern.

### 3. Script de Diagnostic

Créez un script pour lister tous les outils et leurs schémas :

```javascript
// diagnose-mcp-tools.js
// Ce script devrait être exécuté par Claude Code pour diagnostiquer
```

---

## CORRECTION RECOMMANDÉE

### Pour le Serveur Gmail

Le serveur Gmail semble correct, mais vérifions s'il y a d'autres outils ajoutés dynamiquement. Si vous avez ajouté des outils personnalisés, assurez-vous que tous les noms de propriétés respectent le pattern.

### Pour n8n

Si le problème vient de n8n :

1. **Vérifier les workflows** : Ouvrez n8n et vérifiez tous les workflows
2. **Renommer les paramètres** : Assurez-vous que tous les noms de paramètres respectent `^[a-zA-Z0-9_.-]{1,64}$`
3. **Désactiver temporairement** : Si nécessaire, désactivez n8n-npx temporairement

---

## VÉRIFICATION FINALE

Après correction, vérifiez que :

1. ✅ Tous les noms de propriétés sont en `snake_case`, `camelCase`, ou `kebab-case`
2. ✅ Aucun espace dans les noms
3. ✅ Aucun caractère spécial (sauf `_`, `.`, `-`)
4. ✅ Aucun nom > 64 caractères
5. ✅ Redémarrer Claude Code

---

## COMMANDES UTILES

```powershell
# Redémarrer Claude Code
# Fermer et rouvrir l'application

# Vérifier les logs MCP
Get-Content "C:\Users\Utilisateur\AppData\Roaming\Claude\mcp.log" -Tail 50

# Lister les serveurs MCP actifs
# Dans Claude Code : Settings > MCP Servers
```

---

*Guide de correction - Erreur schéma MCP Tool 51*  
*Date : 15 décembre 2025*




