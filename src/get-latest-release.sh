#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  repo="${1}"
  token="${2}"

  version=$(curl -sL \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${repo}/releases/latest" \
    | jq -r '.tag_name | sub("^v"; "")')
  log_info "Successfully retrieved ${GITHUB_SERVER_URL}/${repo} latest version: ${version}"
  echo "version=${version}" >> "$GITHUB_OUTPUT"
}

main "$@"
