#!/usr/bin/env sh

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

_setup_tar() {
  if [ "${RUNNER_OS}" = "Linux" ]; then
    if [ -f "/etc/alpine-release" ]; then
      apk add tar
    else
      apt-get install tar -y
    fi
  elif [ "${RUNNER_OS}" = "macOS" ]; then
    brew install tar
  fi
}

_setup_dependencies_for_maven() {
  curl_installed="${1}"
  tar_installed="${2}"

  if [ "${curl_installed}" = "false" ]; then
    _setup_curl
  fi

  if [ "${tar_installed}" = "false" ]; then
    _setup_tar
  fi
}

main() {
  realpath_installed="${1}"
  bash_installed="${2}"
  maven_installed="${3}"
  curl_installed="${4}"
  tar_installed="${5}"

  if [ "${realpath_installed}" = "false" ]; then
    _setup_dependencies_for_realpath
  fi

  if [ "${bash_installed}" = "false" ]; then
    _setup_bash
  fi

  if [ "${maven_installed}" = "false" ]; then
    _setup_dependencies_for_maven "${curl_installed}" "${tar_installed}"
  fi
}

main "$@"