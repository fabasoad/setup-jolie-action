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
  if command -v realpath >/dev/null 2>&1; then
    if [ "${RUNNER_OS}" = "Linux" ]; then
      if [ -f "/etc/alpine-release" ]; then
        apk add coreutils
      else
        apt-get install coreutils -y
      fi
    elif [ "${RUNNER_OS}" = "macOS" ]; then
      brew install coreutils
    fi
  fi
}

_setup_bash() {
  if command -v bash >/dev/null 2>&1; then
    if [ "${RUNNER_OS}" = "Linux" ]; then
      if [ -f "/etc/alpine-release" ]; then
        apk add bash
      else
        apt-get install bash -y
      fi
    elif [ "${RUNNER_OS}" = "macOS" ]; then
      brew install bash
    fi
  fi
}

_setup_curl() {
  if command -v curl >/dev/null 2>&1; then
    if [ "${RUNNER_OS}" = "Linux" ]; then
      if [ -f "/etc/alpine-release" ]; then
        apk add curl
      else
        apt-get install curl -y
      fi
    elif [ "${RUNNER_OS}" = "macOS" ]; then
      brew install curl
    fi
  fi
}

_setup_unzip() {
  if command -v unzip >/dev/null 2>&1; then
    if [ "${RUNNER_OS}" = "Linux" ]; then
      if [ -f "/etc/alpine-release" ]; then
        apk add unzip
      else
        apt-get install unzip -y
      fi
    elif [ "${RUNNER_OS}" = "macOS" ]; then
      brew install unzip
    fi
  fi
}

main() {
  dependency_name="${1}"

  _update "$@"

  if [ "${dependency_name}" = "realpath" ]; then
    _setup_dependencies_for_realpath
  elif [ "${dependency_name}" = "bash" ]; then
    _setup_bash
  elif [ "${dependency_name}" = "curl" ]; then
    _setup_curl
  elif [ "${dependency_name}" = "unzip" ]; then
    _setup_unzip
  fi
}

main "$@"
