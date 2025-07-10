#!/usr/bin/env bash
set -euo pipefail

IMAGE="$1"
TARGET="$2"

echo "🔧 Builder Image: $IMAGE"
echo "🏗️  Build Target: $TARGET"

SLEEP_SECONDS=$((RANDOM % 600))
echo "🕒 Sleeping for $SLEEP_SECONDS seconds before starting build..."
sleep "$SLEEP_SECONDS"

docker run --rm --privileged \
  -e BUILDER_UID="$(id -u)" \
  -e BUILDER_GID="$(id -g)" \
  -e TARGET="$TARGET" \
  -v "${GITHUB_WORKSPACE}:/build" \
  -v "/mnt/cache:/cache" \
  -v "/mnt/output:/build/output" \
  "$IMAGE" \
  bash -c '
    echo "🚀 Starting build for TARGET=$TARGET"
    max_retries=3
    count=0
    CPU_CORES=$(nproc)
    JOBS=$((CPU_CORES + 1))
    until make -j${JOBS} "$TARGET"; do
      count=$((count + 1))
      if [ $count -ge $max_retries ]; then
        echo "❌ Build failed after $count attempts."
        exit 1
      fi
      echo "⚠️  Build failed. Retrying in 30s... (Attempt $count/$max_retries)"
      sleep 30
    done
    echo "✅ Build succeeded for $TARGET"
  '
