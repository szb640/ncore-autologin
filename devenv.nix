{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs;[
    bash
    git
    shellcheck
  ];

  enterTest = ''
    echo "Running tests"
    shellcheck ncore-login.sh
  '';
}
