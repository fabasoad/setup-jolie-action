#!/usr/bin/env sh

main() {
  repo="${1}"

  version=$(curl -sL \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${repo}/releases/latest" \
    | jq -r '.tag_name | sub("^v"; "")')
  echo "version=${version}" >> "$GITHUB_OUTPUT"
}

main "$@"
