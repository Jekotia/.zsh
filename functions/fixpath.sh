#! /bin/bash
function _fixpath () {
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
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program\ Files\/Git\/cmd//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program\ Files\/Microsoft\ VS\ Code\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Users\/jameli\/AppData\/Local\/atom\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Users\/jameli\/AppData\/Local\/GitHubDesktop\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Users\/jameli\/\.babun//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Python27//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/Program\ Files\ \(x86\)\/Spiceworks\/Nmap//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/perl\/site\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/perl\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/StrawberryPerl\/c\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/StrawberryPerl\/perl\/bin//')
	PATH=$(echo "$PATH" | sed -e 's/:\/cygdrive\/c\/StrawberryPerl\/perl\/site\/bin//')
#	PATH=$(echo "$PATH" | sed -e 's/:path//')
#	PATH=$(echo "$PATH" | sed -e 's/:path//')
#	PATH=$(echo "$PATH" | sed -e 's/:path//')

#/cygdrive/c/ProgramData/Oracle/Java/javapath
#/cygdrive/c/Program Files/nodejs
#/cygdrive/c/Program Files (x86)/Nmap
#/cygdrive/c/Users/jameli/AppData/Roaming/npm

#	PATH=$(echo "$PATH" | sed -e 's/:path//')
	var="/cygdrive/c/adb" ; echo $PATH | grep "$var" > /dev/null 2&>1 || PATH="$PATH:$var"
	var="/cygdrive/c/HashiCorp/Vagrant/bin" ; echo $PATH | grep "$var" > /dev/null 2&>1 || PATH="$PATH:$var"

	export PATH=$PATH
}
