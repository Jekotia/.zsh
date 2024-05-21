#! /usr/bin/env zsh

# To customize prompt, run `p10k configure` or edit ${ZDOTDIR}/.p10k.zsh.
# shellcheck disable=SC1091
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source "${ZDOTDIR}"/.p10k.zsh
### https://github.com/romkatv/powerlevel10k
if [[ -e ${ZDOTDIR}/extras/powerlevel10k/powerlevel10k.zsh-theme ]] ; then
	# shellcheck disable=SC1091
	source "${ZDOTDIR}"/extras/powerlevel10k/powerlevel10k.zsh-theme
fi

if [[ "$(hostname)" == "pan" ]] || [[ "$(hostname)" == "pan.jekotia.net" ]] ; then
	# shellcheck disable=SC2034
	POWERLEVEL9K_IP_INTERFACE="enp3s0f0"

else
	# shellcheck disable=SC2034
	POWERLEVEL9K_IP_INTERFACE="eth0"
fi