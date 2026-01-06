#!/bin/bash
# Script pour telecharger les livres manquants depuis Anna's Archive

DEST_DIR="livres-critiques"
mkdir -p "$DEST_DIR"

# Fonction pour rechercher et extraire le MD5 d'un livre
search_book() {
    local query="$1"
    local md5=$(curl -s "https://annas-archive.org/search?q=${query// /+}" | grep -oE '/md5/[a-f0-9]+' | head -1 | sed 's|/md5/||')
    echo "$md5"
}

# Liste des livres a telecharger
declare -A BOOKS=(
    ["start+with+no+jim+camp"]="Start_with_No_Jim_Camp"
    ["sociopath+next+door+martha+stout"]="Sociopath_Next_Door_Martha_Stout"
    ["psychopath+free+jackson+mackenzie"]="Psychopath_Free_Jackson_MacKenzie"
    ["thinking+in+bets+annie+duke"]="Thinking_in_Bets_Annie_Duke"
    ["crucial+conversations+patterson"]="Crucial_Conversations_Patterson"
    ["difficult+conversations+stone+patton"]="Difficult_Conversations_Stone"
    ["nonviolent+communication+rosenberg"]="Nonviolent_Communication_Rosenberg"
    ["no+asshole+rule+robert+sutton"]="No_Asshole_Rule_Sutton"
    ["without+conscience+robert+hare"]="Without_Conscience_Robert_Hare"
)

echo "=== Recherche des livres sur Anna's Archive ==="
for query in "${!BOOKS[@]}"; do
    name="${BOOKS[$query]}"
    echo "Recherche: $name"
    md5=$(curl -s "https://annas-archive.org/search?q=$query" | grep -oE '/md5/[a-f0-9]+' | head -1 | sed 's|/md5/||')
    if [ -n "$md5" ]; then
        echo "  MD5: $md5"
        echo "$md5|$name" >> "$DEST_DIR/download-queue.txt"
    else
        echo "  Non trouve!"
    fi
done

echo ""
echo "=== Queue de telechargement creee ==="
cat "$DEST_DIR/download-queue.txt"
