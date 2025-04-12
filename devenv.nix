{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    # Packages needed by the project
    pkgs.git
    pkgs.bazel_7

    # This packages are only needed as a work around in NixOS.
    pkgs.distrobox

    # Utilities
    pkgs.commitizen
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.distrobox-init.exec = ''
    # In the devenv shell: create a distrobox container to be able to have a
    # Filesystem Hierarchy Standard (FHS) env, which is assumed by Bazel!
    #
    # Additionally, it was found that the distrobox container was missing the
    # ca-certificates of the host so we mount them with:
    #
    #   `--volume /etc/ssl/cert:/etc/ssl/certs:ro`
    #

    # Check if the container exists
    if ! distrobox list | grep -q "ubuntubox"; then
      # The container does not exist. Thus, create it
      echo "Creating distrobox container 'ubuntubox'..."
      distrobox create \
        --volume /etc/ssl/certs:/etc/ssl/certs:ro \
        --name ubuntubox \
        --image ubuntu:22.04
    else
      echo "Distrobox container 'ubuntubox' already exists (I'll use it)"
    fi

    # Enter the distrobox container
    distrobox enter ubuntubox
  '';

  enterShell = ''
    #################
    # Only for NixOS
    #################
    if uname -a | grep -q "NixOS"; then
      distrobox-init
    fi
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    actionlint = {
      enable = true;
      description = "Static checker for GitHub Actions workflow files";
    };

    alejandra = {
      enable = true;
      description = "Nix code formatter";
    };

    check-json = {
      enable = true;
      description = "Check syntax of JSON files";
    };

    check-yaml = {
      enable = true;
      description = "Check syntax of YAML files";
    };

    commitizen = {
      enable = true;
      description = "Check wheater the current commit message follows committing rules";
    };

    detect-private-keys = {
      enable = true;
      description = "Detect the presence of private keys";
    };

    end-of-file-fixer = {
      enable = true;
      description = "Ensures that the file is either empty, or ends with a single newline";
    };

    markdownlint = {
      enable = true;
      description = "Style checker and linter for markdown files";
    };

    mixed-line-endings = {
      enable = true;
      description = "Resolve mixed line endings";
    };

    no-commit-to-branch = {
      enable = true;
      description = "Disallow commiting to `main`";
      settings.branch = ["main"];
    };

    ripsecrets = {
      enable = true;
      description = "Prevent commiting secret keys into your source code";
    };

    shellcheck = {
      enable = true;
      description = "Format shell files";
    };

    trim-trailing-whitespace = {
      enable = true;
      description = "Trim trailing whitespace";
    };

    # Custom hook to perform formatting via Bazel
    formatting = {
      enable = true;
      # The name of the hook (appears on the report table):
      name = "Formatting";
      description = "Formatting the source code with rules_lint (Bazel)";
      # The command to execute (mandatory):
      entry = "bazel run //:format";
      # The pattern of files to run on (default: "" (all))
      # see also https://pre-commit.com/#hooks-files
      files = "";
      # List of file types to run on (default: [ "file" ] (all files))
      # see also https://pre-commit.com/#filtering-files-with-types
      # You probably only need to specify one of `files` or `types`:
      types = ["c" "c++"];
      # Exclude files that were matched by these patterns (default: [ ] (none)):
      excludes = [];
      # The language of the hook - tells pre-commit
      # how to install the hook (default: "system")
      # see also https://pre-commit.com/#supported-languages
      language = "system";
      # Set this to false to not pass the changed files
      # to the command (default: true):
      pass_filenames = true;
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
