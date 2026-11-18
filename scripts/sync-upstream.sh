#!/bin/sh
# One-command upstream sync: fetch, verify the purity rule, merge, smoke-test.
#
#   scripts/sync-upstream.sh            # upstream/main
#   UPSTREAM_BRANCH=master scripts/sync-upstream.sh
#
# A merge conflict here means someone edited an upstream-owned file; the
# script refuses to continue past that until the purity check passes.
set -eu

cd "$(git rev-parse --show-toplevel)"
branch=${UPSTREAM_BRANCH:-main}
ref="upstream/$branch"

echo "==> fetching upstream"
git fetch upstream --prune

echo "==> verifying upstream files are untouched"
./scripts/check-upstream-purity.sh "$ref"

before=$(git rev-parse --short HEAD)

echo "==> merging $ref"
if ! git merge --no-ff --no-edit "$ref"; then
  cat >&2 <<'EOF'

Merge stopped.  If a conflict names lisp/local/, init-local.el,
init-preload-local.el, FORK.org or scripts/, resolve it as usual -- those are
ours.  Anything else means the purity rule was broken earlier: abort, run
scripts/check-upstream-purity.sh, and move the offending change into the local
layer first (see FORK.org).
EOF
  exit 1
fi

after=$(git rev-parse --short HEAD)
if [ "$before" = "$after" ]; then
  echo "==> already up to date"
else
  echo "==> merged $before..$after"
fi

echo "==> startup test"
./test-startup.sh

cat <<'EOF'

Next: restart Emacs and try the paths you touched (minibuffer, magit, org
agenda, eglot, TRAMP, agent-shell).  Then commit and push this branch.
EOF