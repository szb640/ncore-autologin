{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs;[
    bash
    bats
    git
    shellcheck
  ];

  enterTest = ''
    echo "Running tests"
    shellcheck src/ncore-login.sh
    bats ./test/cases.bats
  '';
}
