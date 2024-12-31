#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  input_force="${1}"

  realpath_installed=$(if command -v realpath >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "realpath-installed=${realpath_installed}" >> $GITHUB_OUTPUT

  bash_installed=$(if command -v bash >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "bash-installed=${bash_installed}" >> $GITHUB_OUTPUT

  java_installed=$(if command -v java >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "java-installed=${java_installed}" >> $GITHUB_OUTPUT

  maven_installed=$(if command -v mvn >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "maven-installed=${maven_installed}" >> $GITHUB_OUTPUT

  curl_installed=$(if command -v curl >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "curl-installed=${curl_installed}" >> $GITHUB_OUTPUT

  tar_installed=$(if command -v tar >/dev/null 2>&1; then echo true; else echo false; fi)
  echo "tar-installed=${tar_installed}" >> $GITHUB_OUTPUT

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
  echo "bin-installed=${bin_installed}" >> $GITHUB_OUTPUT

  bin_dir="jolie_$(date +%s)"
  echo "bin-dir=${bin_dir}" >> "$GITHUB_OUTPUT"

  bin_path="$GITHUB_WORKSPACE/${bin_dir}"
  echo "bin-path=${bin_path}" >> "$GITHUB_OUTPUT"
}

main "$@"
