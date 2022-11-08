# Setup Jolie action

![Release](https://img.shields.io/github/v/release/fabasoad/setup-jolie-action?include_prereleases)
![Functional Tests](https://github.com/fabasoad/setup-jolie-action/workflows/Functional%20Tests/badge.svg)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/fabasoad/setup-jolie-action/main.svg)](https://results.pre-commit.ci/latest/github/fabasoad/setup-jolie-action/main)

This action installs [Jolie](https://www.jolie-lang.org).

## Prerequisites

**One** of the following tools have to be installed for successful work of this
GitHub action:

- [brew](https://brew.sh)
- [curl](https://curl.se), [java](https://www.java.com) (for the correct version
  of java please follow the instructions [here](https://www.jolie-lang.org/downloads.html))

**One** of the following tools have to be installed for successful work of this
GitHub action: [brew](https://brew.sh), [java](https://www.java.com) .

## Inputs

| Name    | Required | Description                                                                          | Default   | Possible values |
|---------|----------|--------------------------------------------------------------------------------------|-----------|-----------------|
| version | No       | Version of `Jolie` that can be found [here](https://github.com/jolie/jolie/releases) | `1.10.13` | &lt;String&gt;  |

## Example usage

### Workflow configuration

```yaml
name: Test

on: push

jobs:
  setup:
    name: graudit
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@main
      - uses: fabasoad/setup-jolie-action@main
        with:
          version: 1.11.0-alpha
      - name: Print version
        run: jolie --version
```

### Result

```shell
Run jolie --version
graudit version: 3.4
```
