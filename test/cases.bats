#!/usr/bin/env bats

@test "Missing username errors" {
    unset NCORE_USERNAME
    unset NCORE_PASSWORD
    run ./src/ncore-login.sh
    [ "$status" -eq 1 ]
}

@test "Missing password errors" {
    unset NCORE_USERNAME
    unset NCORE_PASSWORD
    run ./src/ncore-login.sh --username "foo"
    [ "$status" -eq 1 ]
}

@test "Wrong URL by arguments errors" {
    unset NCORE_USERNAME
    unset NCORE_PASSWORD
    run ./src/ncore-login.sh --username "foo" --password "bar" --location "https://example.com"
    [ "$status" -eq 2 ]
}

@test "Wrong URL by environment variables errors" {
    export NCORE_USERNAME="foo"
    export NCORE_PASSWORD="bar"
    export NCORE_LOCATION="https://example.com"
    run ./src/ncore-login.sh
    [ "$status" -eq 2 ]
}
