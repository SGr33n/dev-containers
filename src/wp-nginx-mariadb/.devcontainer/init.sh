#!/usr/bin/env bash

set -eux

WP_PATH="$1"
echo "\
USER_UID=$(id -u $2)
WP_PATH=$WP_PATH
" > .devcontainer/.env
