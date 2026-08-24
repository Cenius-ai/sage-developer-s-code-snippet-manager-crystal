# Sage — Developer's Code Snippet Manager — Crystal pet knowledge base app reference implementation

If you want a self-hosted knowledge base app without the vendor lock-in, **Sage — Developer's Code Snippet Manager** is ready to run. Built with Crystal and Apache-2.0-licensed, Sage — Developer's Code Snippet Manager ships complete — one clone, one install command. Sage is a public pastebin for developers to quickly share code snippets without accounts. [Open Sage — Developer's Code Snippet Manager on cenius.ai](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal) to customise it without touching a line of Sage — Developer's Code Snippet Manager code.


[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE) ![Stack](https://img.shields.io/badge/Stack-Crystal-3b82f6) [![Built with cenius.ai](https://img.shields.io/badge/Built%20with-cenius.ai-8b5cf6)](https://cenius.ai)

[![Open in cenius.ai](https://img.shields.io/badge/▶%20Open%20%26%20edit%20in-cenius.ai-8b5cf6?style=for-the-badge)](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal)

> **▶ [Open & edit in cenius.ai](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal)** — one click to an editable workspace: describe changes in plain English, get an instant preview, one-click deploy and host. Modifications made on the platform come with full rebrand & relicense rights.

_Local clone? See [Quick start](#quick-start) below. cenius.ai is the zero-setup path._

## Demo

![Sage — Developer's Code Snippet Manager — pet knowledge base app](.github/media/poster.png)

![Sage — Developer's Code Snippet Manager demo — pet knowledge base app built with Crystal](.github/media/hero_flagship.gif)

▶ **[See it in action](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal)** — full demo on the project page · [MP4](.github/media/demo.mp4)

## Screenshots

<img src=".github/media/shot-1.png" width="32%" alt="Sage — Developer's Code Snippet Manager knowledge base app screenshot 1"/> <img src=".github/media/shot-2.png" width="32%" alt="Sage — Developer's Code Snippet Manager knowledge base app screenshot 2"/> <img src=".github/media/shot-3.png" width="32%" alt="Sage — Developer's Code Snippet Manager knowledge base app screenshot 3"/>

## Quick start

```bash
./install.sh   # installs dependencies + seeds demo data
```

See [`INSTALL.md`](INSTALL.md) for full setup and usage instructions.

## Usage guide

### Homepage (`/`)

The homepage shows the most recent snippets in a responsive card grid. Each card
displays the title, language badge, a preview of the first three lines, and the
creation date.

A **language filter** at the top lets you search by programming language.

### Create a Snippet (`/new`)

Click **New** in the header (or the **+ New Snippet** button) to open the
creation form. Fill in:

- **Title** — a short description (e.g. "Quick sort in Python")
- **Language** — select from the dropdown (20+ languages supported)
- **Code** — paste your code into the textarea

Click **Save Snippet** to create it. You'll be redirected to the snippet's
detail page.

### View a Snippet (`/snippet/:id`)

Each snippet has its own page showing:

- Title and language badge
- Creation timestamp
- Full code block with syntax highlighting
- **Copy** button to copy the code to clipboard

Click **Back to all snippets** or use the breadcrumb to return to the list.

### Search (`/search?lang=...`)

Use the language filter on the homepage or search page. Select a language
and click **Search**. Only snippets matching that language (case-insensitive)
are shown.

Clear the filter by selecting "All languages" and searching again.

### Theme Toggle

Click the **sun/moon icon** in the header to switch between light and dark
themes. Your preference is saved in `localStorage` and restored on your next
visit.

### Supported Languages

bash, c, crystal, css, dockerfile, elixir, go, html, java, javascript,
json, kotlin, lua, markdown, php, python, ruby, rust, sql, swift,
typescript, yaml, text

_Full guide: [`USAGE.md`](USAGE.md)_

## Features

- Create public snippet
- View a snippet
- List recent snippets
- Search by language
- Light/Dark theme toggle
- Seeded demo data
- Responsive design
- Syntax highlighting

## Architecture

A self-contained Crystal project (254 files): top-level directories include `bin/`, `data/`, `lib/`, `public/`, `src/`, `views/`. `install.sh` takes care of packages and initial data in a single pass; nothing else is required before launching. For environment-specific setup, see [`INSTALL.md`](INSTALL.md).

## FAQ

### How do I run Sage — Developer's Code Snippet Manager on my own server?

Everything you need ships in this repo: clone it, run `./install.sh` to install dependencies and seed demo data, then follow [`INSTALL.md`](INSTALL.md) to start it. No external services required.

### How do I make Sage — Developer's Code Snippet Manager my own brand?

White-labeling is supported: fork the MIT-licensed source and rebrand it yourself, or use [cenius.ai](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal) to make changes in a guided workspace — platform modifications come with full rebrand rights.

### Can I change Sage — Developer's Code Snippet Manager without writing code?

Open it on [cenius.ai](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal) and describe the changes you want in plain English — the platform modifies the app and gives you a new, downloadable build.

### What is Sage — Developer's Code Snippet Manager built with?

Sage — Developer's Code Snippet Manager runs on Crystal. This repo holds the full production source: you can inspect every part of it before deploying. Highlights include view a snippet.

### Is it OK to ship Sage — Developer's Code Snippet Manager as part of a product?

Yes. The code is Apache-2.0-licensed — use it, modify it, and ship it commercially. See [LICENSE](LICENSE).

## License & rebranding

Released under the [Apache License 2.0](LICENSE) (© 2026 Cenius AI) — free for personal and commercial use. The Cenius name/logo are trademarks (see NOTICE).

**Need a customized version?** [Remix this app on cenius.ai](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal) — modifications made on the platform come with **full rebrand & relicense rights** over your derivative.

## Built with cenius.ai

This entire application — code, design, seeded demo data — was generated on **[cenius.ai](https://cenius.ai)** from a plain-English description.

- 🚀 [Build your own app on cenius.ai](https://cenius.ai)
- 🎛️ [Remix Sage — Developer's Code Snippet Manager on the marketplace](https://cenius.ai/marketplace/p/sage-developer-s-code-snippet-manager?ref=gh&utm_campaign=sage-developer-s-code-snippet-manager-crystal) — open it in a workspace, prompt for changes, and ship your own version.

More open-source apps: [the Cenius-ai catalog](https://github.com/Cenius-ai) · [showcase index](https://github.com/Cenius-ai/showcase)
