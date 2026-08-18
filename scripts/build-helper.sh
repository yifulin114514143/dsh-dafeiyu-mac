#!/usr/bin/env bash
# Build the macOS BigFish helper as a single-file PyInstaller binary.
#
# Usage:
#   bash scripts/build-helper.sh
#
# Environment:
#   DSH_DAFEIYU_BUILD_PYTHON  Python interpreter to use (default: python3)
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON="${DSH_DAFEIYU_BUILD_PYTHON:-python3}"
ENTRY="$PROJECT_ROOT/runtime/helper.py"
ASSETS="$PROJECT_ROOT/assets"
ARCH="$(uname -m)"
OUTPUT="$PROJECT_ROOT/runtime/bin/darwin-$ARCH"
WORK="$PROJECT_ROOT/.build/helper"

mkdir -p "$OUTPUT" "$WORK"

"$PYTHON" -m PyInstaller \
  --noconfirm \
  --clean \
  --onefile \
  --console \
  --name dsh-dafeiyu-helper \
  --distpath "$OUTPUT" \
  --workpath "$WORK" \
  --specpath "$WORK" \
  --add-data "$ASSETS:assets" \
  --paths "$PROJECT_ROOT/runtime" \
  "$ENTRY"

echo "$OUTPUT/dsh-dafeiyu-helper"
