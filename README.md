# Setup Jolie action

![Release](https://img.shields.io/github/v/release/fabasoad/setup-jolie-action?include_prereleases)
![Functional Tests](https://github.com/fabasoad/setup-jolie-action/workflows/Functional%20Tests/badge.svg)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/setup-jolie-action/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/setup-jolie-action/main)

This action installs [Jolie](https://www.jolie-lang.org).

## Prerequisites

The following tools have to be installed for successful work of this GitHub action:
[bash](https://www.gnu.org/software/bash), [maven](https://maven.apache.org/)
and [java](https://www.java.com) (for the correct version of java please follow
the instructions [here](https://www.jolie-lang.org/downloads.html)).

## Inputs

| Name    | Required | Description                                                                          | Default   | Possible values |
|---------|----------|--------------------------------------------------------------------------------------|-----------|-----------------|
| version | No       | Version of `Jolie` that can be found [here](https://github.com/jolie/jolie/releases) | `1.10.13` | &lt;String&gt;  |

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
      - uses: actions/checkout@main
      - uses: actions/setup-java@v3
        with:
          java-version: 11
          distribution: zulu
      - uses: fabasoad/setup-jolie-action@main
        with:
          version: 1.10.13
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
      - uses: actions/checkout@main
      - name: Install tools
        run: |
          apk update
          apk add --update bash maven
        shell: sh
      - uses: fabasoad/setup-jolie-action@main
        with:
          version: 1.10.13
      - name: Print version
        run: jolie --version
```

### Result

```shell
Run jolie --version
Jolie 1.10.13  (C) 2006-2021 the Jolie developers
```
