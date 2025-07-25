#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  input_jolie_installation_mode="${1}"
  input_jpm_installation_mode="${2}"

  os="${RUNNER_OS}"
  if [ "${os}" = "Linux" ]; then
    os_release=$(grep "^ID=" "/etc/os-release" | cut -d '=' -f 2)
    if [ "${os_release}" = "alpine" ]; then
      os="Alpine"
    fi
  fi
  echo "os=${os}" >> "$GITHUB_OUTPUT"

  java_installed="false"
  if command -v java >/dev/null 2>&1; then
    java_version=$(java -version 2>&1 | awk -F'[".]' '/version/ {if ($2 == "1") print $3; else print $2; exit}')
    if [ "${java_version}" -ge 21 ]; then
      java_installed="true"
    fi
  fi
  echo "java-installed=${java_installed}" >> "$GITHUB_OUTPUT"

  # jolie
  jolie_installed="false"
  if command -v jolie >/dev/null 2>&1; then
    if [ "${input_jolie_installation_mode}" = "always" ]; then
      msg="Executing forced installation."
    else
      msg="Installation skipped."
      jolie_installed="true"
    fi
    log_info "jolie is found at $(which jolie). ${msg}"
  else
    if [ "${input_jolie_installation_mode}" = "skip" ]; then
      msg="Installation skipped anyway."
      jolie_installed="true"
    else
      msg="Executing installation."
    fi
    log_info "jolie is not found. ${msg}"
  fi
  echo "jolie-installed=${jolie_installed}" >> "$GITHUB_OUTPUT"

  jolie_dir="jolie_$(date +%s)"
  echo "jolie-dir=${jolie_dir}" >> "$GITHUB_OUTPUT"

  jolie_path="$GITHUB_WORKSPACE/${jolie_dir}"
  echo "jolie-path=${jolie_path}" >> "$GITHUB_OUTPUT"

  # jpm
  jpm_installed="false"
  if command -v jpm >/dev/null 2>&1; then
    if [ "${input_jpm_installation_mode}" = "always" ]; then
      msg="Executing forced installation."
    else
      msg="Installation skipped."
      jpm_installed="true"
    fi
    log_info "jpm is found at $(which jpm). ${msg}"
  else
    if [ "${input_jpm_installation_mode}" = "skip" ]; then
      msg="Installation skipped anyway."
      jpm_installed="true"
    else
      msg="Executing installation."
    fi
    log_info "jpm is not found. ${msg}"
  fi
  echo "jpm-installed=${jpm_installed}" >> "$GITHUB_OUTPUT"
}

main "$@"
