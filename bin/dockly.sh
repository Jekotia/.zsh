#! /usr/bin/env bash
function pid_file_exists() {
	if [ -f "${TEMP_TUNNEL_PID}" ] ; then
		#echo "DEBUG: Found existing PID file"
		return 0
	else
		#echo "DEBUG: Did not find existing PID file"
		return 1
	fi
}
function pid_file_remove() {
	if rm -f "${TEMP_TUNNEL_PID}" > /dev/null ; then
		#echo "DEBUG: Successfully removed PID file"
		return 0
	else
		#echo "DEBUG: Failed to remove PID file"
		return 1
	fi
}
function pid_process_running() {
	if ps | grep "$(cat "${TEMP_TUNNEL_PID}")" | grep "ssh" > /dev/null ; then
		#echo "DEBUG: PID file corresponds to an active PID"
		return 0
	else
		#echo "DEBUG: PID file does not correspond to an active PID"
		return 1
	fi
}
function pid_process_kill() {
	if kill $(cat ${TEMP_TUNNEL_PID}) > /dev/null ; then
		#echo "DEBUG: Killed PID"
		return 0
	else
		#echo "DEBUG: Failed to kill PID"
		return 1
	fi
}
function dockly.sh::cleanup() {
	# pid_file_exists
	# 	pid_process_running
	# 		pid_process_kill
	# 			pid_file_remove
	# 			return 1
	# 		return 1
	# 	else
	# 		pid_file_remove
	# 		return 1
	# continue

	#echo "DEBUG: Cleaning up..."
	if pid_file_exists ; then
		if pid_process_running ; then
			if pid_process_kill ; then
				if ! pid_file_remove ; then
					return 1
				fi
			else
				return 1
			fi
		else
			if pid_file_remove ; then
				true
			else
				return 1
			fi
		fi
	fi

	if [ -S "${TEMP_TUNNEL_SOCK}" ] ; then
		#echo "DEBUG: Found existing socket"
		if rm -f "${TEMP_TUNNEL_SOCK}" ; then
			true
			#echo "DEBUG: Successfully removed socket"
		else
			#echo "DEBUG: Successfully removed socket"
			return 1
		fi
	else
		false
		#echo "DEBUG: Did not find existing socket"
	fi

	return 0
}

function dockly.sh::main() {
	readonly REMOTE_TARGET="$*"
	#echo "DEBUG: REMOTE_TARGET: ${REMOTE_TARGET}"

	if ! echo "${REMOTE_TARGET}" | grep -P '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$' > /dev/null ; then
		echo "Invalid target. Must be passed in the form of user@host"
		return 1
	fi

	readonly REMOTE_USER="$(echo "${REMOTE_TARGET}" | cut -d '@' -f 1)"
	#echo "DEBUG: REMOTE_USER: ${REMOTE_USER}"

	readonly REMOTE_HOST="$(echo "${REMOTE_TARGET}" | cut -d '@' -f 2)"
	#echo "DEBUG: REMOTE_HOST: ${REMOTE_HOST}"

	readonly REMOTE_NAME="$(echo "${REMOTE_HOST}" | cut -d '.' -f 1)"
	#echo "DEBUG: REMOTE_NAME: ${REMOTE_NAME}"

	readonly TEMP_DIR="/tmp"
	readonly TEMP_TUNNEL_PREFIX="dockly.sh_${USER}_"
	readonly TEMP_TUNNEL_SOCK="${TEMP_DIR}/${TEMP_TUNNEL_PREFIX}${REMOTE_NAME}.sock"
	readonly TEMP_TUNNEL_PID="${TEMP_DIR}/${TEMP_TUNNEL_PREFIX}${REMOTE_NAME}.pid"

	if [ -e "${TEMP_DIR}" ] ; then
		dockly.sh::cleanup || exit 1
	else
		mkdir -p "${TEMP_DIR}"
	fi


	ssh -o 'RemoteCommand none' -nNT -L "${TEMP_TUNNEL_SOCK}":/var/run/docker.sock "${REMOTE_TARGET}" &
	#ssh -nNT -L "${TEMP_TUNNEL_SOCK}":/var/run/docker.sock "${REMOTE_TARGET}" &
	SOCKET_PID=$!
	echo "${SOCKET_PID}" > "${TEMP_TUNNEL_PID}"

	if ! pid_process_running ; then
		echo "Failed to create ssh tunneled socket as background process."
		return 1
	fi

	dockly -s "${TEMP_TUNNEL_SOCK}"

	dockly.sh::cleanup || exit 1
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || dockly.sh::main "$@"
