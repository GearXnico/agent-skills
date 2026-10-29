#!/usr/bin/env sh
# Usage: find-usages.sh <base-ref> [term...] (run from the repository root)
# Prints file:line:text for every place OUTSIDE the diff that mentions a term,
# so the reviewer can check callers the change may break. Names of files the
# change deletes or renames are added as terms automatically.
[ "$#" -ge 1 ] || { echo "usage: find-usages.sh <base-ref> [term...]" >&2; exit 2; }
base=$1; shift
changed=$(git diff --name-only "$base...HEAD") || exit 2
removed=$(git diff --name-status -M "$base...HEAD" | awk '$1 ~ /^(D|R)/ { print $2 }')
for path in $removed; do set -- "$@" "$(basename "$path")"; done
[ "$#" -gt 0 ] || { echo "no terms given and no files deleted or renamed" >&2; exit 0; }
outside=$(git ls-files | grep -vxF -e "$changed" -e '')
for term in "$@"; do
  echo "== $term"
  printf '%s\n' "$outside" | while IFS= read -r file; do
    [ -f "$file" ] && grep -nF -- "$term" "$file" | sed "s|^|$file:|"
  done
done
exit 0
