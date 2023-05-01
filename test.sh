#! /bin/bash

shellcheck -s bash \
	.zshrc \
	.zshrc.d/init.bash \
	.zshrc.d/aliases/*.bash \
	.zshrc.d/functions/*.bash \
	.zshrc.d/snippets/*.bash \
	.zshrc.d/widgets/*.bash