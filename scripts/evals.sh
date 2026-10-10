#!/usr/bin/env bash
# evals.sh - review aid for /arly routing
#
# Usage: scripts/evals.sh [-h]
#
# Lists each trigger query in evals/eval_queries.json with the file ENTRY.md
# or OPINIONS.md should send it to, and fails if an expected file is missing
# or is not reachable from the router. It does not call a model: read the
# listing and check that the router text still sends each query there.
#
# Options:
#   -h    Show this help and exit.
#
# Exit codes:
#   0  every expected file exists and is routed
#   1  a broken or unrouted expectation
#   2  bad usage

usage() { sed -n '2,/^[^#]/p' "$0" | sed '1{/^#$/d;}; $d; s/^# \{0,1\}//'; exit "${1:-0}"; }
while getopts ":h" opt; do case "$opt" in h) usage 0 ;; *) usage 2 ;; esac; done

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root" || exit 2

python3 -I - "$root" <<'PY'
import json, os, sys
root = sys.argv[1]
qs = json.load(open(f"{root}/evals/eval_queries.json", encoding="utf-8"))
router = open(f"{root}/ENTRY.md", encoding="utf-8").read() + open(f"{root}/OPINIONS.md", encoding="utf-8").read()
bad = 0
for q in qs:
    if not q["should_trigger"]:
        continue
    e = q.get("expect", "")
    ok = os.path.isfile(f"{root}/{e}") and (e in ("TOOLS.md",) or f"`{e}`" in router)
    bad += not ok
    print(f"{'ok  ' if ok else 'FAIL'} {e:58} <- {q['query'][:70]}")
sys.exit(1 if bad else 0)
PY
