#! /usr/bin/env bash

declare -a ssh_keyfiles=(
	"${HOME}/.ssh/id_rsa"
	"${HOME}/.ssh/id_jameli"
	"${HOME}/.ssh/id_git"
	"${HOME}/.ssh/id_hyperion_github"
)

ssh_host="atlas"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="ganymede"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="hyperion"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="jupiter"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="mars"		; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="mercury"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }
ssh_host="saturn"	; hostname | grep -q "$ssh_host" && { ssh_keyfiles+=("${HOME}/.ssh/id_$ssh_host"); }

[[ "$USERNAME" == "pi" ]] &&  { ssh_keyfiles+=("id_interpi"); }

#>> ssh-agent setup
#-> https://stackoverflow.com/a/18915067
SSH_ENV="$HOME/.ssh/environment"
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	# shellcheck disable=SC1090
	source "${SSH_ENV}" > /dev/null
	# shellcheck disable=SC2009 # pgrep doesn't seem to be able to satisfy my needs here, which is verifying if ssh-agent is already running by checking the saved PID and then verifying that PID is for an ssh-agent process
	#ps ${SSH_AGENT_PID} doesn't work under cywgin
	ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
		start_ssh_agent "${SSH_ENV}"
	}
else
	start_ssh_agent "${SSH_ENV}"
fi

#>> Add keyfiles to ssh-agent
for keyfile in "${ssh_keyfiles[@]}" ; do
	if [ -f "${keyfile}" ] ; then
		echo "s" ssh-add -l | grep "${keyfile}"
		# https://unix.stackexchange.com/a/132812
		if ! ssh-add -l | grep -q "$(ssh-keygen -lf "${keyfile}"  | awk '{print $2}')" ; then
			ssh-add "${keyfile}"
		fi
	fi
done