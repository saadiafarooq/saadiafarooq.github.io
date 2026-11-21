#!/usr/bin/env bash
# Deployment task for Hugo site
# This task runs the deployment process using mise-managed tools

set -e

echo "🚀 Running deployment task..."

# Run the setup task first
echo "📦 Running setup task..."
mise run setup

# Build the site
echo "🔨 Building Hugo site..."
hugo

# Deploy the site
echo "📤 Deploying site..."
# Add your deployment logic here (e.g., rsync, git push, etc.)
# Example: rsync -avz --delete public/ user@server:/path/to/deploy

echo "✅ Deployment complete!"