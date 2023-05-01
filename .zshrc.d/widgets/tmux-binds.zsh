#! /usr/bin/env zsh

# _call_tmux_binds_old() {
# 	CONF_FILE="${HOME}/.tmux.conf"
# 	BIND_INFOS_PREFIX="# BIND INFOS: "
# 	PREFIX="$(grep -m 1 'BIND INFOS: Prefix: ' "${CONF_FILE}" | cut -d ':' -f 3 | sed 's|^ \(.*\)|\1|')"

# 	while read -r line ; do
# 		desc="$(echo "$line" | cut -d ':' -f 1 | sed 's|\s*\(.*\)\s*|\1|')"
# 		keys="$(echo "$line" | cut -d ':' -f 2 | sed 's|\s*\(.*\)\s*|\1|')"

# 		if [[ "$desc" == "new-line" ]] ; then
# 			printf "\n"
# 		elif [[ "$desc" == "$keys" ]] ; then
# 			printf "%40s\n" "$desc"
# 		else
# 			printf "%30s   %s\n" "$desc" "$keys"
# 		fi
# 	done < <( { \
# 			grep "^\s*${BIND_INFOS_PREFIX}" "${CONF_FILE}" \
# 			| sed "s|^\s*${BIND_INFOS_PREFIX}\(.*\)|\1|" \
# 			| sed "s|\(.*\)\$PREFIX\(.*\)|\1$PREFIX\2|"; \
# 			grep -v '^\s*#bind' "${CONF_FILE}" \
# 			| grep -A 1 '^\(\(bind\)\|\(\s*bind\)\)' \
# 			| grep -v '^\(bind\)\|\( *bind\)' \
# 			| grep -v '^--' \
# 			| sed "s|^\s*#\s*\(.*\)|\1|" \
# 			| sed "s|\(.*\)\$PREFIX\(.*\)|\1$PREFIX\2|"; \
# 	} ) | less
# 	zle redisplay
# }

function _call_tmux_binds_print_keys() {
	#printf "%30s   %6s   %3s%s\n" "$1" "$2" "$3" "$4"
	#printf "'%30s'   '%6s'   '%3s'%s'\n" "$1" "$2" "$3" "$4"
	#local q="'"
	local desc="$1"
	local prefix="$2"
	local mod="$3"
	local key="$4"

	local strip_whitespace_regex='s|^[[:blank:]]*||;s|[[:blank:]]*$||'
	
	# as per SC2086 added double-quotes around $mod
	mod="$(echo "$mod" | sed "$strip_whitespace_regex")"
	# as per SC2086 added double-quotes around $prefix
	prefix="$(echo "$prefix" | sed "$strip_whitespace_regex")"

	if [[ $key =~ ' -' ]] ; then
		key='-'
	else
		key="$(echo $key | sed "$strip_whitespace_regex")"
	fi

	# shellcheck disable=SC2183
	printf "%s%30s%s   %s%6s%s   %s%4s%s%s%s\n" "$q" "$desc" "$q"    "$q" "$prefix" "$q"    "$q" "$mod" "$q" "$key""$q"
	#print_keys "$desc" "$prefix_str" "$result_modifiers" "$result_keys"
}

_call_tmux_binds() {
	local CONF_FILE="${HOME}/.tmux.conf"
	local BIND_INFOS_PREFIX="# INFO_BIND: "
	# shellcheck disable=SC2155
	local PREFIX="$(\grep -m 1 'INFO_BIND: Prefix: ' "${CONF_FILE}" | cut -d ':' -f 3 | sed 's|^ \(.*\)|\1|')"

	local strip_whitespace_regex='s|^[[:blank:]]*||;s|[[:blank:]]*$||'
	# shellcheck disable=SC2155
	local PREFIX="$(echo $PREFIX | sed "$strip_whitespace_regex")"

	{
		_call_tmux_binds_print_keys "Description" "Prefix" "Mod" "Keys"

		local line
		local result_bind
		local result_hide_prefix
		local result_modifiers
		local result_keys
		local result_command
		local desc
		local bind
		while read -r line ; do
			result_bind=""
			result_hide_prefix=""
			result_modifiers=("")
			result_keys=("")
			result_command=("")
			desc=""
			bind=""
			
			if [[ $line =~ ^bind ]] ; then
				bind="$(echo "$line" | cut -d '#' -f 1 | sed 's|\s*\(.*\)\s*|\1|')"
				desc="$(echo "$line" | cut -d '#' -f 2 | sed 's|\s*\(.*\)\s*|\1|')"
				# shellcheck disable=SC2207
				arr=($(echo $bind))
				for i in "${arr[@]}" ; do
					# check for bind and block further matches
					# shellcheck disable=SC2128
					if		[[ $i =~ ^bind ]] && [ -z "$result_bind" ]  ; then
						result_bind="true"
					# check for commands and block further key matches
					elif	[[ $i =~ ^\[A-Za-z\]{3,} ]] || [ -n "$result_command" ] ; then
						result_command+=("$i")
						#echo "DEBUG:discarding>$i<"
					# If result_command doesn't yet have any values
					elif [ -z "$result_command" ] ; then
							# Check for -n
							if [[ "$i" == "-n" ]] ; then
								result_hide_prefix="true"
								#if [ -z "$result_modifiers" ] ; then
								#	result_modifiers=("ALT+")
								#else
									result_modifiers+=("ALT+")
								#fi
							else
								result_keys+=("$i")
								#echo "DEBUG:'$i' is key"
							fi
					else
						result_command+=("$i")
					fi
				done

				#echo "DEBUG:result_hide_prefix: $result_hide_prefix"
				#echo "DEBUG:result_command: $result_command"
				#echo "DEBUG:result_keys: $result_keys"
				#echo "$desc: ${prefix_str}${result_keys}"
				#echo "DEBUG:${prefix_str}${result_keys}"
				#echo "DEBUG:$bind"
				#echo "$bind"
				#echo "${desc}: ${prefix_str}${result_keys}"

				#printf "'%30s'   '%6s'   '%s'%s'\n" "$desc" "$prefix_str" "$result_modifiers" "$result_keys"

			elif [[ $line =~ new-line ]] ; then
				#printf "\n"
				line=""
				desc=""
				result_hide_prefix="true"
			elif [[ $line =~ INFO_BIND ]] ; then
				line="$(echo "$line" | sed "s|^\s*${BIND_INFOS_PREFIX}\(.*\)|\1|")"

				desc="$(echo "$line" | cut -d ':' -f 1 | sed 's|\s*\(.*\)\s*|\1|')"
				# shellcheck disable=SC2178
				result_keys="$(echo "$line" | cut -d ':' -f 2 | sed 's|\s*\(.*\)\s*|\1|')"
				# echo desc: $desc
				# echo result_keys: $result_keys
				# shellcheck disable=SC2128
				if [[ "$desc" == "$result_keys" ]] ; then
					# shellcheck disable=SC2178
					result_keys=""
				elif echo "$result_keys" | \grep "^$PREFIX" > /dev/null ; then
					# shellcheck disable=SC2178
					# shellcheck disable=SC2001
					result_keys="$(echo "$result_keys" | sed "s|^$PREFIX\(.*\)|\1|")"
					result_hide_prefix=""
				elif [[ "$result_keys" = "" ]] ; then
					result_hide_prefix="true"
				fi
				# echo $line
			else
				printf "error: %s" "$line"
			fi

			if [ -z "$result_hide_prefix" ] ; then
				prefix_str="${PREFIX} "
			else
				prefix_str=""
			fi
			# shellcheck disable=SC2128
			_call_tmux_binds_print_keys "$desc" "$prefix_str" "$result_modifiers" "$result_keys"
					#-e "s|^\s*${BIND_INFOS_PREFIX}\(.*\)|\1|" \
		done < <( { \
				\grep "^\s*${BIND_INFOS_PREFIX}" "${CONF_FILE}" \
				| sed \
					-e "s|\(.*\)\$PREFIX\(.*\)|\1$PREFIX\2|"; \
				\grep -v '^[\s#]*bind' "${CONF_FILE}" \
				| \grep '^\(\(bind\)\|\(\s*bind\)\)' \
				| sed 's|\s*\(.*\)|\1|' \
		;} )
	} | less
	zle redisplay
}

zle -N _call_tmux_binds

bindkey '^t' _call_tmux_binds
