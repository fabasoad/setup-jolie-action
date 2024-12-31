#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_debug "Java version:"
  java -version
  log_debug "Maven version:"
  mvn --version
  log_debug "bash version:"
  bash --version
  log_debug "curl version:"
  curl --version
  log_debug "tar version:"
  tar --version
  log_debug "jq version:"
  jq --version
}

main "$@"
