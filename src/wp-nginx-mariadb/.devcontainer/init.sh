#!/usr/bin/env bash

set -eux

WP_VERSION="WordPress Version > "

WP_PATH="$1"
WP_VERSION="$2"
echo "\
VER=0.1.9
USER_UID=1000
WP_PATH=$WP_PATH
WP_VERSION=$WP_VERSION
" > .devcontainer/.env
