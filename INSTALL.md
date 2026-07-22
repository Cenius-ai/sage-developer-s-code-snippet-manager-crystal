# Installation

## Prerequisites

- **Crystal** >= 1.10 with `shards`
- **libsqlite3-dev** (SQLite development headers)
- **curl** (for downloading self-hosted assets)

## Steps

### 1. Clone and install

```bash
bash install.sh
```

This runs four stages:

1. **Dependencies** — `shards install --production`
2. **Build** — `shards build` → produces `bin/sage`
3. **highlight.js** — downloads the library files to `public/vendor/highlight.js/`
4. **Fonts** — downloads Instrument Sans + Source Sans 3 TTF files to `public/fonts/`

All stages are idempotent — safe to re-run.

### 2. Run

```bash
./bin/sage
```

The server binds **0.0.0.0:3000**. Set the `PORT` environment variable to change
the port:

```bash
PORT=8080 ./bin/sage
```

### 3. Verify

Open **http://localhost:3000** — you should see a page with 12 seeded demo
snippets.

## Manual build

If you prefer to build manually:

```bash
shards install --production
shards build
```

Then download highlight.js and fonts as described in `install.sh`.

## Configuration

No `.env` file is required. The app uses these defaults:

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT`   | `3000`  | HTTP port to bind |

## Database

The SQLite database is created at `data/sage.db` on first boot. The schema
(`snippets` table) is auto-created and demo data is seeded automatically
when the database is empty.
