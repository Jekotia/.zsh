#! /usr/bin/env sh

case $1 in
	shell)
		shift 1
		case $1 in
			-f|--force)
				args="--shell=bash"
			;;
			*)
				args=
			;;
		esac
		# -s bash \
		#shellcheck disable=SC2046 disable=SC2086
		shellcheck $args \
			.zshrc \
			$(find .zshrc.d/ -name "*.bash")
	;;
	tooling)
		#shellcheck disable=SC2086
		shellcheck $args \
			install-hooks.bash \
			shell-remote.bash \
			shell-setup-local.bash \
			shell-setup.bash \
			shell-update.bash \
			shellcheck.sh
	;;
	*)
		echo "Usage: $0 <target>"
		echo "Valid targets: shell , tooling"
	;;
esac
exit