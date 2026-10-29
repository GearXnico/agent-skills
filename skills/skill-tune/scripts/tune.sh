#!/usr/bin/env sh
# Usage:
#   tune.sh find [skill]               installed copies, version, tuned findings, saved base
#   tune.sh base <installed-dir>       save the untouched copy before its first local change
#   tune.sh merge <installed-dir> <new-dir>   three-way merge into a staging folder, report conflicts
#   tune.sh apply <installed-dir> <new-dir>   replace the copy with the reviewed merge; new-dir becomes the base
# State lives next to the skills folder: <root>/skill-findings.md and <root>/.skill-tune/<skill>/
set -e

state_of() { echo "$(cd "$(dirname "$1")/.." && pwd)/.skill-tune/$(basename "$1")"; }
tuned_line() { grep -m1 '^  tuned:' "$1/SKILL.md" 2>/dev/null || true; }
files_of() { for d in "$@"; do [ -d "$d" ] && (cd "$d" && find . -type f ! -path './evals/*' | sed 's|^\./||'); done | sort -u; }

case $1 in
find)
  for root in .agents/skills .claude/skills "$HOME/.agents/skills" "$HOME/.claude/skills"; do
    for dir in "$root"/${2:-*}/; do
      [ -f "$dir/SKILL.md" ] || continue
      dir=${dir%/}
      version=$(grep -m1 'version:' "$dir/SKILL.md" | tr -d ' "' | cut -d: -f2)
      base=no; [ -d "$(state_of "$dir")/base" ] && base=yes
      echo "$dir | version ${version:-?} | $(tuned_line "$dir" | sed 's/^ *//') | base: $base"
    done
    log="$(dirname "$root")/skill-findings.md"
    [ -f "$log" ] && echo "-- $log: $(grep -c '^## ' "$log") findings, $(grep -cE '^## .*· (open|verified)$' "$log") not shared"
  done
  ;;
base)
  [ -f "$2/SKILL.md" ] || { echo "no skill at $2" >&2; exit 2; }
  state=$(state_of "$2")
  [ -d "$state/base" ] && { echo "base already saved: $state/base"; exit 0; }
  mkdir -p "$state" && cp -R "$2" "$state/base" && rm -rf "$state/base/evals"
  echo "saved base: $state/base"
  ;;
merge)
  [ -f "$2/SKILL.md" ] && [ -f "$3/SKILL.md" ] || { echo "usage: tune.sh merge <installed-dir> <new-dir>" >&2; exit 2; }
  state=$(state_of "$2")
  [ -d "$state/base" ] || { echo "no saved base for $2: compare it with $3 by hand"; exit 3; }
  out=$state/merged; tmp=$state/tmp
  rm -rf "$out" "$tmp"; mkdir -p "$out" "$tmp"
  tuned=$(tuned_line "$2")
  conflicts=0
  for f in $(files_of "$state/base" "$2" "$3"); do
    for side in base ours new; do : > "$tmp/$side"; done
    [ -f "$state/base/$f" ] && cp "$state/base/$f" "$tmp/base"
    [ -f "$2/$f" ] && grep -v '^  tuned:' "$2/$f" > "$tmp/ours" || true
    [ -f "$3/$f" ] && cp "$3/$f" "$tmp/new"
    mkdir -p "$(dirname "$out/$f")"
    n=0; git merge-file -p -L yours -L base -L new "$tmp/ours" "$tmp/base" "$tmp/new" > "$out/$f" || n=$?
    [ "$n" -ge 0 ] || { echo "merge failed on $f" >&2; exit 1; }
    if [ ! -f "$3/$f" ] && [ ! -s "$out/$f" ]; then rm "$out/$f"; echo "deleted  $f"
    elif [ "$n" -gt 0 ]; then conflicts=$((conflicts + n)); echo "CONFLICT $f ($n)"
    elif cmp -s "$out/$f" "$tmp/ours"; then :
    else echo "merged   $f"; fi
  done
  rm -rf "$tmp"
  if [ -n "$tuned" ]; then
    awk -v t="$tuned" '{print} /^metadata:/ && !d {print t; d=1}' "$out/SKILL.md" > "$out/SKILL.md.tmp" && mv "$out/SKILL.md.tmp" "$out/SKILL.md"
  fi
  echo "conflicts: $conflicts"
  echo "review: diff -ru $2 $out"
  ;;
apply)
  [ -f "$2/SKILL.md" ] && [ -f "$3/SKILL.md" ] || { echo "usage: tune.sh apply <installed-dir> <new-dir>" >&2; exit 2; }
  state=$(state_of "$2")
  [ -d "$state/merged" ] || { echo "run merge first" >&2; exit 2; }
  if grep -rlE '^(<<<<<<<|>>>>>>>) ' "$state/merged"; then echo "resolve the conflicts above first" >&2; exit 1; fi
  rm -rf "$2" && cp -R "$state/merged" "$2"
  rm -rf "$state/base" "$state/merged" && cp -R "$3" "$state/base" && rm -rf "$state/base/evals"
  echo "updated $2; new base: $state/base"
  ;;
*)
  sed -n '2,7p' "$0"; exit 2
  ;;
esac
