# Stater Template for Bazel projects

## Overview

The current starter template uses the following programs:

- Build system:
    - [Bazel](https://bazel.build/): Build and test software of any size, quickly and reliably.
- Continouos integration (CI):
    - [GitHub Actions](https://github.com/features/actions): automate your CI/CD workflows (e.g. build, test, deploy).
- Development enviroment
    - [devenv](https://devenv.sh/): Declaratively define your development environment by toggling basic options.
    - [pre-commit](https://devenv.sh/git-hooks/): Git hook scripts are useful for identifying simple issues before submission to code review.
    - [clang-format](https://clang.llvm.org/docs/ClangFormat.html): C/C++ formatter.
    - [clang-tidy](https://clang.llvm.org/extra/clang-tidy/): C/C++ linter.
- Documentation:
    - [doxygen](https://www.doxygen.nl/): It automates the generation of documentation from source code comments, parsing information about classes, functions, and variables to produce output in formats like HTML and PDF
- Version Control tools:
    - [Git](https://git-scm.com/): distributed version control system (VCS) that tracks versions of files.
    - [Commitizen](https://commitizen-tools.github.io/commitizen/): enforces a standarized set of rules to write commits ([conventional commits](https://www.conventionalcommits.org/) by default)
    - [Release-please](https://github.com/googleapis/release-please): automates CHANGELOG generation, the creation of GitHub releases, and version bumps for your projects.

## How-to-use

> [!CAUTION]
> You are expected to install `devenv` in order to start working with this repository.

1. Change directory into the repository
1. Enter the development environment `devenv shell`
1. Develop your code and build using Bazel
1. Commit your changes using `cz commit`
> [!IMPORTANT]
> Use `cz commit` instead of `git commit` (this way you'll have some hints to write your commit message).

> [!NOTE]
> Committing will trigger the **pre-commit hooks**:
> - Formatting (i.e. clang-format)

1. Push your changes
> [!NOTE]
> Pushing will trigger the **GitHub Actions**:
> - CI (i.e. building, testing, style conventions, linting, documentation).

1. After pushing your changes to the remote, an automatic pull request (i.e. `release PR`) will show up.
Whenever you decide to merge it an automatic release of your project will be created, a CHANGELOG file
will be generated and the documentation will be published to github pages.

## Setup the development environment

This project uses [devenv](https://devenv.sh/) to declaratively define the development environment.

```shell
# In your host shell: change directory to the location of this project
devenv shell
```

## Additional step (only for NixOS users)

> [!Important]
> When you first start using this project you'll need to create a [Distrobox](https://distrobox.it/)
> container. This is a 1 time event (you don't need to create it every time you enter the project).
>
> ```shell
> ###########################
> # WARNING: only for NixOS
> ###########################
> # In the devenv shell: create a distrobox container to be able to have a
> # Filesystem Hierarchy Standard (FHS) environment, which is assumed by Bazel!
> #
> # Additionally, it was found that the distrobox container was missing the ca-certificates
> # of the host so we mount them with `--volume /etc/ssl/cert:/etc/ssl/certs:ro`
> distrobox --name ubuntubox --volume /etc/ssl/certs:/etc/ssl/certs:ro --image ubuntu:22.04
> ```

Assuming you have already created the distrobox container, you need to enter it as follows:

```shell
# Enter the distrobox container
distrobox enter ubuntubox
```

## Acknowledgments

This is heavily influenced by [ModernCppStarter](https://github.com/TheLartians/ModernCppStarter.git).
