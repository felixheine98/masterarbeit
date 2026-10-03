#!/usr/bin/env bash
# Print the text of one or more pages of a PDF, with page markers.
# Usage: scripts/pdf-page.sh <file.pdf> <page>            # single page (PDF page index, 1-based)
#        scripts/pdf-page.sh <file.pdf> <first> <last>    # page range
#        scripts/pdf-page.sh <file.pdf> --info            # page count + metadata
# Requires poppler-utils (pdftotext, pdfinfo).
set -euo pipefail

pdf="${1:?usage: pdf-page.sh <file.pdf> <page> [last] | --info}"
[[ -f "$pdf" ]] || { echo "not found: $pdf" >&2; exit 1; }

if [[ "${2:-}" == "--info" ]]; then
  pdfinfo "$pdf"
  exit 0
fi

first="${2:?page number missing}"
last="${3:-$first}"

for ((p = first; p <= last; p++)); do
  echo "===== PDF page $p ====="
  pdftotext -layout -f "$p" -l "$p" "$pdf" - 2>/dev/null
done
