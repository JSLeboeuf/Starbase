# DOCUMENTATION OVERVIEW - AI Context

## 🎯 Purpose
Route Claude to the right documentation based on task type.

## 📚 Documentation Tiers

### Tier 1: Foundation (Auto-loaded)
| File | Purpose | Load When |
|------|---------|-----------|
| `CLAUDE.md` | AI config, rules, capabilities | Always |
| `.cursorrules` | IDE behavior | Always |
| `docs/ai-context/project-structure.md` | Project layout | Always |

### Tier 2: Component Level
| Directory | Purpose | Load When |
|-----------|---------|-----------|
| `docs/` | General documentation | On demand |
| `scripts/` | Automation scripts | DevOps tasks |

### Tier 3: Feature Level
| Pattern | Purpose |
|---------|---------|
| `*/README.md` | Feature-specific docs |
| `*/CONTEXT.md` | AI context for subdirs |

## 🔍 Documentation Routing

```yaml
Task: "Build API"
  → Load: CLAUDE.md, project-structure.md
  → Reference: Backend patterns

Task: "Deploy"
  → Load: CLAUDE.md, scripts/
  → Reference: DevOps docs

Task: "Debug"
  → Load: CLAUDE.md, error logs
  → Reference: Troubleshooting guides
```

## 📖 External Documentation

| Resource | URL | Use For |
|----------|-----|---------|
| Next.js | nextjs.org/docs | Frontend |
| Supabase | supabase.com/docs | Backend |
| TailwindCSS | tailwindcss.com/docs | Styling |
| Claude API | docs.anthropic.com | AI integration |

## 🧠 Context Loading Strategy

1. **Always load**: CLAUDE.md (defines behavior)
2. **Task-based**: Load relevant tier 2/3 docs
3. **On-demand**: Fetch external docs via Context7 MCP
4. **Cache**: Recent context for 2 hours




