#!/bin/bash -e

# Check for required arguments
[ $# -ne 2 ] && { echo "Usage: $0 <build_name> <destination_file>" >&2; exit 1; }

# Assign arguments to variables
BUILD_NAME="$1"
DEST_FILE="$2"

# Check if BUILDKITE_TOKEN is set
[ -z "$BUILDKITE_TOKEN" ] && { echo "BUILDKITE_TOKEN not set." >&2; exit 1; }

# API Base URL
API_BASE="https://api.buildkite.com/v2"
ORG="julialang"
PIPELINE="julia-master"

# Fetch the latest successful build for 'master' branch
ARTIFACTS_URL=$(curl -s -H "Authorization: Bearer $BUILDKITE_TOKEN" "$API_BASE/organizations/$ORG/pipelines/$PIPELINE/builds?branch=master" | \
    jq -r "first(.[] | .jobs[] | select(.step_key == \"$BUILD_NAME\" and .exit_status == 0) | .artifacts_url)")

# Exit if no build found
[ -z "$ARTIFACTS_URL" ] && { echo "No successful build found."; exit 1; }

# Fetch the actual artifact download URL
ARTIFACT_URL=$(curl -s -H "Authorization: Bearer $BUILDKITE_TOKEN" "$ARTIFACTS_URL" | \
    jq -r '.[0].download_url')

# Exit if no artifact found
[ -z "$ARTIFACT_URL" ] && { echo "No artifact found."; exit 1; }

# Download the artifact
curl -s -L -H "Authorization: Bearer $BUILDKITE_TOKEN" -o "$DEST_FILE" "$ARTIFACT_URL"

echo "Artifact downloaded as $DEST_FILE"
