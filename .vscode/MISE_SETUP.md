# Automatic mise Bootstrap on Workspace Open

This workspace is configured to automatically check and install mise when you open it.

## How It Works

1. **On First Open**: VS Code will show a prompt asking if you want to allow automatic tasks
   - Click "Allow" to enable automatic mise bootstrap
   - The bootstrap script will run silently in the background

2. **Bootstrap Script**: `.vscode/mise.bootstrap.sh`
   - Checks if mise is installed
   - If not, installs mise locally to `.mise/` directory
   - Installs all tools defined in `mise.toml` (Hugo, Python, etc.)

3. **Task Configuration**: `.vscode/tasks.json`
   - Task: "Setup: Bootstrap mise" runs automatically on folder open
   - Task: "Setup: Install Tools with mise" can be run manually

## Manual Installation

If you prefer to install mise manually or the automatic setup fails:

```bash
# Option 1: Use the bootstrap script
bash .vscode/mise.bootstrap.sh

# Option 2: Install mise globally
curl https://mise.run | sh

# Then install tools
mise install
```

## Verify Installation

```bash
# Check mise version
mise --version

# Check installed tools
mise list

# Check Hugo version
hugo version
```

## Settings

The workspace setting `task.allowAutomaticTasks` is set to `"on"` in `.vscode/settings.json` to enable this behavior.

If you want to disable automatic task execution:

1. Open `.vscode/settings.json`
2. Change `"task.allowAutomaticTasks": "on"` to `"off"`
3. Manually run "Setup: Bootstrap mise" task when needed

## Troubleshooting

**Task doesn't run automatically?**

- VS Code may prompt you to trust the workspace
- Check if "Allow Automatic Tasks" prompt appeared
- Manually run: `Cmd+Shift+P` → "Tasks: Run Task" → "Setup: Bootstrap mise"

**Bootstrap fails?**

- Check internet connection
- Try manual installation: `curl https://mise.run | sh`
- Check error output in VS Code terminal

**Tools not found after bootstrap?**

- Run `mise install` manually
- Restart VS Code to pick up new PATH entries
- Check `mise doctor` for diagnostic information
