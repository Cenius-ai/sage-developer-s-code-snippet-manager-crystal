#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

echo "=== Sage — Install ==="

# ── Crystal dependencies + build ──────────────────────────────────
echo "[1/4] Installing Crystal dependencies..."
shards install --production

echo "[2/4] Building application..."
shards build

# ── Download highlight.js (self-hosted) ───────────────────────────
HLJS_VER="11.11.1"
HLJS_DIR="public/vendor/highlight.js"
if [ ! -f "$HLJS_DIR/highlight.min.js" ]; then
  echo "[3/4] Downloading highlight.js v${HLJS_VER}..."
  mkdir -p "$HLJS_DIR"

  curl -sSL "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/${HLJS_VER}/highlight.min.js" \
    -o "$HLJS_DIR/highlight.min.js"

  curl -sSL "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/${HLJS_VER}/styles/default.min.css" \
    -o "$HLJS_DIR/default.min.css"

  echo "  highlight.js installed to $HLJS_DIR"
else
  echo "[3/4] highlight.js already present."
fi

# ── Download fonts (self-hosted TTF from Google Fonts gstatic) ────
FONTS_DIR="public/fonts"
if [ ! -f "$FONTS_DIR/instrument-sans-regular.ttf" ]; then
  echo "[4/4] Downloading font files..."
  mkdir -p "$FONTS_DIR"

  curl -sSL -o "$FONTS_DIR/instrument-sans-regular.ttf" \
    "https://fonts.gstatic.com/s/instrumentsans/v4/pximypc9vsFDm051Uf6KVwgkfoSxQ0GsQv8ToedPibnr-yp2JGEJOH9npSTF-Qf1.ttf"
  curl -sSL -o "$FONTS_DIR/instrument-sans-italic.ttf" \
    "https://fonts.gstatic.com/s/instrumentsans/v4/pxigypc9vsFDm051Uf6KVwgkfoSbSnNPooZAN0lInHGpCWNE27lgU-XJojENuu-2kyk.ttf"
  curl -sSL -o "$FONTS_DIR/source-sans-3-regular.ttf" \
    "https://fonts.gstatic.com/s/sourcesans3/v19/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Ky461EN.ttf"
  curl -sSL -o "$FONTS_DIR/source-sans-3-italic.ttf" \
    "https://fonts.gstatic.com/s/sourcesans3/v19/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqLlO9C4.ttf"

  echo "  Fonts installed to $FONTS_DIR"
else
  echo "[4/4] Fonts already present."
fi

echo ""
echo "=== Install complete ==="
echo "Run the app with: ./bin/sage"
echo "Then open http://localhost:3000"
