#! /usr/bin/env bash

gitRoot="$(git rev-parse --show-toplevel)"
nanorcPostMergePath="${gitRoot}/.git/modules/extras/nanorc/hooks/post-merge"
nanorcPostMergeHookPath="${gitRoot}/hooks/modules/extras/nanorc/hooks/post-merge"

if [ ! -f "${nanorcPostMergePath}" ] ; then
	ln -s "${nanorcPostMergeHookPath}" "${nanorcPostMergePath}"
fi
