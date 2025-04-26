#!/usr/bin/env bash
echo "STABLE_GIT_COMMIT $(git rev-parse HEAD)"
echo "STABLE_GIT_COMMIT_SHORT $(git rev-parse --short=6 HEAD)"
echo "STABLE_SEMANTIC_VERSION $(jq -r '.["."]' .release-please-manifest.json)"
echo "STABLE_IMAGE_REGISTRY ghcr.io/alemoreno991"
