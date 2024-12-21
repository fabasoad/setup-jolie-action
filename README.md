# Setup Jolie action

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![Release](https://img.shields.io/github/v/release/fabasoad/setup-jolie-action?include_prereleases)
![functional-tests](https://github.com/fabasoad/setup-jolie-action/actions/workflows/functional-tests.yml/badge.svg)
![security](https://github.com/fabasoad/setup-jolie-action/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/setup-jolie-action/actions/workflows/linting.yml/badge.svg)

This action installs [Jolie](https://www.jolie-lang.org).

## Prerequisites

The following tools have to be installed for successful work of this GitHub action:
[bash](https://www.gnu.org/software/bash), [maven](https://maven.apache.org/)
and [java](https://www.java.com) (for the correct version of java please follow
the instructions [here](https://www.jolie-lang.org/downloads.html)).

## Inputs

<!-- prettier-ignore-start -->
| Name    | Required | Description                                                                          | Default  | Possible values |
|---------|----------|--------------------------------------------------------------------------------------|----------|-----------------|
| version | No       | Version of `Jolie` that can be found [here](https://github.com/jolie/jolie/releases) | `1.12.2` | &lt;String&gt;  |
<!-- prettier-ignore-end -->

## Example usage

### Workflow configuration

Based on the [Prerequisites](#prerequisites) section we need to be sure that
all necessary tools have been installed prior of running this action.

For this we need to set up java in advance in case we use clean environment
such as `ubuntu-latest`:

```yaml
name: Run on Ubuntu

on: push

jobs:
  setup:
    name: jolie
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: 11
          distribution: zulu
      - uses: fabasoad/setup-jolie-action@v0
        with:
          version: "1.12.1"
      - name: Print version
        run: jolie --version
```

Or we can use ready to go container with the pre-installed java there:

```yaml
name: Run on Alpine

on: push

jobs:
  setup:
    name: jolie
    runs-on: ubuntu-latest
    container:
      image: adoptopenjdk/openjdk11:alpine-nightly-slim
    steps:
      - uses: actions/checkout@v4
      - name: Install tools
        run: apk add --update maven
      - uses: fabasoad/setup-jolie-action@v0
        with:
          version: "1.12.1"
      - name: Print version
        run: jolie --version
```

### Result

```shell
Run jolie --version
Jolie 1.12.1  (C) 2006-2022 the Jolie developers
```
