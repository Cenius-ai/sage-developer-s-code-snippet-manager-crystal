# Usage

## Homepage (`/`)

The homepage shows the most recent snippets in a responsive card grid. Each card
displays the title, language badge, a preview of the first three lines, and the
creation date.

A **language filter** at the top lets you search by programming language.

## Create a Snippet (`/new`)

Click **New** in the header (or the **+ New Snippet** button) to open the
creation form. Fill in:

- **Title** — a short description (e.g. "Quick sort in Python")
- **Language** — select from the dropdown (20+ languages supported)
- **Code** — paste your code into the textarea

Click **Save Snippet** to create it. You'll be redirected to the snippet's
detail page.

## View a Snippet (`/snippet/:id`)

Each snippet has its own page showing:

- Title and language badge
- Creation timestamp
- Full code block with syntax highlighting
- **Copy** button to copy the code to clipboard

Click **Back to all snippets** or use the breadcrumb to return to the list.

## Search (`/search?lang=...`)

Use the language filter on the homepage or search page. Select a language
and click **Search**. Only snippets matching that language (case-insensitive)
are shown.

Clear the filter by selecting "All languages" and searching again.

## Theme Toggle

Click the **sun/moon icon** in the header to switch between light and dark
themes. Your preference is saved in `localStorage` and restored on your next
visit.

## Supported Languages

bash, c, crystal, css, dockerfile, elixir, go, html, java, javascript,
json, kotlin, lua, markdown, php, python, ruby, rust, sql, swift,
typescript, yaml, text
