#!/usr/bin/env bash

set -eux

WP_PATH="$1"
echo "\
USER_UID=1000
WP_PATH=$WP_PATH
" > .devcontainer/.env
