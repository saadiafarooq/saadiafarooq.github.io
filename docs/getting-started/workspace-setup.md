# Quick Start: Opening the Workspace for the First Time

## Visual Guide

```.markdown
┌─────────────────────────────────────────────────────────────┐
│  1. Open Workspace                                          │
│  $ code saadiafarooq.code-workspace                        │
│  (or open folder in VS Code)                               │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  2. VS Code Prompt Appears                                  │
│  ┌────────────────────────────────────────────────────┐    │
│  │ ⚠️  This folder has tasks that run automatically   │    │
│  │                                                     │    │
│  │  Task: Setup: Bootstrap mise                       │    │
│  │                                                     │    │
│  │        [Allow]    [Disallow]    [Not This Time]   │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼ (Click "Allow")
┌─────────────────────────────────────────────────────────────┐
│  3. Automatic Bootstrap Runs (Silent)                       │
│  ┌────────────────────────────────────────────────────┐    │
│  │ Terminal: Running task 'Setup: Bootstrap mise'     │    │
│  │                                                     │    │
│  │ Checking for mise...                               │    │
│  │ Installing mise to .mise/mise-2025.10.8...        │    │
│  │ Installing Hugo 0.136.5...                         │    │
│  │ Installing Python 3.13...                          │    │
│  │ ✅ Bootstrap complete!                             │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  4. Ready to Develop! 🎉                                    │
│  • Hugo is installed and ready                              │
│  • Python is installed and ready                            │
│  • All tools from mise.toml are ready                       │
│  • No manual setup needed                                   │
│                                                              │
│  Next: Press Cmd+Shift+B to start Hugo server              │
└─────────────────────────────────────────────────────────────┘
```

## What Just Happened?

When you clicked "Allow":

1. ✅ **mise installed** locally to `.mise/` directory
2. ✅ **Hugo 0.136.5** installed via mise
3. ✅ **Python 3.13** installed via mise
4. ✅ **All tools ready** to use immediately

## Subsequent Opens

Next time you open the workspace:

- Bootstrap script runs automatically (takes ~1 second)
- Verifies all tools are present
- No prompts, no downloads needed
- Ready to develop immediately

## Quick Actions

### Start Hugo Server

```bash
Cmd+Shift+B
```

Or:

- Press `F5` (Debug panel)
- Run task: "Hugo: Start Server"

### Create New Post

```bash
Cmd+Shift+P → "Tasks: Run Task" → "Hugo: New Post"
```

### Build Site

```bash
Cmd+Shift+B
```

(Default build task)

### Check Installed Tools

```bash
mise list
hugo version
python --version
```

## Files Created

The bootstrap process creates:

```markdown
.mise/
├── mise-2025.10.8          # mise binary
├── installs/
│   ├── hugo-extended@0.136.5/
│   └── python@3.13/
├── cache/
├── state/
└── config/
```

## Troubleshooting

**Didn't see the prompt?**

- Settings may have automatic tasks disabled
- Manually run: `Cmd+Shift+P` → "Tasks: Run Task" → "Setup: Bootstrap mise"

**Bootstrap failed?**

- Check internet connection
- Try manual install: `bash .vscode/mise.bootstrap.sh`
- See `.vscode/MISE_SETUP.md` for help

**Tools not found?**

- Restart VS Code
- Check `mise doctor` for diagnostics
- Try `mise install` manually

## Documentation

- 📖 **MISE_SETUP.md** - Detailed mise setup guide
- 📖 **DEVELOPMENT.md** - Full developer guide
- 📖 **MISE_INTEGRATION.md** - Technical integration details
- 📖 **SETUP_COMPLETE.md** - Complete feature list

---

**That's it!** You're ready to start developing. The workspace handles all setup automatically. 🚀
