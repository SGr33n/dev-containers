#!/usr/bin/env bash

set -eux

WP_PATH="$1"
WP_VERSION="$2"
echo "\
VER=0.1.11
USER_UID=1000
WP_PATH=$WP_PATH
WP_VERSION=$WP_VERSION
" > .devcontainer/.env
