#!/usr/bin/env -S just --justfile

project_root := justfile_directory()

[private]
default:
    @just --list

alias b := build
# Builds the application as a Nix package.
build:
    #!/usr/bin/env bash
    nix build {{project_root}}#ncore-login

alias s := shell
# Starts a shell that has the application installed.
shell:
    #!/usr/bin/env bash
    nix develop {{project_root}}#default
