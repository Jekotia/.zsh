#! /usr/bin/env bash

function is_wsl() {
	if grep -q "WSL" /proc/sys/kernel/osrelease; then
		verbose "Platform: WSL"
		return 0
	else
		verbose "Platform: Not WSL"
		return 1
	fi
}
function is_linux() {
	if ! is_wsl ; then
		verbose "Platform: Linux"
		return 0
	else
		verbose "Platform: Not Linux"
		return 1
	fi
}
