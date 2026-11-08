#!/usr/bin/env bash
# After changing the app in the folder tools/apply.sh made (each change a commit there), writes
# SeerrMobile's patches again from those commits.
#
#   tools/save.sh [folder]     folder: default app
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
DIR=${1:-app}
cd "$DIR"
# The original's release the patches go on
BASE=$(git describe --tags --abbrev=0 --match 'v*' HEAD)
rm -f "$ROOT"/patches/*.patch
git format-patch --zero-commit --no-signature -N -q -o "$ROOT/patches" "$BASE"..HEAD
echo "Patches on $BASE:"
ls "$ROOT/patches"
