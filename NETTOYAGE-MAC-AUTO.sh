#!/bin/bash
# Script de nettoyage Mac pour performance maximale
# Projet JEROME - 21 decembre 2025

echo "🧹 NETTOYAGE MAC - PERFORMANCE MAXIMALE"
echo "========================================"

# 1. Backup Cursor (souvent énorme)
if [ -f ~/Library/Application\ Support/Cursor/User/globalStorage/state.vscdb.backup ]; then
    SIZE=$(du -sh ~/Library/Application\ Support/Cursor/User/globalStorage/state.vscdb.backup | cut -f1)
    rm -f ~/Library/Application\ Support/Cursor/User/globalStorage/state.vscdb.backup
    echo "✅ Backup Cursor supprimé ($SIZE)"
fi

# 2. Caches système
rm -rf ~/Library/Caches/Comet/* 2>/dev/null
rm -rf ~/Library/Caches/node-gyp/* 2>/dev/null
rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null
echo "✅ Caches système nettoyés"

# 3. Logs Cursor
rm -rf ~/Library/Application\ Support/Cursor/logs/* 2>/dev/null
echo "✅ Logs Cursor nettoyés"

# 4. npm cache
npm cache clean --force 2>/dev/null
echo "✅ Cache npm nettoyé"

# 5. Homebrew
brew cleanup 2>/dev/null
echo "✅ Homebrew nettoyé"

# 6. Downloads - installers
rm -f ~/Downloads/*.dmg 2>/dev/null
rm -f ~/Downloads/*.pkg 2>/dev/null
echo "✅ Installers supprimés"

# 7. Corbeille
rm -rf ~/.Trash/* 2>/dev/null
echo "✅ Corbeille vidée"

# 8. pnpm cache (si existe)
pnpm store prune 2>/dev/null
echo "✅ Cache pnpm nettoyé"

# Résultat
echo ""
echo "📊 ESPACE DISQUE ACTUEL:"
df -h /

echo ""
echo "🎯 Nettoyage terminé!"


