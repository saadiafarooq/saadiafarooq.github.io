<!-- .github/copilot-instructions.md -->
# Repo-specific instructions for AI coding agents

This repository is a Hugo-based academic CV site (Hugo Blox / Academic CV starter). The guidance below is tightly scoped to make an AI agent immediately productive in this codebase.

Keep instructions concise and always reference the concrete files below when suggesting changes.

1) Big picture / architecture

- Static site generated with Hugo (see `config/_default/hugo.yaml` and `netlify.toml`).
- Theme / starter is Hugo Blox Academic CV (Go module declared in `go.mod`).
- Content is Markdown under `content/`; templates and page fragments live in `layouts/` and `layouts/partials/`.
- The public site is generated into `public/` (committed here). Netlify builds with `hugo --gc --minify` (see `netlify.toml`).

1) Primary developer workflows (what to run)

- Local build (production-like): `hugo --gc --minify -b http://localhost:1313/` or use the Hugo server for live preview: `hugo server --disableFastRender`.
- This site is published via GitHub Pages using a GitHub Actions workflow at `.github/workflows/publish.yaml`.
  - The workflow sets `WC_HUGO_VERSION: 0.136.5`, runs `hugo --minify --baseURL "${{ steps.pages.outputs.base_url }}/"`, then runs `npx pagefind --site "public"` and uploads `./public` as the pages artifact.
- When editing content, regenerate site or use `hugo server` to preview changes live.

1) Project-specific conventions and patterns

- Content front matter uses YAML; examples: `content/authors/saadia/_index.md` follows structured sections (profiles, interests, education, work, skills, awards). Keep YAML keys consistent when adding authors or publications.
- Rich blocks (blox) and custom partials are used. Small, presentational changes should be made in `layouts/partials/` and CSS under `assets/`/`static/` as appropriate.
- The `public/` folder contains generated artefacts and should be treated as a build output. When making content or layout changes, prefer editing `content/` and `layouts/` and then regenerating `public/` with Hugo; avoid manual edits to `public/` unless intentionally committing a build.
- Internationalization: `config/_default/hugo.yaml` defines `defaultContentLanguage: en`. CJK flags are set to false.

1) Integration points & external dependencies

- GitHub Pages: a workflow at `.github/workflows/publish.yaml` builds the site and deploys to Pages. It uses `peaceiris/actions-hugo@v2` to set up Hugo and `actions/deploy-pages@v4` to publish.
- Page search generation uses `pagefind` via `npx pagefind` after the Hugo build (see `.github/workflows/publish.yaml`).
- Hugo modules: `go.mod` lists two modules (`blox-plugin-netlify` and `blox-tailwind`). Do not edit `go.mod` unless adding/updating modules.
- External scripts: a single partial at `layouts/partials/hooks/head-end/github-button.html` loads the GitHub buttons script.

1) Code patterns and examples to follow

- When adding an author, mirror `content/authors/saadia/_index.md` structure: YAML top-matter with `first_name`, `last_name`, `profiles` array (use `assets/media/icons/` for custom icons), and `education/work/skills` arrays.
- Use Hugo shortcodes or partials for repeated UI bits. If you need a new partial, place it in `layouts/partials/` and include with `{{ partial "name.html" . }}`.
- Keep content Markdown clean; long summaries use YAML block scalar `|` or `|2-` (see `education.summary` in `content/authors/saadia/_index.md`).

1) Tests, linting, and quality gates

- No automated unit tests in the repo. Quick validation steps:
  - `hugo check` (Hugo >= 0.104) if available to validate config and templates.
  - Build locally (`hugo --gc --minify`) and inspect `public/` output.
  - When changing assets, verify Tailwind/CSS pipeline behavior by checking the built CSS in `public/css/`.

1) Safe edit rules for AI changes

- Prefer edits to `content/`, `layouts/`, `assets/` and `config/`. Avoid editing `public/` except to regenerate builds.
- Do not change GitHub Actions workflows (`.github/workflows/publish.yaml`) or `go.mod` unless the change is required and you include rationale and a one-line test (e.g., `hugo --gc --minify` succeeds). If you update the Hugo version, also update the workflow's `WC_HUGO_VERSION` variable.
- When editing author or publication YAML, preserve existing keys and types. Use `|` for multi-line text.

1) What to include in PRs created by AI

- Short description of change and motivation.
- Build validation: `hugo --gc --minify` exit status and any warnings. If you updated styles, include screenshot or path to affected `public/` asset.
- If adding new module or dependency, include `go mod tidy` output and reasoning.

1) Useful files to reference quickly

- Config: `config/_default/hugo.yaml`
- Netlify build: `netlify.toml`
- Modules: `go.mod`
- Example author content: `content/authors/saadia/_index.md`
- Partials: `layouts/partials/`

If anything above is unclear, tell me which area you'd like expanded (build, content schema, partials, or deployment) and I'll iterate.
