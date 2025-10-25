# Developer Setup Guide

This guide helps you set up the development environment for the Hugo academic website.

## Quick Start

### 1. Install Tools (Automatic!)

**This workspace automatically installs mise and tools when you open it!**

When you first open this workspace in VS Code:

1. VS Code will prompt: "This folder has tasks that run automatically"
2. Click **"Allow"** to enable automatic setup
3. The bootstrap script runs silently and installs:
   - mise (if not already installed)
   - Hugo 0.136.5
   - Python 3.13
   - All other tools defined in `mise.toml`

**No manual installation needed!** The workspace handles everything.

#### Manual Installation (Optional)

If you prefer manual setup or the automatic process fails:

```bash
# Option 1: Run the bootstrap script
bash .vscode/mise.bootstrap.sh

# Option 2: Install mise globally
curl https://mise.run | sh
mise install
```

Or install Hugo manually:

- **macOS**: `brew install hugo`
- **Linux**: Download from [Hugo releases](https://github.com/gohugoio/hugo/releases)
- **Windows**: `choco install hugo-extended`

See `.vscode/MISE_SETUP.md` for detailed mise configuration.

### 2. Install Dependencies

```bash
# Install Hugo modules
hugo mod get -u
hugo mod tidy
```

### 3. Start Development Server

#### Option A: Using VS Code Tasks

1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type "Tasks: Run Task"
3. Select "Hugo: Start Server"

#### Option B: Using Terminal

```bash
hugo server --disableFastRender --buildDrafts --buildFuture
```

The site will be available at http://localhost:1313/

## VS Code Setup

### Recommended Extensions

When you open this workspace, VS Code will prompt you to install recommended extensions. Key extensions include:

- **Hugo Language Support**: Syntax highlighting and IntelliSense
- **Front Matter CMS**: Visual content management
- **Markdown All in One**: Enhanced markdown editing
- **YAML Support**: Config file editing
- **Go**: For Hugo modules

### Available Tasks

Press `Cmd+Shift+B` (macOS) or `Ctrl+Shift+B` (Windows/Linux) to see all available tasks:

- **Hugo: Start Server** - Start dev server with drafts
- **Hugo: Start Server (Production)** - Start production-like server
- **Hugo: Build Site** - Build static site (default build task)
- **Hugo: Build with Search Index** - Build site + generate pagefind search
- **Hugo: Clean Public Directory** - Remove generated files
- **Hugo: Check Config** - Validate Hugo configuration
- **Hugo: New Post** - Create a new blog post
- **Go: Update Hugo Modules** - Update theme modules

### Launch Configurations

Use the Debug panel (F5) to launch:

- Hugo development server
- Hugo production server

## Project Structure

```markdown
.
├── config/          # Hugo configuration files
│   └── _default/    # Default config (hugo.yaml, params.yaml, etc.)
├── content/         # All markdown content
│   ├── authors/     # Author profiles
│   ├── post/        # Blog posts
│   ├── publication/ # Academic publications
│   └── project/     # Project showcases
├── layouts/         # Custom Hugo templates
│   └── partials/    # Reusable template partials
├── assets/          # Source assets (SCSS, JS, images)
├── static/          # Static files (copied as-is)
├── public/          # Generated site (git-tracked for GitHub Pages)
└── .vscode/         # VS Code workspace settings
```

## Common Workflows

### Adding Content

#### New Blog Post

1. Run task: "Hugo: New Post"
2. Enter slug (e.g., `my-awesome-post`)
3. Edit the created file in `content/post/my-awesome-post/_index.md`

#### New Author

1. Copy `content/authors/saadia/` to `content/authors/your-name/`
2. Edit `_index.md` with your information
3. Add avatar image as `avatar.jpg` in the same folder

#### New Publication

1. Copy an example from `content/publication/`
2. Edit front matter (title, authors, date, publication, etc.)
3. Add featured image if needed

### Building for Production

```bash
# Build site with minification
hugo --gc --minify

# Build with search index (matches GitHub Actions)
hugo --minify && npx pagefind --site "public"
```

### Updating Theme

The site uses Hugo Blox modules. To update:

```bash
hugo mod get -u
hugo mod tidy
```

Or use the VS Code task: "Go: Update Hugo Modules"

### Testing Before Deploy

```bash
# Run production build locally
hugo server --disableFastRender --environment production
```

Visit http://localhost:1313/ to preview exactly as it will appear on GitHub Pages.

## GitHub Pages Deployment

The site deploys automatically via GitHub Actions (`.github/workflows/publish.yaml`) when you push to `main`:

1. Make changes to content or config
2. Test locally with `hugo server`
3. Commit and push to `main` branch
4. GitHub Actions builds and deploys automatically
5. Site updates at https://saadiafarooq.github.io/

## Troubleshooting

### Hugo version mismatch

Ensure you're using Hugo 0.136.5 (matches GitHub Actions):

```bash
hugo version
```

### Module errors

Clear module cache and reinstall:

```bash
hugo mod clean
hugo mod get -u
hugo mod tidy
```

### Build fails

Clean generated files and rebuild:

```bash
rm -rf public resources
hugo --gc --minify
```

### Port already in use

Kill existing Hugo server:

```bash
pkill hugo
# or specify different port
hugo server --port 1314
```

## Additional Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Blox Documentation](https://docs.hugoblox.com/)
- [Hugo Blox Community Discord](https://discord.gg/z8wNYzb)
- [Copilot Instructions](../.github/copilot-instructions.md) - For AI-assisted development

## Tips

- Use `Cmd+Shift+P` > "Markdown: Open Preview" to preview markdown files
- Front Matter CMS extension provides a visual content editor
- Enable auto-save: "File > Auto Save" for live preview updates
- Use the integrated terminal for Hugo commands
- Check `.vscode/tasks.json` for all available automation tasks
