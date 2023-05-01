#! /usr/bin/env bash

case $1 in
	verbose)
		verbose="true"
		shift 1
	;;
	*)
		verbose="false"
	;;
esac
verbose() {
	if "${verbose}" -eq "true" ; then
		echo "$@"
	fi
}

function source_directory() {
	target="$1"
	glob="$2"
	while IFS= read -r -d '' file; do
		#shellcheck disable=SC1090
	    source "$file" || { echo "ERROR: Failed to load $file" ; return 1 ; }
		verbose "Loaded: $file"

	done< <(find "${target}" -name "${glob}" -type f -print0)
}