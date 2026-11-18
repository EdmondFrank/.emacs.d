#!/bin/sh
# Fail if a file owned by purcell/emacs.d has been modified.
#
# The config's rule (see FORK.org): upstream-owned files stay byte-identical to
# upstream/main, and every fork change lives in lisp/local/ or in one of the
# two init-*-local.el entry points.  Run this before and after an upstream
# merge; scripts/sync-upstream.sh does both.
#
# Usage: scripts/check-upstream-purity.sh [ref]   (default: upstream/main)
set -eu

cd "$(git rev-parse --show-toplevel)"
ref=${1:-upstream/main}

if ! git rev-parse --verify --quiet "$ref" >/dev/null; then
  echo "check-upstream-purity: ref '$ref' not found (git fetch upstream?)" >&2
  exit 2
fi

bad=0
for f in init.el early-init.el $(git ls-tree -r --name-only "$ref" lisp/); do
  if ! git diff --quiet "$ref" -- "$f"; then
    echo "modified upstream file: $f"
    bad=1
  fi
done

if [ "$bad" -ne 0 ]; then
  cat >&2 <<'EOF'

Keep upstream files pristine: move the change into lisp/local/my-<module>.el
and apply it there with setq / advice-add / remove-hook after upstream loads.
See FORK.org for why and how.
EOF
  exit 1
fi

echo "upstream files are pristine (compared to $ref)"