# PROJECT STRUCTURE - AI Context

## 🎯 Purpose
This document provides Claude with project structure awareness for better code generation.

## 📁 Directory Layout

```
C:\Users\Utilisateur\jerome\
├── CLAUDE.md                    # AI configuration (KRAKEN v14.0)
├── .cursorrules                 # Cursor IDE rules
├── kraken.ps1                   # Claude launcher (Windows)
├── docs/
│   └── ai-context/
│       ├── project-structure.md # This file
│       └── docs-overview.md     # Documentation routing
├── PROMPT-*.md                  # Various prompts
└── *.ps1                        # PowerShell scripts
```

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **OS** | Windows 11 |
| **IDE** | Cursor + Claude Code |
| **Shell** | PowerShell 7 |
| **Runtime** | Node.js 20+, Python 3.11+ |
| **Frontend** | Next.js 14, React 18, TailwindCSS |
| **Backend** | Supabase, Edge Functions |
| **AI** | Claude Opus 4.5, OpenAI, ElevenLabs |

## 🔧 Environment Variables

| Variable | Value | Purpose |
|----------|-------|---------|
| NODE_OPTIONS | --max-old-space-size=16384 | 16GB heap |
| UV_THREADPOOL_SIZE | 16 | Parallel I/O |
| npm_config_fund | false | Disable npm funding |
| npm_config_audit | false | Disable npm audit |

## 🔑 Key Files

- `CLAUDE.md` - Main AI configuration
- `.cursorrules` - IDE behavior rules
- `kraken.ps1` - Launcher script

## 📊 Active Projects

| Project | Repo | Stack |
|---------|------|-------|
| NEXUS | NEXUS-MONOREPO | Python, TypeScript |
| AutoScale AI | autoscale-ai | Next.js, Supabase |
| Voice Agents | milette-voice-agent | Python, VAPI |




