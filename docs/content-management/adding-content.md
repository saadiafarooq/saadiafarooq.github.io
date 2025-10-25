# Adding New Content

This guide shows you how to add new content to your website.

## Adding a Blog Post

### Method 1: Using VS Code Task (Recommended)

1. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
2. Type "Tasks: Run Task"
3. Select "Hugo: New Post"
4. Enter your post slug (e.g., `my-research-findings`)
5. A new file is created at `content/post/my-research-findings/_index.md`

### Method 2: Manual Creation

1. Create a new folder: `content/post/my-post-name/`
2. Create `index.md` inside that folder
3. Add this template:

```yaml
---
title: 'Your Post Title'
summary: A brief description for listings
date: 2024-10-14
draft: false
featured: false

authors:
  - saadia

tags:
  - Research
  - Academic

image:
  caption: 'Image credit: Your Name'
  focal_point: ''
  preview_only: false
---

Your post content starts here. Write in Markdown!

## Headings

Use markdown for formatting...
```

### Adding Images to Posts

1. Place images in the same folder as `index.md`
2. Reference them: `![Description](image-name.jpg)`
3. For a featured image, name it `featured.jpg`

## Adding a Publication

### Steps

1. Copy an existing publication folder (e.g., `content/publication/preprint/`)
2. Rename it to your publication slug
3. Edit the `index.md` file:

```yaml
---
title: 'Your Publication Title'
authors:
  - Saadia Farooq
  - Other Author
date: '2024-01-15'
publishDate: '2024-01-15T00:00:00Z'

# Publication type
# article = Journal article
# article-journal = Journal article  
# paper-conference = Conference paper
# chapter = Book chapter
# book = Book
publication_types:
  - article-journal

# Publication name and optional abbreviated version
publication: '*Journal Name*, 15(3):100-120'
publication_short: ''

abstract: |
  Write your abstract here. Can be multiple paragraphs.
  Use the pipe (|) for multi-line text.

# Summary (optional - for listings)
summary: A brief summary for card displays.

tags:
  - Machine Learning
  - Research Topic

# Display this page in Featured widget?
featured: true

# Links (optional)
url_pdf: 'https://example.com/paper.pdf'
url_code: 'https://github.com/username/repo'
url_dataset: 'https://example.com/dataset'
url_poster: ''
url_project: ''
url_slides: ''
url_source: ''
url_video: ''

# Featured image (optional)
image:
  caption: 'Figure caption'
  focal_point: ''
  preview_only: false
---

Additional content can go here (optional).
```

### Adding Publication PDF

1. Place PDF in `static/uploads/` folder
2. Reference it: `url_pdf: 'uploads/your-paper.pdf'`

Or link to external URL:
```yaml
url_pdf: 'https://doi.org/10.1000/journal.123456'
```

## Adding a Project

### Steps

1. Create folder: `content/project/project-name/`
2. Create `index.md`:

```yaml
---
title: Project Name
summary: Brief project description
tags:
  - Machine Learning
  - Computer Vision
date: '2024-01-01'

# Optional external URL for project (replaces project detail page)
external_link: ''

# Featured image
image:
  caption: Project screenshot
  focal_point: Smart

# Links (optional)
url_code: 'https://github.com/username/repo'
url_pdf: ''
url_slides: ''
url_video: ''

# Slides (optional - uses Hugo Blox slides format)
slides: ''
---

Detailed project description goes here.

## Overview

Describe your project...

## Features

- Feature 1
- Feature 2
```

### Project with External Link

If your project lives elsewhere (GitHub, personal site), just add the external link:

```yaml
external_link: 'https://github.com/username/awesome-project'
```

Visitors will be redirected there instead of seeing a detail page.

## Adding a Talk/Presentation

### Steps

1. Create folder: `content/event/event-name/`
2. Create `index.md`:

```yaml
---
title: Talk Title
event: Conference Name
event_url: https://conference.com

location: City, Country
address:
  street: 123 Conference St
  city: City Name
  region: State
  postcode: '12345'
  country: Country

summary: Brief talk description
abstract: |
  Full abstract or talk description here.

# Talk date
date: '2024-06-01T13:00:00Z'
date_end: '2024-06-01T15:00:00Z'
all_day: false

authors:
  - saadia

tags:
  - Research
  - Conference

# Is this a featured talk?
featured: false

image:
  caption: 'Talk photo'
  focal_point: Right

url_code: ''
url_pdf: ''
url_slides: ''
url_video: ''
---

Additional content about the talk...
```

## Adding a New Author

If you're adding a co-author or collaborator:

1. Create folder: `content/authors/author-name/`
2. Create `_index.md`:

```yaml
---
title: Author Full Name
role: Their Position
avatar_filename: avatar.jpg

organizations:
  - name: Their Institution
    url: 'https://institution.edu/'

social:
  - icon: envelope
    icon_pack: fas
    link: 'mailto:email@example.com'
  - icon: linkedin
    icon_pack: fab
    link: https://linkedin.com/in/profile

superuser: false
---

Brief bio of the author...
```

3. Add their avatar image as `avatar.jpg` in the same folder

## Adding Custom Pages

### Create a Simple Page

1. Create file: `content/my-page.md`
2. Add content:

```yaml
---
title: Page Title
date: 2024-10-14
---

Your page content in Markdown.
```

3. Access at: `https://yoursite.com/my-page/`

### Add to Navigation Menu

Edit `config/_default/menus.yaml`:

```yaml
main:
  - name: My Page
    url: my-page
    weight: 50
```

## Tips for Adding Content

### File Naming

- Use lowercase
- Use hyphens instead of spaces: `my-post-name`
- Keep names descriptive but concise

### Folder Structure

```
content/
├── post/
│   └── my-post/
│       ├── index.md
│       ├── featured.jpg
│       └── other-images.jpg
├── publication/
│   └── my-paper/
│       ├── index.md
│       ├── featured.jpg
│       └── cite.bib
└── project/
    └── my-project/
        ├── index.md
        └── featured.jpg
```

### Date Formatting

Always use ISO format: `YYYY-MM-DD`

Examples:
- `2024-10-14` ✅
- `10/14/2024` ❌
- `Oct 14, 2024` ❌

### Tags and Categories

- Use consistent tag names across content
- Start with capital letters
- Keep tags broad enough to group content
- Don't create too many unique tags

Good tags:
- Machine Learning
- Data Science
- Research Methods

### Featured Content

Set `featured: true` to show content in Featured sections on homepage:

```yaml
featured: true
```

## Publishing New Content

1. Save all your files
2. Preview locally at `http://localhost:1313`
3. Open Source Control in VS Code
4. Review changes
5. Write commit message (e.g., "Add new publication on AI research")
6. Commit and push
7. Site updates automatically in 2-5 minutes

## Next Steps

- [Editing Content](./editing-content.md) - Modify existing content
- [Project Structure](../development/project-structure.md) - Understanding the codebase
