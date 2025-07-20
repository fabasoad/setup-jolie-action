#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  tool_name="${1}"
  input_installation_mode="${2}"

  if command -v "${tool_name}" >/dev/null 2>&1; then
    ${tool_name} --version
  elif [ "${input_installation_mode}" = "always" ]; then
    msg="${tool_name} is not found but it had to be installed. Please see the"
    msg="${msg} logs for more details."
    log_warning "${msg}"
  elif [ "${input_installation_mode}" = "idempotent" ]; then
    msg="${tool_name} is not found but it has to be present on the runner. Please"
    msg="${msg} see the logs for more details."
    log_warning "${msg}"
  fi
}

main "$@"
