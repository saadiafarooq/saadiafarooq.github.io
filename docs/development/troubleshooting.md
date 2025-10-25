# Troubleshooting

Common issues and their solutions.

## Build and Development Issues

### Hugo Server Won't Start

**Symptom**: Error when running `Cmd+Shift+B` or `hugo server`

**Solutions**:

1. **Check Hugo is installed**:
   ```bash
   hugo version
   ```
   Should show v0.136.5 or later.

2. **Reinstall tools**:
   ```bash
   mise install
   ```

3. **Kill existing server**:
   ```bash
   pkill hugo
   ```

4. **Clear cache and rebuild**:
   ```bash
   rm -rf public resources .hugo_build.lock
   hugo server
   ```

### Port Already in Use

**Error**: `port 1313 already in use`

**Solution**:
```bash
# Kill existing Hugo process
pkill hugo

# Or use a different port
hugo server --port 1314
```

### Changes Not Appearing in Preview

**Solutions**:

1. **Check file is saved** (`Cmd+S` or `Ctrl+S`)
2. **Check terminal for errors**
3. **Hard refresh browser** (`Cmd+Shift+R` or `Ctrl+Shift+R`)
4. **Restart Hugo server**:
   - Stop server (`Ctrl+C` in terminal)
   - Run `Cmd+Shift+B` again

## Content Issues

### YAML Syntax Errors

**Symptom**: Site won't build, errors about front matter

**Common mistakes**:

```yaml
# ❌ Wrong - tabs instead of spaces
title:	My Title

# ✅ Correct - 2 spaces for indentation
title: My Title

# ❌ Wrong - missing quotes for special characters
title: My Title: A Subtitle

# ✅ Correct - quotes around text with colons
title: 'My Title: A Subtitle'

# ❌ Wrong - incorrect date format
date: 10/14/2024

# ✅ Correct - ISO format
date: 2024-10-14
```

**Solution**: Use a YAML validator or check indentation carefully.

### Images Not Displaying

**Causes and Solutions**:

1. **Wrong file path**:
   - ✅ Use: `![Alt text](image.jpg)` (same folder)
   - ❌ Avoid: `![Alt text](/Users/...absolute/path)`

2. **Case sensitivity**:
   - `Image.jpg` ≠ `image.jpg`
   - Always use lowercase for filenames

3. **File not committed**:
   - Check Source Control to ensure image is committed
   - Push changes to GitHub

### Broken Links

**Check**:
- Link starts with `http://` or `https://` for external links
- Internal links use relative paths: `/about/` not `https://mysite.com/about/`
- File referenced actually exists

## Git and Deployment Issues

### Changes Not Appearing on Live Site

**Steps to resolve**:

1. **Check GitHub Actions**:
   - Go to your repository on GitHub
   - Click "Actions" tab
   - Look for failed builds (red X)
   - Click to see error details

2. **Wait longer**:
   - Deployment takes 2-5 minutes
   - Check again after waiting

3. **Clear browser cache**:
   - Hard refresh: `Cmd+Shift+R` or `Ctrl+Shift+R`
   - Or try incognito/private browsing

4. **Verify changes were pushed**:
   - Check GitHub repository
   - Your commits should appear in history

### Push Rejected or Conflicts

**Symptom**: Can't push changes, gets rejected

**Solution**:

1. **Pull latest changes first**:
   - Click sync button in VS Code
   - Or: Source Control → ... menu → Pull

2. **If conflicts exist**:
   - VS Code shows conflicting files
   - Open files, choose which version to keep
   - Mark as resolved
   - Commit and push

### Accidentally Broke Something

**Solution - Undo last commit**:

1. Source Control panel in VS Code
2. Click ... menu → Commit → Undo Last Commit
3. Fix the issue
4. Commit again

## Module and Dependency Issues

### Module Errors

**Error**: `module not found` or Go module errors

**Solution**:
```bash
hugo mod clean
hugo mod get -u
hugo mod tidy
```

### Theme Not Loading

**Solution**:
```bash
# Update modules
hugo mod get -u

# Or reinstall
rm -rf _vendor
hugo mod get
```

## Mise and Tool Issues

### mise Not Found

**Solution**:
```bash
# Run bootstrap script
bash .vscode/mise.bootstrap.sh

# Or install globally
curl https://mise.run | sh
```

### Tools Not Activating

**Symptom**: `hugo: command not found` after mise install

**Solutions**:

1. **Restart VS Code** - Tools need fresh environment

2. **Check mise**:
   ```bash
   mise doctor
   mise list
   ```

3. **Manually activate**:
   ```bash
   eval "$(mise activate bash)"
   # or for zsh:
   eval "$(mise activate zsh)"
   ```

## VS Code Issues

### Automatic Tasks Not Running

**Symptom**: mise doesn't install on workspace open

**Solution**:

1. Check settings: `.vscode/settings.json`
2. Ensure: `"task.allowAutomaticTasks": "on"`
3. Close and reopen workspace
4. Click "Allow" when prompted

### Extensions Not Working

**Solution**:

1. Press `Cmd+Shift+P` → "Extensions: Show Recommended Extensions"
2. Install all recommended extensions
3. Reload VS Code

## Performance Issues

### Hugo Build is Slow

**Solutions**:

1. **Disable unnecessary output formats**:
   Edit `config/_default/hugo.yaml`

2. **Reduce image processing**:
   - Optimize images before adding
   - Use appropriate sizes

3. **Clear cache**:
   ```bash
   hugo mod clean
   rm -rf resources
   ```

### Large Repository Size

**Cause**: Usually `public/` directory is large

**Solution**:

- `public/` is regenerated automatically
- It's committed for GitHub Pages, but can get large
- Consider .gitignore optimizations if needed

## Getting More Help

Still stuck? Try these resources:

1. **Check Hugo logs**: Look in terminal for detailed error messages
2. **Hugo forums**: https://discourse.gohugo.io
3. **GitHub Issues**: Check if others had similar problems
4. **VS Code Output Panel**: View → Output → Select "Hugo" from dropdown

## Preventive Tips

- Commit changes frequently
- Test locally before pushing
- Keep backup of important files
- Update tools regularly: `mise upgrade`
- Review [Development Setup](./setup.md) for best practices
