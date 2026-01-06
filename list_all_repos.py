import urllib.request
import json

token = "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"
all_repos = []
page = 1

while True:
    url = f"https://api.github.com/user/repos?per_page=100&page={page}&type=all"
    req = urllib.request.Request(url)
    req.add_header("Authorization", f"Bearer {token}")
    req.add_header("User-Agent", "Python")
    
    try:
        with urllib.request.urlopen(req) as response:
            repos = json.loads(response.read().decode())
            if not repos:
                break
            all_repos.extend(repos)
            page += 1
    except Exception as e:
        print(f"Erreur: {e}")
        break

print(f"TOTAL: {len(all_repos)} repos")
for repo in all_repos:
    print(repo['name'])
