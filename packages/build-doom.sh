#!/usr/bin/env bash
# Build and package the pinned doomgeneric source for Rinux.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="${1:-$SCRIPT_DIR/doomgeneric-src}"
DOOM_SRC="$SRC_DIR/doomgeneric"
OUT_DIR="$SCRIPT_DIR/pkgs"
ARCHIVE="$OUT_DIR/doom-1.0.0.tar"

if [[ ! -f "$DOOM_SRC/Makefile.fb" ]]; then
    echo "doom source missing Makefile.fb: $DOOM_SRC" >&2
    exit 2
fi
if ! command -v musl-gcc >/dev/null 2>&1; then
    echo "musl-gcc is required to build the static Rinux package" >&2
    exit 2
fi

make -C "$DOOM_SRC" -f Makefile.fb clean
make -C "$DOOM_SRC" -f Makefile.fb
test -x "$DOOM_SRC/doom"

mkdir -p "$OUT_DIR"
rm -f "$ARCHIVE"
tar -C "$DOOM_SRC" -cf "$ARCHIVE" doom

echo "doom package: $ARCHIVE"
sha256sum "$ARCHIVE"
