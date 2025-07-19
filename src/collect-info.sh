#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  input_force="${1}"

  os="${RUNNER_OS}"
  if [ "${os}" = "Linux" ]; then
    os_release=$(grep "^ID=" "/etc/os-release" | cut -d '=' -f 2)
    if [ "${os_release}" = "alpine" ]; then
      os="Alpine"
    fi
  fi
  echo "os=${os}" >> "$GITHUB_OUTPUT"

  realpath_installed=$(if command -v realpath >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "realpath-installed=${realpath_installed}" >> "$GITHUB_OUTPUT"

  java_installed="false"
  if command -v java >/dev/null 2>&1; then
    java_version=$(java -version 2>&1 | awk -F'[".]' '/version/ {if ($2 == "1") print $3; else print $2; exit}')
    if [ "${java_version}" -ge 21 ]; then
      java_installed="true"
    fi
  fi
  echo "java-installed=${java_installed}" >> "$GITHUB_OUTPUT"

  curl_installed=$(if command -v curl >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "curl-installed=${curl_installed}" >> "$GITHUB_OUTPUT"

  unzip_installed=$(if command -v unzip >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "unzip-installed=${unzip_installed}" >> "$GITHUB_OUTPUT"

  bin_installed="false"
  if command -v jolie >/dev/null 2>&1; then
    if [ "${input_force}" = "false" ]; then
      msg="Installation skipped."
      bin_installed="true"
    else
      msg="Executing forced installation."
    fi
    log_info "Jolie is found at $(which jolie). ${msg}"
  else
    log_info "Jolie is not found. Executing installation."
  fi
  echo "bin-installed=${bin_installed}" >> "$GITHUB_OUTPUT"

  bin_dir="jolie_$(date +%s)"
  echo "bin-dir=${bin_dir}" >> "$GITHUB_OUTPUT"
}

main "$@"
