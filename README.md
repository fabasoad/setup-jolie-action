# Setup Jolie action

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![Release](https://img.shields.io/github/v/release/fabasoad/setup-jolie-action?include_prereleases)
![functional-tests](https://github.com/fabasoad/setup-jolie-action/actions/workflows/functional-tests.yml/badge.svg)
![security](https://github.com/fabasoad/setup-jolie-action/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/setup-jolie-action/actions/workflows/linting.yml/badge.svg)

This action installs [Jolie](https://www.jolie-lang.org) and [JPM](https://www.npmjs.com/package/@jolie/jpm).

## Supported OS

<!-- prettier-ignore-start -->
| OS      | Supported          | Execution time |
|---------|--------------------|----------------|
| Windows | :white_check_mark: | 2m 27s         |
| Linux   | :white_check_mark: | 10s            |
| macOS   | :white_check_mark: | 6s             |
<!-- prettier-ignore-end -->

## Prerequisites

None.

## Inputs

```yaml
- uses: fabasoad/setup-jolie-action@v1
  with:
    # (Optional) Jolie version. Defaults to the latest version.
    jolie-version: "latest"
    # (Optional) Dictates the installation process for jolie. There are 3 options:
    # "skip" - does not install jolie; "skip-if-exists" - installs only if jolie
    # is not present on the runner, otherwise skips the installation; "always" -
    # installs jolie even if it is already present on the runner.
    jolie-installation-mode: "skip-if-exists"
    # (Optional) jpm (jolie package manager) version. Defaults to the latest version.
    jpm-version: "latest"
    # (Optional) Dictates the installation process for jpm (jolie package manager).
    # There are 3 options: "skip" - does not install jpm; "skip-if-exists" -
    # installs only if jpm is not present on the runner, otherwise skips the installation;
    # "always" - installs jpm even if it is already present on the runner.
    jpm-installation-mode: "skip-if-exists"
    # (Optional) GitHub token that is used to send requests to GitHub API such
    # as getting latest release. Defaults to the token provided by GitHub Actions
    # environment.
    github-token: "${{ github.token }}"
```

## Outputs

<!-- prettier-ignore-start -->
| Name            | Description                        | Example |
|-----------------|------------------------------------|---------|
| jolie-installed | Whether jolie was installed or not | `true`  |
| jpm-installed   | Whether jpm was installed or not   | `true`  |
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
Jolie 1.13.0-git  (C) 2006-2025 the Jolie developers
```

## Contributions

![Alt](https://repobeats.axiom.co/api/embed/f26a1f85749c86ba63dbd4d7227a24f091a2e678.svg "Repobeats analytics image")
