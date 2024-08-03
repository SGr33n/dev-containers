#!/usr/bin/env bash

set -eux

WP_VERSION="WordPress Version > "

WP_PATH="$1"
echo "\
VER=0.1.7
USER_UID=1000
WP_PATH=$WP_PATH
" > .devcontainer/.env
