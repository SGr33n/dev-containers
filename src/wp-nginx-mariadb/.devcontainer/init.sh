#!/usr/bin/env bash

set -eux

WP_PATH="$1"
$TEST=1000
echo "\
USER_UID=$TEST
WP_PATH=$WP_PATH
" > .devcontainer/.env
