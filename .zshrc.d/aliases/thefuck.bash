#! /usr/bin/env bash

if fuck > /dev/null 2>&1 ; then
	#>> Enable `fuck` as an alias for `thefuck`
	eval "$(thefuck --alias)"
fi