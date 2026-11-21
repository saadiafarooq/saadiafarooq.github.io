# Makefile for Hugo website deployment
# This file provides convenient targets for building and deploying the website

.PHONY: build deploy full-deploy help

# Default target
help:
	@echo "Available targets:"
	@echo "  make build    - Build the Hugo site"
	@echo "  make deploy   - Deploy the built site"
	@echo "  make full-deploy - Build and deploy the site"
	@echo "  make help     - Show this help message"

# Build the Hugo site
build:
	mise run build

# Deploy the built site
deploy:
	mise run deploy

# Build and deploy the site
full-deploy: build deploy