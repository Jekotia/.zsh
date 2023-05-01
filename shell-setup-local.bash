#! /usr/bin/env bash

# The lazy method. Will fix eventually
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cat shell-setup.sh | sudo bash -s $USER --local