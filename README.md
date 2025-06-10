# Setup Jolie action

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![Release](https://img.shields.io/github/v/release/fabasoad/setup-jolie-action?include_prereleases)
![functional-tests](https://github.com/fabasoad/setup-jolie-action/actions/workflows/functional-tests.yml/badge.svg)
![security](https://github.com/fabasoad/setup-jolie-action/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/setup-jolie-action/actions/workflows/linting.yml/badge.svg)

This action installs [Jolie](https://www.jolie-lang.org).

## Supported OS

<!-- prettier-ignore-start -->
| OS      |                    |
|---------|--------------------|
| Windows | :white_check_mark: |
| Linux   | :white_check_mark: |
| macOS   | :white_check_mark: |
<!-- prettier-ignore-end -->

## Prerequisites

None.

## Inputs

```yaml
- uses: fabasoad/setup-jolie-action@v0
  with:
    # (Optional) Jolie version. Defaults to the latest version.
    version: "1.13.1"
    # (Optional) If "false" skips installation if jolie is already installed. If
    # "true" installs jolie in any case. Defaults to "false".
    force: "false"
    # (Optional) GitHub token that is used to send requests to GitHub API such
    # as getting latest release. Defaults to the token provided by GitHub Actions
    # environment.
    github-token: "${{ github.token }}"
```

## Outputs

<!-- prettier-ignore-start -->
| Name      | Description                        | Example |
|-----------|------------------------------------|---------|
| installed | Whether jolie was installed or not | `true`  |
<!-- prettier-ignore-end -->

## Example usage

### Workflow configuration

```yaml
- uses: fabasoad/setup-jolie-action@v0
- run: jolie --version
```

### Result

```shell
Run jolie --version
Jolie 1.13.1  (C) 2006-2025 the Jolie developers
```

## Contributions

![Alt](https://repobeats.axiom.co/api/embed/f26a1f85749c86ba63dbd4d7227a24f091a2e678.svg "Repobeats analytics image")
