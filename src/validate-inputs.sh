#!/usr/bin/env sh

# Validates string to be one of the possible values (emulating enum data type).
# Parameters:
# 1. (Required) Param name to display it correctly in the error message for the
#    users.
# 2. (Required) Param value that will be validated.
# 3. (Required) Possible values for the param value to be valid.
#
# Usage examples:
# check_enum "my-bool-param" "true" "true,false"
# check_enum "my-days-of-week-param" "wed" "mon,tue,wed,thu,fri,sat,sun"
check_enum() {
  case ",${3}," in
    *",${2},"*)
      ;;
    *)
      msg="\"${1}\" parameter is invalid. Possible values: $(echo "${3}" | sed 's/,/, /g')."
      echo "::error title=Invalid parameter::${msg}"
      exit 1
      ;;
  esac
}

# Validates value to be a valid semver string.
# Parameters:
# 1. (Required) Param name to display it correctly in the error message for the
#    users.
# 2. (Required) Param value that will be validated.
#
# Usage examples:
# check_semver "my-valid-semver-1" "1.2.3"
# check_semver "my-valid-semver-3" "latest"
# check_semver "my-invalid-semver" "1.2.3-rc1"
check_semver() {
  if ! echo "${2}" | grep -Eq '^(latest|[0-9]+\.[0-9]+\.[0-9]+)$'; then
    msg="\"${1}\" parameter is invalid. \"${2}\" is not a valid semver."
    echo "::error title=Invalid parameter::${msg}"
    exit 1
  fi
}

main() {
  input_jolie_version="${1}"
  input_jolie_installation_mode="${2}"
  input_jpm_version="${3}"
  input_jpm_installation_mode="${4}"

  check_semver "jolie-version" "${input_jolie_version}"
  check_enum "jolie-installation-mode" "${input_jolie_installation_mode}" "skip,idempotent,always"
  check_semver "jpm-version" "${input_jpm_version}"
  check_enum "jpm-installation-mode" "${input_jpm_installation_mode}" "skip,idempotent,always"
}

main "$@"
