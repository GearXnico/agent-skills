#!/usr/bin/env sh
# Copies skills from this repository into the project in the current directory.
# Usage: install.sh [--claude] [--update] [--force] [skill...]
#   --claude  install into .claude/skills/ (default: .agents/skills/)
#   --update  replace skills that are already installed, except copies tuned with skill-tune
#   --force   replace tuned copies too, discarding their local changes
#   skill     names to install (default: all)
set -e
source_dir=$(cd "$(dirname "$0")/skills" && pwd)
target=.agents/skills
update=0
force=0
while [ "$#" -gt 0 ]; do
  case $1 in
    --claude) target=.claude/skills ;;
    --update) update=1 ;;
    --force) update=1; force=1 ;;
    -*) echo "unknown option: $1" >&2; exit 2 ;;
    *) break ;;
  esac
  shift
done
[ "$#" -gt 0 ] || set -- $(ls "$source_dir")
[ "$(pwd)" != "$(dirname "$source_dir")" ] || { echo "run this from your project, not from agent-skills" >&2; exit 2; }
mkdir -p "$target"
for skill in "$@"; do
  if [ ! -f "$source_dir/$skill/SKILL.md" ]; then
    echo "skip $skill: no such skill"
  elif [ -d "$target/$skill" ] && [ "$update" -eq 0 ]; then
    echo "skip $skill: already installed (use --update to replace it)"
  elif [ "$force" -eq 0 ] && grep -q '^  tuned:' "$target/$skill/SKILL.md" 2>/dev/null; then
    echo "skip $skill: tuned locally (update it with skill-tune, or use --force to discard the local changes)"
  else
    rm -rf "${target:?}/$skill" "$(dirname "$target")/.skill-tune/$skill"
    cp -R "$source_dir/$skill" "$target/$skill"
    rm -rf "$target/$skill/evals"
    echo "installed $skill -> $target/$skill"
  fi
done
echo "Next: ask your agent to run the agents-md skill so AGENTS.md has the rules these skills read."
