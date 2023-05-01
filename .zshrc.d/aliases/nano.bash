#! /usr/bin/env bash

# Set an alias for nano that is tailored to the capabilities of the installed version.
#alias nano='nano--tabsize=4 --linenumbers --wordbounds --softwrap --constantshow'
nanohelp=$(nano --help)
nanolist=("--linenumbers" "--wordbounds" "--softwrap" "--constantshow")
for i in "${nanolist[@]}" ; do
	if echo "$nanohelp" | grep --silent "\\$i" ; then
		nanoargs="${nanoargs} ${i}"
	fi
done
if echo "$nanohelp" | grep --silent "\--tabsize" ; then
	nanoargs="${nanoargs} --tabsize=4"
fi
# shellcheck disable=SC2139
alias nano="nano ${nanoargs}"