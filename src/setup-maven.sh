#!/usr/bin/env sh

main() {
  maven_version="${1}"

  curl -sSf "https://dlcdn.apache.org/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz" \
    -o "${RUNNER_TEMP}/apache-maven.tar.gz"
  tar -xvf "${RUNNER_TEMP}/apache-maven.tar.gz" -C "${RUNNER_TEMP}"
  rm -f "${RUNNER_TEMP}/apache-maven.tar.gz"
  m2_home="${RUNNER_TEMP}/apache-maven-${maven_version}"
  echo "M2_HOME=${m2_home}" >> "$GITHUB_ENV"
  echo "MAVEN_HOME=${m2_home}" >> "$GITHUB_ENV"
  echo "${m2_home}/bin" >> "$GITHUB_PATH"
}

main "$@"
