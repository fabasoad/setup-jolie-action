#!/usr/bin/env sh

main() {
  java_version="${1}"
  apk add wget
  wget -P /etc/apk/keys/ https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub
  echo "https://repos.azul.com/zulu/alpine" | tee -a /etc/apk/repositories
  apk add "zulu${java_version}-jdk"

  java_home="/usr/lib/jvm/zulu${java_version}-ca"
  echo "JAVA_HOME=${java_home}" >> "$GITHUB_ENV"
  echo "${java_home}/bin" >> "$GITHUB_PATH"
}

main "$@"
