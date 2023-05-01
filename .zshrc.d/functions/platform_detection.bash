#! /usr/bin/env bash

if [[ "$(< /proc/sys/kernel/osrelease)" == *Microsoft ]]; then
	readonly platform="wsl"
elif uname | grep "CYGWIN" > /dev/null 2>&1 ; then
	readonly platform="cygwin"
else
	readonly platform="linux"
fi

verbose "Platform: $platform"

function is_wsl() {
	if [[ "${platform}" == "wsl" ]]; then
		return 0
	else
		return 1
	fi
}
function is_cygwin() {
	if [[ "${platform}" == "cygwin" ]]; then
		return 0
	else
		return 1
	fi
}
function is_linux() {
	if [[ "${platform}" == "linux" ]]; then
		return 0
	else
		return 1
	fi
}
