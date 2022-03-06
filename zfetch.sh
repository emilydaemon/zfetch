#!/bin/bash

#    zfetch - a fast but pretty fetch script
#    Copyright (C) 2022 jornmann
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# shellcheck source=/dev/null
# shellcheck disable=SC2059

# variables used: $NAME
# we do a check to see if $NAME is already set, if not, we try to detect OS
# ourselves
if [ "$NAME" = "" ]; then
	. /etc/os-release 2>/dev/null || export NAME="Unknown"
fi

# nc = no color
nc="\e[0m"

# logos

if [[ $NAME = *"Arch"* ]]; then
	dscolor="\e[0;36m" # cyan
	dslogo=("         "
			"   /\\    "
			"  /' \\   "
			" /_--_\\  "
			"         "
			"         ")
elif [[ $NAME == *"Gentoo"* ]]; then
	dscolor="\e[0;35m" # purple
	dslogo=("         "
			"   ---   "
			"  \\ 0 \\  "
			"  /__/   "
			"         "
			"         ")
elif [[ $NAME == *"Debian"* ]]; then
	dscolor="\e[0;31m" # red
	dslogo=("         "
			"   -^-   "
			"  ( @,)  "
			"  '-_    "
			"         "
			"         ")
elif [[ $NAME == *"donut"* ]]; then
	dscolor="\e[0;36m" # red
	dslogo=("   \$\$\$    "
			" \$##=##\$  "
			"!!:. .:!! "
			" \$##@##\$  "
			"   \$\$\$    "
			"          ")
elif [[ $NAME == *"openSUSE"* ]]; then
	dscolor="\e[0;32m" # green
	dslogo=("         "
			"    __   "
			"  /~_')  "
			"  @' '   "
			"         "
			"         ")
elif [[ $NAME == *"Fedora"* ]]; then
	dscolor="\e[0;34m" # blue
	dslogo=("         "
			"   /'')  "
			" .-''-.  "
			" '-..-'  "
			" (__/    "
			"         ")
elif [[ $NAME == *"Mint"* ]]; then
	dscolor="\e[0;32m" # blue
	dslogo=("         "
			" || -.-  "
			" ||_|||  "
			" \\____/  "
			"         "
			"         ")
elif [[ $NAME == *"MX"* ]]; then
	dscolor="\e[0;37m" # white
	dslogo=("         "
			"   \\/    "
			"   /\\    "
			"  /\\ \\   "
			" /__\\/\\  "
			"         ")
else
	dscolor="\e[0;37m" # white
	dslogo=("         "
			"  ('' )  "
			"  |() |  "
			"  (^(^)  "
			"         "
			"         ")
fi

# source the config file
if [ "$colorsoff" = "" ]; then
	colorsoff=0
fi

. /etc/zfetchrc 2> /dev/null
. ~/.zfetchrc 2> /dev/null

# command line parameters
if [ "$arg" = "" ]; then
	arg=""
elif [ "$arg" = "nologo" ]; then
	unset dslogo
elif [ "$arg" = "nofetch" ]; then
	printf "${dscolor}${dslogo[0]}\n${dslogo[1]}\n${dslogo[2]}\n${dslogo[3]}\n${dslogo[4]}\n${dslogo[5]}\n${nc}"
	exit
fi

# the meat and potatoes, actual fetch

host=$(</proc/sys/kernel/hostname)
kernel=$(</proc/version sed "s/version // ; s/ (.*//")
uptime=$(uptime -p | sed "s/up //")
shell=$(printf "$SHELL" | sed "s/\/bin\///")

printf "${dscolor}${dslogo[0]}$USER@$host\n"
printf "${dscolor}${dslogo[1]}OS     ${nc} $NAME\n"
printf "${dscolor}${dslogo[2]}Kernel ${nc} $kernel\n"
printf "${dscolor}${dslogo[3]}Uptime ${nc} $uptime\n"
printf "${dscolor}${dslogo[4]}Shell  ${nc} $shell\n"

if [ "$colorsoff" != 1 ]; then
	printf "${dslogo[5]}\e[0;31m● \e[0;32m● \e[0;33m● \e[0;34m● \e[0;35m● \e[0;36m● \e[0;37m●\e[0m\n"
fi
