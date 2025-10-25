# Editing Content

This guide shows you how to edit existing content on your website.

## Your Bio and Profile

### Location
`content/authors/saadia/_index.md`

### What You Can Edit

**Basic Information:**
```yaml
title: Your Full Name
role: Your Current Position
organizations:
  - name: Your Institution
    url: https://institution.edu/
```

**About Section:**
At the bottom of the file, edit the text under `## About Me`

**Interests:**
```yaml
interests:
  - Your Research Interest 1
  - Your Research Interest 2
  - Your Research Interest 3
```

**Education:**
```yaml
education:
  - area: PhD in Your Field
    institution: University Name
    date_start: 2022-01-01
    date_end: 2025-12-31
    summary: |
      Brief description of your research or thesis.
```

**Work Experience:**
```yaml
work:
  - position: Job Title
    company_name: Company/Organization
    date_start: 2021-01-01
    date_end: ''  # Leave empty for current position
    summary: |
      - Responsibility 1
      - Responsibility 2
```

**Social Media Links:**
```yaml
profiles:
  - icon: at-symbol
    url: 'mailto:your-email@example.com'
    label: E-mail Me
  - icon: brands/linkedin
    url: https://www.linkedin.com/in/yourprofile/
```

### Tips

- Use `|` for multi-line text (summaries, descriptions)
- Keep date format as `YYYY-MM-DD`
- Leave `date_end: ''` empty for current positions/education
- Save the file to see changes in your local preview

## Blog Posts

### Editing Existing Posts

1. Navigate to `content/post/[post-name]/`
2. Open `index.md`
3. Edit the front matter (title, date, summary, tags)
4. Edit the content below the `---` markers
5. Save the file

### Front Matter Fields

```yaml
---
title: 'Your Post Title'
summary: A brief description that appears in listings
date: 2024-10-14
authors:
  - saadia
tags:
  - Tag 1
  - Tag 2
---
```

## Publications

### Editing a Publication

1. Navigate to `content/publication/[publication-name]/`
2. Open `index.md`
3. Update the front matter:

```yaml
---
title: 'Publication Title'
authors:
  - Saadia Farooq
  - Co-author Name
date: '2024-01-15'
publication: '*Journal Name*, Volume(Issue)'
publication_types:
  - article-journal
abstract: Your abstract text here
featured: true  # Shows on homepage
url_pdf: 'link-to-pdf.pdf'
---
```

## Projects

### Editing a Project

1. Navigate to `content/project/[project-name]/`
2. Open `index.md`
3. Update front matter and content:

```yaml
---
title: Project Name
summary: Brief description
date: '2024-01-01'
tags:
  - Machine Learning
  - Data Science
external_link: ''  # Or link to external project page
---
```

## Homepage Sections

The homepage is controlled by `content/_index.md`.

### Reordering Sections

Each section has a `weight:` number. Lower numbers appear first:

```yaml
sections:
  - block: about
    weight: 10  # Appears first
  - block: experience
    weight: 20  # Appears second
```

### Hiding Sections

Set `design.show: false` to hide a section:

```yaml
sections:
  - block: collection
    design:
      show: false  # This section won't appear
```

## Site Configuration

### Basic Settings

File: `config/_default/hugo.yaml`

```yaml
title: Saadia Farooq  # Site title
baseURL: 'https://saadiafarooq.github.io/'  # Your site URL
```

### Theme and Colors

File: `config/_default/params.yaml`

```yaml
appearance:
  color: emerald  # emerald, blue, teal, cyan, etc.
  mode: system    # light, dark, or system
```

### Navigation Menu

File: `config/_default/menus.yaml`

```yaml
main:
  - name: Home
    url: /
    weight: 10
  - name: Publications
    url: /#papers
    weight: 20
```

Lower `weight` = appears first in menu.

## Images

### Profile Photo

- File: `content/authors/saadia/avatar.jpg`
- Recommended size: 400x400px or larger
- Format: JPG or PNG

### Blog Post Images

- Place images in the same folder as the post's `index.md`
- Reference in markdown: `![Alt text](image.jpg)`
- For featured image, name it `featured.jpg`

### Publication Images

- Place in publication folder
- Name it `featured.jpg` for automatic display

## Markdown Basics

### Headings
```markdown
# Heading 1
## Heading 2
### Heading 3
```

### Text Formatting
```markdown
**bold text**
*italic text*
[link text](https://example.com)
```

### Lists
```markdown
- Bullet point 1
- Bullet point 2

1. Numbered item 1
2. Numbered item 2
```

### Code
````markdown
Inline `code` looks like this.

```python
# Code block
def hello():
    print("Hello world")
```
````

## Previewing Changes

1. Make sure Hugo server is running (`Cmd+Shift+B`)
2. Save your file
3. Check `http://localhost:1313` in your browser
4. Changes appear automatically (may take 1-2 seconds)

## Publishing Changes

Once you're satisfied with your edits:

1. Open Source Control panel in VS Code
2. Review your changes
3. Write a commit message
4. Click checkmark to commit
5. Click sync/push button
6. Site updates automatically in 2-5 minutes

## Common Issues

**Changes not appearing?**
- Make sure you saved the file
- Check the terminal for errors
- Restart Hugo server if needed

**Formatting looks wrong?**
- Check YAML indentation (use spaces, not tabs)
- Ensure YAML front matter is between `---` markers
- Validate YAML syntax

**Images not showing?**
- Verify image file names match exactly
- Check image file is in correct folder
- Use relative paths, not absolute URLs

## Next Steps

- [Adding New Content](./adding-content.md) - Create new posts, publications
- [Development Setup](../development/setup.md) - Advanced editing and features
