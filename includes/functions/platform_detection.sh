#! /bin/bash
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
