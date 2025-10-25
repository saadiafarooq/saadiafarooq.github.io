# Website Documentation

This directory contains all documentation for managing and developing Saadia Farooq's academic website.

## 📚 Documentation Structure

### For Content Editors (Non-Technical)

1. **[Getting Started](./getting-started/)** - Begin here if you're new
   - [Quick Start Guide](./getting-started/quick-start.md) - Open workspace and make your first edit
   - [Editing Content](./content-management/editing-content.md) - Update bio, publications, posts
   - [Adding Content](./content-management/adding-content.md) - Create new posts, publications, projects

### For Developers (Technical)

2. **[Development](./development/)** - For developers working on the site
   - [Development Setup](./development/setup.md) - Install tools and start developing
   - [Build & Test](./development/build-and-test.md) - Building and testing locally
   - [Project Structure](./development/project-structure.md) - Understanding the codebase

3. **[Deployment](./deployment/)** - How the site gets published
   - [GitHub Pages Deployment](./deployment/github-pages.md) - Automatic deployment process
   - [Build Process](./deployment/build-process.md) - What happens during builds

## 🎯 Quick Links

**Just want to edit content?**
→ Start with [Editing Content](./content-management/editing-content.md)

**Setting up for the first time?**
→ Read the [Quick Start Guide](./getting-started/quick-start.md)

**Need to add something new?**
→ Check [Adding Content](./content-management/adding-content.md)

**Want to develop features?**
→ See [Development Setup](./development/setup.md)

## 🔧 Technical Stack

- **Static Site Generator**: Hugo (v0.136.5+)
- **Theme**: Custom based on Hugo Academic template
- **Hosting**: GitHub Pages
- **Deployment**: GitHub Actions (automatic on push to main)
- **Search**: Pagefind
- **Tool Management**: mise

## 📝 Common Tasks

### Edit Your Bio
1. Open `content/authors/saadia/_index.md`
2. Update the YAML front matter (name, bio, interests, etc.)
3. Save and commit changes
4. Site updates automatically within minutes

### Add a Publication
1. Copy an example from `content/publication/`
2. Edit the `_index.md` file with your publication details
3. Add a featured image (optional)
4. Commit and push

### Add a Blog Post
1. Run: `hugo new content/post/my-post-title/_index.md`
2. Edit the created file
3. Add images to the same folder
4. Commit and push

## 🆘 Getting Help

- Check the specific guide for your task in the sections above
- Review [Troubleshooting](./development/troubleshooting.md) for common issues
- See `.github/copilot-instructions.md` for AI-assisted development guidance

## 🌐 External Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Community Forums](https://discourse.gohugo.io)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
