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
    pkgs.bazelisk

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

  enterShell = ''
    # WARNING: This is not as naive as it looks!
    # At least in NixOS this is needed because once inside distrobox there are
    # some issues with certificates. By doing this here, we download the
    # Aspect CLI and the Bazel version needed by the project even before
    # enterning distrobox, hence, avoiding the problem.
    bazelisk version
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
      stages = ["commit-msg"];
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
