#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  input_jpm_installation_mode="${1}"

  if command -v jpm >/dev/null 2>&1; then
    jpm --version
  elif [ "${input_jpm_installation_mode}" = "always" ]; then
    msg="jpm is not found but it had to be installed. Please see the logs for"
    msg="${msg} more details."
    log_warning "${msg}"
  elif [ "${input_jpm_installation_mode}" = "idempotent" ]; then
    msg="jpm is not found but it has to be present on the runner. Please see"
    msg="${msg} the logs for more details."
    log_warning "${msg}"
  fi
}

main "$@"
