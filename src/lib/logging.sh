#!/usr/bin/env sh

# Printing log to the console.
# Parameters:
# 1. (Required) Log level. Options: debug, info, warning, error.
# 2. (Required) Message.
log() {
  header="setup-jolie-action"
  printf "[%s] [%s] %s %s\n" "${1}" "${header}" "$(date +'%Y-%m-%d %T')" "${2}" 1>&2
}

log_info() {
  log "info" "${1}"
}

log_warning() {
  log "warning" "${1}"
}
