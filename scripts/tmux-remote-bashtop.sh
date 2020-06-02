#! /bin/bash
SESSION_NAME="bashtop"

if tmux ls | grep "${SESSION_NAME}" ; then
	echo "Attaching session"
	tmux attach -t ${SESSION_NAME}
else
	echo "Creating session"
    tmux -2 \
		new \
			-s "${SESSION_NAME}" \
			"tmux set-option status-left ''; tmux set-option status-right ''; tmux rename-window $(hostname); bashtop"
fi

