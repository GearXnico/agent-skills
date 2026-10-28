#!/usr/bin/env sh
# Prints the "## Git workflow" section of AGENTS.md or CLAUDE.md, so the agent
# reads a few lines instead of the whole file. Exits 1 if no section is found.
for file in AGENTS.md CLAUDE.md; do
  [ -f "$file" ] || continue
  section=$(awk '/^## Git workflow[[:space:]]*$/ { inside = 1; next }
                 inside && /^#{1,2} / { exit }
                 inside && NF { print }' "$file")
  if [ -n "$section" ]; then
    echo "$section"
    exit 0
  fi
done
echo "No '## Git workflow' section in AGENTS.md or CLAUDE.md" >&2
exit 1
