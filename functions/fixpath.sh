#! /bin/bash
function _fixpath () {
	declare -a addList=("/cygdrive/c/adb"
	"/cygdrive/c/HashiCorp/Vagrant/bin"
	)

	declare -a replaceList=("derpingtoday"
	"/cygdrive/c/perl/bin"
	"/cygdrive/c/perl/site/bin"
#	"/cygdrive/c/ProgramData/chocolatey/bin"
	"/cygdrive/c/Program\ Files/ConEmu"
	"/cygdrive/c/Program\ Files/ConEmu/ConEmu"
	"/cygdrive/c/Program\ Files/ConEmu/ConEmu/Scripts"
	"/cygdrive/c/Program\ Files/Git/cmd"
	"/cygdrive/c/Program\ Files/Microsoft\ VS\ Code/bin"
	"/cygdrive/c/Program\ Files/Microsoft\ VS\ Code/bin"
	"/cygdrive/c/Program\ Files\ (x86)/Admin\ Arsenal/PDQ\ Deploy"
	"/cygdrive/c/Program\ Files\ (x86)/Admin\ Arsenal/PDQ\ Inventory"
	"/cygdrive/c/Program\ Files\ (x86)/Microsoft\ SQL\ Server/100/Tools/Binn"
	"/cygdrive/c/Program\ Files\ (x86)/Microsoft\ SQL\ Server/100/DTS/Binn"
	"/cygdrive/c/Program\ Files\ (x86)/Nmap"
	"/cygdrive/c/Program\ Files\ (x86)/P-CAD\ 2006\ Viewer"
	"/cygdrive/c/Program\ Files\ (x86)/Spiceworks/Nmap"
	"/cygdrive/c/Program\ Files\ (x86)/Spiceworks/Nmap"
	"/cygdrive/c/Program\ Files\ (x86)/Windows\ Kits/10/Windows\ Performance\ Toolkit"
	"/cygdrive/c/Program\ Files\ (x86)/Windows\ Kits/10/Microsoft\ Application\ Virtualization/Sequencer"
	"/cygdrive/c/Program\ Files\ (x86)/Windows\ Live/Shared"
	"/cygdrive/c/Python27"
	"/cygdrive/c/StrawberryPerl/c/bin"
	"/cygdrive/c/StrawberryPerl/perl/bin"
	"/cygdrive/c/StrawberryPerl/perl/site/bin"
	"/cygdrive/c/Users/jameli/\.babun"
	"/cygdrive/c/Users/jameli/AppData/Local/atom/bin"
	"/cygdrive/c/Users/jameli/AppData/Local/GitHubDesktop/bin"
	"/cygdrive/c/Users/jameli/AppData/Local/Microsoft/WindowsApps"
	"/cygdrive/c/Users/jameli/AppData/Local/Programs/Fiddler"
	"/cygdrive/c/Users/jameli/AppData/Roaming/npm"
	"/cygdrive/c/Users/jekotia/AppData/Local/Microsoft/WindowsApps"
	"/cygdrive/c/WINDOWS"
	"/cygdrive/c/WINDOWS/system32"
	"/cygdrive/c/WINDOWS/System32/OpenSSH"
	"/cygdrive/c/WINDOWS/System32/Wbem"
	"/cygdrive/c/WINDOWS/System32/WindowsPowerShell/v1\.0"
	)
#	"/cygdrive/c/Program\ Files\ (x86)/"

#/cygdrive/c/ProgramData/Oracle/Java/javapath
#/cygdrive/c/Program Files/nodejs
#/cygdrive/c/Program Files (x86)/Nmap
#/cygdrive/c/Users/jameli/AppData/Roaming/npm

	for i in "${addList[@]}" ; do 
		#var="/cygdrive/c/adb" ; echo $PATH | grep "$var" > /dev/null 2&>1 || PATH="$PATH:$var"
		#var="/cygdrive/c/HashiCorp/Vagrant/bin" ; echo $PATH | grep "$var" > /dev/null 2&>1 || PATH="$PATH:$var"

		if ! echo $PATH | grep "${i}" > /dev/null 2&>1 ; then
			PATH="$PATH:${i}"
		fi
	done

	for i in "${replaceList[@]}" ; do
		#echo $i
		## https://stackoverflow.com/a/29867033
		PATH=$(echo "$PATH" | sed -e "s;\?:${i};;" -e "s;${i}:\?;;")
	done

	export PATH=$PATH
#	echo $PATH
}
#_fixpath
