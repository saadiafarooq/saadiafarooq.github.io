# GitHub Actions to Mise Migration Plan

## Overview
Migrate the existing GitHub Actions workflow (.github/workflows/publish.yaml) to use mise for tool installation and task execution, reducing complexity and improving maintainability.

## Current State
- **Workflow**: .github/workflows/publish.yaml
- **Hugo Version**: 0.136.5
- **Runner**: ubuntu-26.04
- **Triggers**: push to main, workflow_dispatch
- **Actions Used**:
  - actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1
  - actions-hugo@d1c81a15d4e6dca7086a17b9c2565cb70fd576bf
  - actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9
  - actions/configure-pages@45bfe0192ca1faeb007ade9deae92b416b8254a0d

## Migration Strategy

### Phase 1: Create Mise Tasks
✅ **Completed**: Created tasks.yaml with comprehensive Hugo tasks
- build: Standard Hugo build
- build-verbose: Verbose build with logging
- deploy: Deploy to production
- deploy-custom: Custom deployment
- preview: Preview deployment
- clean: Clean build artifacts
- serve: Local Hugo server
- serve-live: Live preview server
- check: Check site health
- sitemap: Generate sitemap
- rss: Generate RSS feed

### Phase 2: Create GitHub Actions Workflow
🔄 **In Progress**: Create new workflow using mise actions

**New Workflow Structure**:
```yaml
name: Deploy Site

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: ubuntu-26.04
    steps:
      - uses: actions/checkout@v4

      - uses: jdx/mise-action@v4
        with:
          tasks: tasks.yaml

      - name: Deploy
        run: mise run deploy
```

### Phase 3: Documentation
📋 **Pending**: Create usage documentation
- How to use mise tasks locally
- How to use the GitHub Actions workflow
- Migration guide for developers
- Troubleshooting guide

### Phase 4: Cleanup
🗑️ **Pending**: Remove or archive old workflow
- Keep old workflow as backup
- Update documentation to reference new workflow
- Monitor for issues

## Benefits
1. **Consistency**: Same tooling across local and CI
2. **Simplicity**: Reduced workflow complexity
3. **Maintainability**: Easier to update tools and tasks
4. **Reusability**: Tasks can be used in multiple workflows
5. **Documentation**: Tasks serve as inline documentation

## Risks & Mitigations
1. **Breaking Changes**: Keep old workflow as backup
2. **Tool Version Mismatches**: Use exact versions from .mise.toml
3. **Environment Differences**: Test thoroughly before deployment
4. **Cache Issues**: Verify cache behavior with mise

## Success Criteria
- [x] Mise tasks created
- [ ] GitHub Actions workflow created and tested
- [ ] Documentation written
- [ ] Old workflow archived
- [ ] Site deploys successfully
- [ ] No regressions in build output

## Timeline
- Phase 1: ✅ Completed
- Phase 2: 🔄 In Progress
- Phase 3: ⏳ Pending
- Phase 4: ⏳ Pending

## Notes
- Hugo version: 0.136.5 (from .mise.toml)
- All tasks use exact versions specified in .mise.toml
- Cache strategy maintained from original workflow