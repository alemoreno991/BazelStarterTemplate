#!/usr/bin/env bash
# This script will be run by bazel when building process starts to
# generate key-value information that represents the status of the
# workspace. The output should be like
#
# KEY1 VALUE1
# KEY2 VALUE2
#
# If the script exits with non-zero code, it's considered as a failure
# and the output will be discarded.
#
set -eo pipefail # exit immediately if any command fails.

function remove_url_credentials() {
  which perl >/dev/null && perl -pe 's#//.*?:.*?@#//#' || cat
}

repo_url=$(git config --get remote.origin.url | remove_url_credentials)
echo "REPO_URL $repo_url"

commit_sha=$(git rev-parse HEAD)
commit_sha_short=$(git rev-parse --short=6 HEAD)
echo "COMMIT_SHA $commit_sha"

# version_tag=$(jq -r '.["."]' .release-please-manifest.json)

# Note: the "STABLE_" suffix causes these to be part of the "stable" workspace
# status, which may trigger rebuilds of certain targets if these values change
# and you're building with the "--stamp" flag.
echo "STABLE_GIT_COMMIT $commit_sha"
echo "STABLE_GIT_COMMIT_SHORT $commit_sha_short"
# echo "STABLE_SEMANTIC_VERSION $version_tag"
echo "STABLE_IMAGE_REGISTRY ghcr.io/alemoreno991"
