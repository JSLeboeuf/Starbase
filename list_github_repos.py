import urllib.request
import json

token = "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"
url = "https://api.github.com/user/repos?per_page=100&type=all"

req = urllib.request.Request(url)
req.add_header("Authorization", f"Bearer {token}")
req.add_header("User-Agent", "Python")

try:
    with urllib.request.urlopen(req) as response:
        repos = json.loads(response.read().decode())
        print(f"\n{'='*60}")
        print(f"TOTAL: {len(repos)} dépôts trouvés")
        print(f"{'='*60}\n")
        
        for repo in repos:
            visibility = "🔒 PRIVÉ" if repo.get('private') else "🌐 Public"
            print(f"{visibility} | {repo['name']}")
            print(f"   URL: {repo['html_url']}")
            print(f"   Description: {repo.get('description', 'Aucune')}")
            print()
except Exception as e:
    print(f"Erreur: {e}")





