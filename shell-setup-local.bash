#! /usr/bin/env bash

# The lazy method. Will fix eventually
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit 1

#shellcheck disable=SC2002
cat shell-setup.bash | sudo bash -s "$USER" --local
