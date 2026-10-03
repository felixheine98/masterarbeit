#!/usr/bin/env bash
# Run the literature agents with OpenAI Codex CLI, in parallel, non-interactively.
# Uses the same agent definitions as Claude Code (.claude/agents/*.md, frontmatter stripped).
#
# Usage: scripts/run-codex-lit.sh                    # lit-rq1..4 + lit-related-work in parallel
#        scripts/run-codex-lit.sh lit-rq1 lit-rq3     # only these
#        scripts/run-codex-lit.sh lit-verifier        # verifier (run after the others)
#
# The agents need network access (APIs, PDF downloads) and write access to the repo.
# Check `codex exec --help` for the flags of your Codex version and adjust CODEX_FLAGS;
# e.g. a sandbox mode with network enabled, or full access if you run it in a dedicated container/VM.
set -euo pipefail
cd "$(dirname "$0")/.."

CODEX_FLAGS="${CODEX_FLAGS:---full-auto}"
agents=("$@")
[[ ${#agents[@]} -eq 0 ]] && agents=(lit-rq1 lit-rq2 lit-rq3 lit-rq4 lit-related-work)

mkdir -p logs
for a in "${agents[@]}"; do
  def=".claude/agents/$a.md"
  [[ -f "$def" ]] || { echo "unknown agent: $a" >&2; exit 1; }
  # strip YAML frontmatter, prepend agent name so it uses its own output files
  prompt="Your agent name is $a.
$(awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n>=2' "$def")"
  echo "starting $a -> logs/$a.log"
  # shellcheck disable=SC2086
  codex exec $CODEX_FLAGS "$prompt" > "logs/$a.log" 2>&1 &
done

wait
echo "all agents finished — merging"
scripts/merge-literature.sh
