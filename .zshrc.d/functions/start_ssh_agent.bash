#! /usr/bin/env bash

function start_ssh_agent {
	env_file=${1:-$HOME/.ssh/environment}

	echo "Initialising new SSH agent..."
	ssh-agent | sed 's/^echo/#echo/' > "${env_file}"
	echo succeeded
	chmod 600 "${env_file}"
	# shellcheck disable=SC1090
	source "${env_file}" > /dev/null
	#/usr/bin/ssh-add;
}
