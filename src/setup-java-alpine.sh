#!/usr/bin/env sh

main() {
  if [ -f "/etc/alpine-release" ]; then
    apk add --no-cache openjdk21 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
  fi
}

main "$@"
