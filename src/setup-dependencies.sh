#!/usr/bin/env sh

_update() {
  for arg in "$@"; do
    if [ "$arg" = "false" ]; then
      if [ "${RUNNER_OS}" = "Linux" ]; then
        if [ -f "/etc/alpine-release" ]; then
          apk update
        else
          apt-get update
        fi
      fi
      break
    fi
  done
}

_setup_dependencies_for_realpath() {
  if [ "${RUNNER_OS}" = "Linux" ]; then
    if [ -f "/etc/alpine-release" ]; then
      apk add coreutils
    else
      apt-get install coreutils -y
    fi
  elif [ "${RUNNER_OS}" = "macOS" ]; then
    brew install coreutils
  fi
}

_setup_curl() {
  if [ "${RUNNER_OS}" = "Linux" ]; then
    if [ -f "/etc/alpine-release" ]; then
      apk add curl
    else
      apt-get install curl -y
    fi
  elif [ "${RUNNER_OS}" = "macOS" ]; then
    brew install curl
  fi
}

main() {
  realpath_installed="${1}"
  curl_installed="${2}"

  _update "$@"

  if [ "${realpath_installed}" = "false" ]; then
    _setup_dependencies_for_realpath
  fi

  if [ "${curl_installed}" = "false" ]; then
    _setup_curl
  fi
}

main "$@"
