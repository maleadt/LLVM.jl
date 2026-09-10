#!/bin/bash -e

# handle user inputs
[ $# -ne 3 ] && { echo "Usage: $0 <version> <build_name> <destination_file>" >&2; exit 1; }
VERSION="$1"
BUILD_NAME="$2"
DEST_FILE="$3"
[ -z "$BUILDKITE_TOKEN" ] && { echo "BUILDKITE_TOKEN not set." >&2; exit 1; }

API_BASE="https://api.buildkite.com/v2"
ORG="julialang"

# derive the branch and legacy pipeline from the version
if [ "$VERSION" = "master" ]; then
    BRANCH="master"
    LEGACY_PIPELINE="julia-master"
else
    BRANCH="release-$VERSION"
    LEGACY_PIPELINE="julia-release-${VERSION//./-dot-}"
fi

# find the first successful job and get its artifacts url
find_artifacts() {
    local pipeline="$1"
    curl -s -H "Authorization: Bearer $BUILDKITE_TOKEN" \
        "$API_BASE/organizations/$ORG/pipelines/$pipeline/builds?branch=$BRANCH&per_page=100" | \
        jq -r "first(.[] | .jobs[] | select(.step_key == \"$BUILD_NAME\" and .exit_status == 0) | .artifacts_url)"
}

# All Julia branches are built by the single `julia-ci` pipeline since July 2026.
# Older release branches only ever built on their per-branch pipeline, which is
# archived but still serves its artifacts, so fall back to that.
ARTIFACTS_URL=$(find_artifacts julia-ci)
if [ -z "$ARTIFACTS_URL" ] || [ "$ARTIFACTS_URL" = "null" ]; then
    echo "No build found on julia-ci; trying legacy pipeline $LEGACY_PIPELINE"
    ARTIFACTS_URL=$(find_artifacts "$LEGACY_PIPELINE")
fi
[ -z "$ARTIFACTS_URL" ] || [ "$ARTIFACTS_URL" = "null" ] && { echo "No successful build found."; exit 1; }

# fetch the url of the first artifact
ARTIFACT_URL=$(curl -s -H "Authorization: Bearer $BUILDKITE_TOKEN" "$ARTIFACTS_URL" | \
    jq -r '.[0].download_url')
[ -z "$ARTIFACT_URL" ] || [ "$ARTIFACT_URL" = "null" ] && { echo "No artifact found."; exit 1; }

curl -s -L -H "Authorization: Bearer $BUILDKITE_TOKEN" -o "$DEST_FILE" "$ARTIFACT_URL"
echo "Artifact downloaded as $DEST_FILE"
