#! /bin/bash
function _fixpath () {
	#echo BEFORE
	#echo $PATH
	#USERNAME=`whoami`
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/WINDOWS\/System32\/Wbem//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/WINDOWS\/System32\/WindowsPowerShell\/v1\.0//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/WINDOWS\/system32//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/WINDOWS//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Users\/jekotia\/AppData\/Local\/Microsoft\/WindowsApps//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Users\/jameli\/AppData\/Local\/Microsoft\/WindowsApps//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program Files\/ConEmu\/ConEmu\/Scripts//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program Files\/ConEmu\/ConEmu//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program\ Files\ (x86)\/P-CAD\ 2006\ Viewer//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program Files\/ConEmu//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program\ Files\ (x86)\/Windows\ Live\/Shared//')
	echo $PATH | grep /cygdrive/c/adb/ || PATH=$PATH:/cygdrive/c/adb/
	#echo AFTER
	#echo $PATH
	export PATH=$PATH
}