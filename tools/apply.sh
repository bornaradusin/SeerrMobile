#!/usr/bin/env bash
# Puts SeerrMobile together: the original Seerr mobile app (seerr-team/mobile-app) at one of its
# releases, with SeerrMobile's patches applied on top, ready to build.
#
#   tools/apply.sh [tag] [folder]
#     tag     the original's release, e.g. v0.11.2 (default: its newest)
#     folder  where to put it (default: app)
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
UPSTREAM=https://github.com/seerr-team/mobile-app
TAG=${1:-$(git ls-remote --tags --refs "$UPSTREAM" 'v*' | sed 's|.*refs/tags/||' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1)}
DIR=${2:-app}

echo "The original app at $TAG"
rm -rf "$DIR"
git clone --quiet --branch "$TAG" "$UPSTREAM" "$DIR"
cd "$DIR"
# Seerr's own code, which the app uses (its types, messages and styles)
git submodule update --init --depth 1 seerr

echo "SeerrMobile's patches"
git -c user.name=SeerrMobile -c user.email=seerrmobile@users.noreply.github.com \
  am --3way --keep-cr "$ROOT"/patches/*.patch

echo "Dependencies"
npm ci --no-audit --no-fund
# What the patches use that the original doesn't have: opening the APK in Android's installer
npx expo install expo-intent-launcher
