#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  log_info "Java version:"
  java --version
  log_info "Maven version:"
  mvn --version
  log_info "bash version:"
  bash --version
  log_info "curl version:"
  curl --version
  log_info "tar version:"
  tar --version
}

main "$@"
