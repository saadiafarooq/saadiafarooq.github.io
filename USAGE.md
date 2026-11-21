# Mise-based Deployment Workflow - Usage Guide

## Overview

This guide explains how to use the new mise-based GitHub Actions workflow for deploying this Hugo site.

## Workflow Files

- **`.github/workflows/publish-mise.yaml`**: Main workflow file using mise actions
- **`tasks.yaml`**: Mise tasks for Hugo build and deployment
- **`.mise.toml`**: Mise configuration with tools and environment variables

## How It Works

1. **Trigger**: Workflow runs on push to `main` branch or via workflow_dispatch
2. **Setup**: `jdx/mise-action@v4` installs required tools using mise
3. **Execution**: Runs tasks defined in `tasks.yaml` for build and deployment
4. **Deployment**: Deploys to production via SSH

## Usage

### Automatic Deployment

The workflow automatically deploys when you push to the `main` branch:

```bash
git add .
git commit -m "Your commit message"
git push origin main
```

### Manual Deployment

You can manually trigger the workflow from GitHub Actions UI:

1. Go to **Actions** tab in your repository
2. Select **Publish Site (Mise)** workflow
3. Click **Run workflow**
4. Select branch (usually `main`)
5. Click **Run workflow** button

## Available Tasks

The `tasks.yaml` file defines several tasks:

### Build Tasks

- **`hugo`**: Build the site with default settings
- **`hugo-verbose`**: Build with verbose output for debugging
- **`hugo-check`**: Check for errors without building

### Deployment Tasks

- **`deploy`**: Deploy to production (default target)
- **`deploy-custom`**: Deploy to custom target (requires TARGET environment variable)

### Development Tasks

- **`preview`**: Build and preview locally
- **`serve`**: Serve locally with hot reload
- **`serve-live`**: Serve with live reload (for development)

### Utility Tasks

- **`clean`**: Clean build artifacts
- **`sitemap`**: Generate sitemap
- **`rss`**: Generate RSS feed

## Environment Variables

Configure deployment settings in GitHub repository secrets:

- **`DEPLOY_HOST`**: SSH host for deployment
- **`DEPLOY_USER`**: SSH username for deployment
- **`DEPLOY_PATH`**: Remote path for deployment
- **`TARGET`**: Custom deployment target (for `deploy-custom` task)

### Setting Up Secrets

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:
   - `DEPLOY_HOST`: e.g., `your-server.com`
   - `DEPLOY_USER`: e.g., `deploy`
   - `DEPLOY_PATH`: e.g., `/var/www/html`
   - `TARGET`: e.g., `production` (optional)

## Local Development

### Install Mise

```bash
# macOS
brew install mise

# Linux
curl https://mise.run | sh
```

### Install Tools

```bash
mise install
```

### Run Tasks Locally

```bash
# Build
mise run hugo

# Serve with hot reload
mise run serve

# Preview
mise run preview

# Generate sitemap
mise run sitemap
```

## Troubleshooting

### Workflow Fails at Setup

- Check that `.mise.toml` has correct tool versions
- Verify `tasks.yaml` syntax
- Ensure all required tools are available in mise

### Deployment Fails

- Verify GitHub secrets are correctly set
- Check SSH connectivity from GitHub Actions runner
- Ensure `DEPLOY_PATH` exists on remote server
- Review logs in GitHub Actions for detailed error messages

### Task Not Found

- Ensure `tasks.yaml` is in the repository root
- Check task names match exactly (case-sensitive)
- Verify mise is installed in the workflow environment

## Migration Notes

This workflow replaces the original `.github/workflows/publish.yaml` which used direct tool installation and shell commands. The new workflow:

- Uses `jdx/mise-action@v4` for tool installation
- Leverages `tasks.yaml` for task execution
- Provides better reproducibility and consistency
- Easier to maintain and extend

## Next Steps

After reviewing this guide:

1. Test the workflow locally with `mise run serve`
2. Verify the GitHub Actions workflow runs successfully
3. Deploy to staging first if available
4. Monitor the first production deployment
5. Remove the old `publish.yaml` workflow after confirming the new one works