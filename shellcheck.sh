#! /usr/bin/env sh

case $1 in
	shell)
		shift 1
		case $1 in
			-f|--force)
				args="--shell=bash"
			;;
		esac
		# -s bash \
		shellcheck $args \
			.zshrc \
			.zshrc.d/init.bash \
			.zshrc.d/aliases/*.bash \
			.zshrc.d/functions/*.bash \
			.zshrc.d/snippets/*.bash \
			.zshrc.d/widgets/*.bash
	;;
	tooling)
		shellcheck \
			install-hooks.sh \
			shell-remote.sh \
			shell-setup-local.sh \
			shell-setup.sh \
			shell-update.sh \
			shellcheck.sh
	;;
	*)
		echo "Usage: $0 <target>"
		echo "Valid targets: shell , tooling"
	;;
esac
exit