#!/usr/bin/env sh
# Usage: find-adrs.sh (run from the repository root)
# Prints the decision record folder, each record's file, title and status line,
# and the next number, so the agent reads only what it needs.
dir=""
for d in docs/adr docs/adrs docs/decisions docs/architecture/decisions adr adrs decisions; do
  [ -d "$d" ] && { dir=$d; break; }
done
if [ -z "$dir" ]; then
  dir=$(git ls-files | grep -iE '(^|/)(adr|adrs|decisions)/' | head -1 | xargs -r dirname)
fi
[ -n "$dir" ] || { echo "no decision records found"; exit 0; }
echo "== folder: $dir"
last=0
for f in "$dir"/*; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  title=$(grep -m1 '^#' "$f" | cut -c1-120)
  status=$(grep -m1 -iE '^(\*\*)?status|^- status|^status:' "$f" | cut -c1-120)
  [ -z "$status" ] && status=$(grep -m1 -iA2 '^## status' "$f" | tail -n +2 | grep -m1 . | cut -c1-120)
  echo "$name | $title | ${status:-no status line}"
  n=$(echo "$name" | grep -oE '^[0-9]+' | sed 's/^0*//')
  [ -n "$n" ] && [ "$n" -gt "$last" ] && last=$n
done
echo "== next number: $((last + 1))"
