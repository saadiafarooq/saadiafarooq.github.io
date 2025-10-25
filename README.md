# Saadia Farooq's Academic Website

This repository contains the source code for Saadia Farooq's academic website, built with Hugo and deployed via GitHub Pages.

## About

A professional academic website showcasing research, publications, teaching, and professional experience. Built with the Hugo static site generator for fast, secure, and maintainable web presence.

## Quick Start

### For Content Editors

1. **Open the workspace** in VS Code
2. **Edit content** in the `content/` directory
3. **Preview locally** by pressing `Cmd+Shift+B`
4. **Publish** by committing and pushing changes

📖 **[Read the Quick Start Guide](./docs/getting-started/quick-start.md)** for detailed instructions.

### For Developers

The workspace includes automatic tool installation via mise. Simply open the workspace and click "Allow" when prompted.

📖 **[Read the Development Setup](./docs/development/setup.md)** for technical details.

## Documentation

Comprehensive documentation is available in the [`docs/`](./docs/) directory:

- **[Getting Started](./docs/getting-started/)** - For first-time users
- **[Editing Content](./docs/content-management/editing-content.md)** - Update existing content
- **[Adding Content](./docs/content-management/adding-content.md)** - Create new posts, publications
- **[Development](./docs/development/)** - For developers
- **[Troubleshooting](./docs/development/troubleshooting.md)** - Common issues and solutions

## Project Structure

```bash
.
├── content/          # All website content (Markdown)
├── config/           # Site configuration
├── layouts/          # Custom templates
├── static/           # Static files (images, PDFs)
├── docs/             # Documentation
└── .vscode/          # VS Code workspace configuration
```

## Technology Stack

- **Hugo**: Static site generator (v0.136.5+)
- **GitHub Pages**: Hosting
- **GitHub Actions**: Automated deployment
- **Pagefind**: Site search
- **mise**: Development tool management

## Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `main` branch. Deployment typically takes 2-5 minutes.

**Live site**: https://saadiafarooq.github.io/

## Local Development

### Prerequisites

- VS Code
- Git

### Setup

1. Clone this repository
2. Open in VS Code
3. Allow automatic tasks when prompted
4. Tools install automatically
5. Press `Cmd+Shift+B` to start the development server
6. Visit `http://localhost:1313`

See [Development Setup](./docs/development/setup.md) for detailed instructions.

## License

Content © Saadia Farooq. All rights reserved.

Website code is based on the Hugo Academic template.
