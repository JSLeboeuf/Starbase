#!/bin/bash
# Script de démarrage environnement dev optimisé
# Projet JEROME - Performance Maximale

echo "🚀 DÉMARRAGE ENVIRONNEMENT DEV OPTIMISÉ"
echo "========================================"
echo ""

# 1. Charger variables d'environnement
source ~/.zshrc 2>/dev/null

# 2. Afficher config
echo "📦 Node.js: $(node -v 2>/dev/null || echo 'non installé')"
echo "📦 Heap Max: ${NODE_OPTIONS:-'non configuré'}"
echo "📦 Thread Pool: ${UV_THREADPOOL_SIZE:-4}"
echo ""

# 3. Vérifier espace disque
DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')
DISK_PERCENT=$(df -h / | tail -1 | awk '{print $5}')
echo "💾 Espace disque: $DISK_FREE disponible ($DISK_PERCENT utilisé)"

if [[ "${DISK_PERCENT%\%}" -gt 90 ]]; then
    echo "⚠️  ATTENTION: Espace disque faible! Exécuter NETTOYAGE-MAC-AUTO.sh"
fi
echo ""

# 4. Vérifier mémoire
echo "🧠 Mémoire:"
vm_stat | head -5
echo ""

# 5. Désactiver Spotlight pour le projet (silencieux)
sudo mdutil -i off ~/GitHub/jerome 2>/dev/null && echo "🔍 Spotlight désactivé pour le projet"

# 6. Vérifier Docker et Qdrant (optionnel)
if command -v docker &> /dev/null; then
    if docker ps | grep -q qdrant 2>/dev/null; then
        echo "🗄️  Qdrant: Actif (localhost:6333)"
    else
        echo "🗄️  Qdrant: Non actif (docker start qdrant pour activer)"
    fi
fi

echo ""
echo "✅ Environnement prêt!"
echo ""
echo "📂 Commandes utiles:"
echo "   cursor .              - Ouvrir Cursor IDE"
echo "   ./NETTOYAGE-MAC-AUTO.sh - Libérer espace disque"
echo "   docker start qdrant   - Démarrer vector DB"
echo ""


