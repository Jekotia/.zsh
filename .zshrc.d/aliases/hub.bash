#! /usr/bin/env bash

if hub --version > /dev/null 2>&1 ; then
	eval "$(hub alias -s)"
fi