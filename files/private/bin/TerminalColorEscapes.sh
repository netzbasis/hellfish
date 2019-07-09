#!/bin/sh

getColorByName() {
	case "$1" in
		"black")
			echo -n 0;;
		"red")
			echo -n 1;;
		"green")
			echo -n 2;;
		"brown")
			echo -n 3;;
		"blue")
			echo -n 4;;
		"magenta")
			echo -n 5;;
		"cyan")
			echo -n 6;;
		"grey")
			echo -n 7;;
		"reset")
			echo -n 9;;
		*)
			echo -n 9;;
	esac
}


if [ $# -lt 1 ] 
then
	echo "usage $0 fgColor [bgColor [special]]"
	echo -e "color may be\n\tblack, red, green, brown, blue, magenta, cyan, grey, reset"
	echo -e "special may be\n\tbold, underline"
	echo
	echo -en "use it like\n\techo [-e] \"\$($0 red black bold)Hello World\$($0 reset)\" -> "
	echo -e "$(./$0 red black bold)Hello World$(./$0 reset)"
	echo -en "\techo [-e] \"\$($0 green - underline)Hello World\$($0 x)\" -> "
	echo -e "$(./$0 green - underline)Hello World$(./$0 x)"
	echo
	echo -e "short hint\n\tif you don't get the name right, it's like you wrote reset or nothing at all."
	exit 1
fi

if [ $# -ge 1 ]
then
	fgC="3$(getColorByName $1)"
	bgC="49"
	specialC="0"
fi

if [ $# -ge 2 ]
then
	bgC="4$(getColorByName $2)"
fi

if [ $# -ge 3 ]
then
	case $3 in
		"bold")
			specialC="1";;
		"underline")
			specialC="4";;
		*)
			;;
	esac
fi

echo -e "\\\033[$specialC;$fgC;$bgC"m
