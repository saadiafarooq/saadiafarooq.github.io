# Quick Start Guide

Welcome! This guide will help you start editing your academic website in just a few minutes.

## What You Need

- A computer with internet access
- VS Code installed ([Download here](https://code.visualstudio.com/))
- This repository opened in VS Code

## Step 1: Open the Workspace

1. Open VS Code
2. Go to **File → Open Folder**
3. Select the `saadiafarooq.github.io` folder
4. When prompted about "tasks that run automatically", click **Allow**

**What just happened?**
The workspace automatically installed all necessary tools (Hugo, Python, etc.) in the background. You're now ready to edit!

## Step 2: Preview Your Site Locally

1. Press `Cmd+Shift+B` (Mac) or `Ctrl+Shift+B` (Windows/Linux)
2. Wait a few seconds for the server to start
3. Open your browser to `http://localhost:1313`

You'll see your website running on your computer! Any changes you make will appear here automatically.

## Step 3: Make Your First Edit

Let's update your bio:

1. In VS Code, navigate to `content/authors/saadia/_index.md`
2. Find the `title:` line and edit your name if needed
3. Update the `role:` field with your current position
4. Save the file (`Cmd+S` or `Ctrl+S`)
5. Check your browser - the changes appear automatically!

## Step 4: Publish Your Changes

Once you're happy with your edits:

1. Click the **Source Control** icon on the left sidebar (looks like branches)
2. Type a message describing your changes (e.g., "Updated my bio")
3. Click the **checkmark** to commit
4. Click the **sync** button (or "Push" if it appears)

**What happens next?**
GitHub automatically builds and publishes your site. Visit `https://saadiafarooq.github.io` in 2-5 minutes to see your changes live!

## Common Tasks

### Update Your Photo

1. Add your photo to `content/authors/saadia/`
2. Name it `avatar.jpg` or `avatar.png`
3. Save, commit, and push

### Add Social Media Links

1. Open `content/authors/saadia/_index.md`
2. Find the `profiles:` section
3. Edit the URLs for your social media accounts
4. Save, commit, and push

### Change Colors or Theme

1. Open `config/_default/params.yaml`
2. Find `appearance:` section
3. Change `color:` (options: emerald, blue, teal, etc.)
4. Change `mode:` (light, dark, or system)
5. Save and check the preview

## Need More Help?

- **Editing existing content**: See [Editing Content](../content-management/editing-content.md)
- **Adding new content**: See [Adding Content](../content-management/adding-content.md)
- **Something not working?**: See [Troubleshooting](../development/troubleshooting.md)

## Tips

- 💡 Always preview changes locally before publishing
- 💡 Commit your changes frequently with clear messages
- 💡 The preview server updates automatically when you save files
- 💡 If something breaks, you can always undo commits in VS Code
