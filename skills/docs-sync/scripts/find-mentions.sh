#!/usr/bin/env sh
# Usage: find-mentions.sh <term>... (run from the repository root)
# Prints file:line:text for every line of the tracked documentation that
# mentions one of the terms, so the agent reads matching lines, not every doc.
# Extra documentation paths can be added with DOCS_PATHS="dir1 dir2".
[ "$#" -gt 0 ] || { echo "usage: find-mentions.sh <term>..." >&2; exit 2; }
docs=$(git ls-files -- '*.md' '*.mdx' '*.rst' '*.adoc' '*.txt' 'docs/' $DOCS_PATHS | sort -u)
[ -n "$docs" ] || { echo "no documentation files tracked" >&2; exit 1; }
for term in "$@"; do
  echo "== $term"
  printf '%s\n' "$docs" | while IFS= read -r file; do
    grep -nF -- "$term" "$file" | sed "s|^|$file:|"
  done
done
