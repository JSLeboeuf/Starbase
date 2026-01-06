# 🔄 Régénérer le Token Gmail pour jsleboeuf3@gmail.com

## ⚠️ PROBLÈME ACTUEL
Le `GOOGLE_REFRESH_TOKEN` actuel est associé à `contact@autoscaleai.ca` au lieu de `jsleboeuf3@gmail.com`.

---

## 🔧 SOLUTION: Régénérer le Token OAuth

### Méthode 1: Supprimer le token et relancer (Recommandé)

```bash
# 1. Supprimer les tokens existants
rm -rf ~/.gmail-mcp-tokens/
rm -rf ~/.config/gmail-mcp/

# 2. Redémarrer Cursor
# Le MCP va automatiquement lancer le flow OAuth
```

Quand le navigateur s'ouvre, **connecte-toi avec `jsleboeuf3@gmail.com`** (pas contact@autoscaleai.ca).

---

### Méthode 2: Générer manuellement via Google Cloud Console

1. **Aller sur:** https://console.cloud.google.com/apis/credentials
2. **Projet:** Utiliser le projet avec Client ID `767920457238-...`
3. **OAuth 2.0 Playground:** https://developers.google.com/oauthplayground/

#### Étapes OAuth Playground:
1. Cliquer sur ⚙️ (Settings) en haut à droite
2. Cocher "Use your own OAuth credentials"
3. Entrer:
   - Client ID: `767920457238-eu3b18esg22fhrrv3djbargbgfvp22jg.apps.googleusercontent.com`
   - Client Secret: `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`
4. Dans "Select & authorize APIs", chercher et sélectionner:
   - `https://mail.google.com/`
   - `https://www.googleapis.com/auth/gmail.modify`
   - `https://www.googleapis.com/auth/gmail.readonly`
5. Cliquer "Authorize APIs"
6. **Se connecter avec `jsleboeuf3@gmail.com`**
7. Cliquer "Exchange authorization code for tokens"
8. Copier le nouveau `refresh_token`

---

### Méthode 3: Script de régénération

```bash
# Exécuter ce script pour lancer l'authentification
npx @gongrzhe/server-gmail-autoauth-mcp --account jsleboeuf3 --reauth
```

---

## 📝 APRÈS RÉGÉNÉRATION

Une fois le nouveau token obtenu, mettre à jour `~/.cursor/mcp.json`:

```json
"gmail-jsleboeuf": {
  "command": "npx",
  "args": ["-y", "@gongrzhe/server-gmail-autoauth-mcp", "--account", "jsleboeuf3"],
  "env": {
    "GOOGLE_CLIENT_ID": "767920457238-eu3b18esg22fhrrv3djbargbgfvp22jg.apps.googleusercontent.com",
    "GOOGLE_CLIENT_SECRET": "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",
    "GOOGLE_REFRESH_TOKEN": "NOUVEAU_TOKEN_ICI"
  }
}
```

---

## ✅ VÉRIFICATION

Après redémarrage de Cursor, tester avec:
- Recherche: `from:nicolas.marois@notavo.ca`
- Si des résultats apparaissent → ✅ Succès!



