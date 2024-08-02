#!/usr/bin/env bash

set -eux

WP_PATH="$1"
echo "\
WP_PATH=$WP_PATH
" > .devcontainer/.env
