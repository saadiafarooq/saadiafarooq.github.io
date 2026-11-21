#!/usr/bin/env bash
set -euo pipefail

# Hugo setup task
# Installs Hugo using mise and builds the site

echo "📦 Installing Hugo using mise..."
mise install hugo-extended@0.136.5

echo "🔧 Setting up Hugo environment..."
export PATH="$HOME/.local/share/mise/shims:$PATH"

echo "🔨 Building Hugo site..."
cd /workspace
hugo --minify --cleanDestinationDir

echo "✅ Hugo setup complete!"