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
    pkgs.git
    pkgs.bazel_7
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
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
  # pre-commit.hooks.shellcheck.enable = true;
  pre-commit.hooks.formatting = {
    enable = true;
    # The name of the hook (appears on the report table):
    name = "Formatting";
    # The command to execute (mandatory):
    entry = "bazel run //:format";
    # The pattern of files to run on (default: "" (all))
    # see also https://pre-commit.com/#hooks-files
    files = "";
    # List of file types to run on (default: [ "file" ] (all files))
    # see also https://pre-commit.com/#filtering-files-with-types
    # You probably only need to specify one of `files` or `types`:
    types = ["c" "cpp"];
    # Exclude files that were matched by these patterns (default: [ ] (none)):
    excludes = ["irrelevant\\.c"];
    # The language of the hook - tells pre-commit
    # how to install the hook (default: "system")
    # see also https://pre-commit.com/#supported-languages
    language = "system";
    # Set this to false to not pass the changed files
    # to the command (default: true):
    pass_filenames = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
