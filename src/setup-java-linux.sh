#!/usr/bin/env sh

main() {
  if [ "${RUNNER_OS}" != "Linux" ]; then
    exit 0
  fi

  java_version="${1}"
  if [ "${RUNNER_OS}" = "Linux" ]; then
    os=$(grep "^ID=" "/etc/os-release" | cut -d '=' -f 2)
    if [ "${os}" = "alpine" ]; then
      apk add wget
      wget -P /etc/apk/keys/ https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub
      echo "https://repos.azul.com/zulu/alpine" | tee -a /etc/apk/repositories
      apk add "zulu${java_version}-jdk"

      java_home="/usr/lib/jvm/zulu${java_version}-ca"
    else
      apt install openjdk-${java_version}-jdk -y
      java_home="/usr/lib/jvm/java-${java_version}-openjdk-amd64"
    fi
    echo "JAVA_HOME=${java_home}" >> "$GITHUB_ENV"
    echo "${java_home}/bin" >> "$GITHUB_PATH"
  fi
}

main "$@"
