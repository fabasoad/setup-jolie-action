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

_setup_bash() {
  if [ "${RUNNER_OS}" = "Linux" ]; then
    if [ -f "/etc/alpine-release" ]; then
      apk add bash
    else
      apt-get install bash -y
    fi
  elif [ "${RUNNER_OS}" = "macOS" ]; then
    brew install bash
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

_setup_unzip() {
  if [ "${RUNNER_OS}" = "Linux" ]; then
    if [ -f "/etc/alpine-release" ]; then
      apk add unzip
    else
      apt-get install unzip -y
    fi
  elif [ "${RUNNER_OS}" = "macOS" ]; then
    brew install unzip
  fi
}

main() {
  realpath_installed="${1}"
  bash_installed="${2}"
  curl_installed="${3}"
  unzip_installed="${4}"

  _update "$@"

  if [ "${realpath_installed}" = "false" ]; then
    _setup_dependencies_for_realpath
  fi

  if [ "${bash_installed}" = "false" ]; then
    _setup_bash
  fi

  if [ "${curl_installed}" = "false" ]; then
    _setup_curl
  fi

  if [ "${unzip_installed}" = "false" ]; then
    _setup_unzip
  fi
}

main "$@"
