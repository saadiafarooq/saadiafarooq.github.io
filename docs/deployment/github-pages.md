# GitHub Pages Deployment

This website automatically deploys to GitHub Pages when changes are pushed to the `main` branch.

## How It Works

The deployment process is fully automated using GitHub Actions.

### Workflow Overview

1. **Push to main branch** - Trigger deployment
2. **GitHub Actions runs** - Workflow defined in `.github/workflows/publish.yaml`
3. **Site builds** - Hugo generates static files
4. **Search index created** - Pagefind indexes content
5. **Deployment** - Files published to GitHub Pages
6. **Live update** - Changes appear at https://saadiafarooq.github.io/

### Build Steps

The workflow performs these steps:

1. **Checkout code** - Gets latest repository content
2. **Setup Hugo** - Installs Hugo v0.136.5
3. **Configure Pages** - Sets up GitHub Pages environment
4. **Build** - Runs `hugo --minify`
5. **Generate search** - Runs `npx pagefind --site "public"`
6. **Upload artifact** - Prepares built site for deployment
7. **Deploy** - Publishes to GitHub Pages

### Timing

- **Trigger**: Immediate on push to `main`
- **Build time**: 1-2 minutes
- **Total time to live**: 2-5 minutes

## Monitoring Deployments

### Check Deployment Status

1. Go to repository on GitHub
2. Click **Actions** tab
3. See recent workflow runs
4. Green checkmark = successful
5. Red X = failed (click for details)

### View Build Logs

1. Click on a workflow run
2. Click **build** job
3. Expand steps to see detailed logs
4. Check for errors or warnings

## Deployment Configuration

### Workflow File

Location: `.github/workflows/publish.yaml`

Key settings:
```yaml
env:
  WC_HUGO_VERSION: '0.136.5'  # Hugo version

on:
  push:
    branches: ["main"]  # Deploys on push to main
  workflow_dispatch:    # Can trigger manually
```

### Hugo Base URL

The workflow automatically sets the correct base URL:
```yaml
hugo --minify --baseURL "${{ steps.pages.outputs.base_url }}/"
```

No manual configuration needed!

## Manual Deployment

You can trigger a deployment manually without pushing code:

1. Go to repository on GitHub
2. Click **Actions** tab
3. Click **Deploy website to GitHub Pages** workflow
4. Click **Run workflow** button
5. Click **Run workflow** (confirm)

## Troubleshooting Deployments

### Build Failed

**Check the logs**:
1. Go to Actions tab
2. Click failed run (red X)
3. Review error messages

**Common causes**:
- YAML syntax error in front matter
- Missing required files
- Hugo version incompatibility
- Build timeout

### Changes Not Appearing

**Wait longer**:
- Allow 5 minutes for deployment
- Clear browser cache
- Try incognito/private browsing

**Verify push succeeded**:
- Check repository commits on GitHub
- Ensure you clicked "Push" in VS Code

### Old Content Still Showing

**Clear caches**:
1. Hard refresh: `Cmd+Shift+R` or `Ctrl+Shift+R`
2. Clear browser cache completely
3. Try different browser

**Check deployment**:
- Verify Actions shows green checkmark
- Check deployed commit hash matches latest

## GitHub Pages Settings

### Repository Settings

1. Go to repository **Settings**
2. Click **Pages** (left sidebar)
3. Verify:
   - Source: **GitHub Actions**
   - Custom domain (if applicable)

### Custom Domain (Optional)

To use a custom domain:

1. Add `CNAME` file to `static/` directory
2. Contents: your domain (e.g., `saadiafarooq.com`)
3. Configure DNS with your domain provider
4. Wait for DNS propagation (24-48 hours)

## Build Environment

### Hugo Version

**Current**: 0.136.5

**Updating**:
1. Edit `.github/workflows/publish.yaml`
2. Change `WC_HUGO_VERSION: '0.136.5'`
3. Test locally first!
4. Commit and push

### Environment Variables

Set in workflow file:
- `HUGO_ENVIRONMENT: production`
- `WC_HUGO_VERSION: 0.136.5`

### Caching

The workflow caches Hugo modules for faster builds:
```yaml
- uses: actions/cache@v3
  with:
    path: /tmp/hugo_cache_runner/
    key: ${{ runner.os }}-hugomod-${{ hashFiles('**/go.mod') }}
```

## Security

### Permissions

The workflow requires:
```yaml
permissions:
  contents: read   # Read repository
  pages: write     # Write to Pages
  id-token: write  # Deploy to Pages
```

### Protected Branch (Optional)

To prevent accidental deployments:

1. Settings → Branches
2. Add rule for `main`
3. Require pull request reviews
4. Require status checks

## Performance

### Build Optimization

The build is optimized with:
- `--minify` flag (smaller files)
- `--gc` flag (cleanup)
- Cached modules
- Pagefind indexing

### Deployment Speed

Factors affecting speed:
- Repository size
- Number of content files
- Image processing
- GitHub Actions queue

## Comparing with Local Builds

### Production Build Locally

Match the GitHub Actions environment:

```bash
hugo --minify --baseURL "http://localhost:1313/"
npx pagefind --site "public"
```

### Differences

**GitHub Actions**:
- Clean environment every time
- Specific Hugo version
- Production base URL
- Full rebuild

**Local Development**:
- Incremental builds
- Draft content visible
- Local base URL
- Caches preserved

## Rollback

### Revert to Previous Version

If something breaks:

1. **Option A: Revert commit**
   ```bash
   git revert HEAD
   git push
   ```

2. **Option B: Reset to previous commit**
   ```bash
   git reset --hard <commit-hash>
   git push --force
   ```

3. **Option C: Restore from GitHub**
   - Find working commit on GitHub
   - Download as ZIP
   - Replace local files
   - Commit and push

## Monitoring

### Check Site Health

- **Live site**: https://saadiafarooq.github.io/
- **Build status**: https://github.com/saadiafarooq/saadiafarooq.github.io/actions

### Notifications

Enable email notifications for failed builds:

1. Profile → Settings
2. Notifications → Actions
3. Enable "Send notifications for failed workflows"

## Next Steps

- [Build Process](./build-process.md) - Understanding the build
- [Troubleshooting](../development/troubleshooting.md) - Common issues
- [Development Setup](../development/setup.md) - Local development
