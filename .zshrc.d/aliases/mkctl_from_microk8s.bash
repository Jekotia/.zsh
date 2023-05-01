#! /usr/bin/env bash

# If microk8s is installed, alias its kubectl to mkctl
if hash microk8s > /dev/null 2>&1 ; then
	alias mkctl="microk8s kubectl"
fi