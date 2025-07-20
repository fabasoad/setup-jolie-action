#!/usr/bin/env sh

_update() {
  if [ "${SETUP_JOLIE_ACTION_UPDATE}" != "true" ]; then
    if [ "${OS}" = "Alpine" ]; then
      apk update
    elif [ "${OS}" = "Linux" ]; then
      apt-get update
    fi
    echo "SETUP_JOLIE_ACTION_UPDATE=true" >> "$GITHUB_ENV"
  fi
}

_setup_realpath() {
  if [ "${OS}" = "Alpine" ]; then
    apk add coreutils
  elif [ "${OS}" = "Linux" ]; then
    apt-get install coreutils -y
  elif [ "${OS}" = "macOS" ]; then
    brew install coreutils
  fi
}

_setup_bash() {
  if [ "${OS}" = "Alpine" ]; then
    apk add bash
  elif [ "${OS}" = "Linux" ]; then
    apt-get install bash -y
  elif [ "${OS}" = "macOS" ]; then
    brew install bash
  fi
}

_setup_curl() {
  if [ "${OS}" = "Alpine" ]; then
    apk add curl
  elif [ "${OS}" = "Linux" ]; then
    apt-get install curl -y
  elif [ "${OS}" = "macOS" ]; then
    brew install curl
  elif [ "${OS}" = "Windows" ]; then
    choco install curl
  fi
}

_setup_unzip() {
  if [ "${OS}" = "Alpine" ]; then
    apk add unzip
  elif [ "${OS}" = "Linux" ]; then
    apt-get install unzip -y
  elif [ "${OS}" = "macOS" ]; then
    brew install unzip
  fi
}

_setup_npm() {
  if [ "${OS}" = "macOS" ]; then
    brew install node
  elif [ "${OS}" = "Windows" ]; then
    choco install nodejs
  else
    _setup_bash
    _setup_curl
    fnm_bin_dir="${RUNNER_TEMP}/fnm_$(date +%s)"
    mkdir -p "${fnm_bin_dir}"
    curl -o- https://fnm.vercel.app/install | bash -s -- --skip-shell --install-dir "${fnm_bin_dir}"
    ${fnm_bin_dir}/fnm install --lts
  fi
}

main() {
  dependency_name="${1}"

  if ! command -v "${dependency_name}" >/dev/null 2>&1; then
    _update
    _setup_${dependency_name}
  fi
}

main "$@"
