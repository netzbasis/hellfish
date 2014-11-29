#!/bin/sh
#
# Helper scripts
########################################################################
DOTS_RUNNING_PID=0
TSTART=0

__delete_multiple_whitespaces() {
	RET=$(echo "$1" | sed "s/  / /g") 
	echo $RET
}

__get_timestamp() {
	echo $(date +%s)
}

__start_timer() {
	TSTART=$(__get_timestamp)
}

__stop_timer() {
	TSTOP=$(__get_timestamp)
	TELAPSED=$(( $TSTOP - $TSTART ))
	TMIN=$(( $TELAPSED / 60 ))
	TSEC=$(( $TELAPSED % 60 ))
	echo $TMIN:$TSEC
}

__start_dots() {
	__stop_dots	
	/bin/sh <<EOF &
while [ 1 -eq 1 ]
do
sleep 5
echo -n "."
done
EOF
	
	DOTS_RUNNING_PID=$!
}

__stop_dots() {
	if [ $DOTS_RUNNING_PID -gt 0 ]
	then
		kill $DOTS_RUNNING_PID
		printf "\n"
	fi

	DOTS_RUNNING_PID=0
}

