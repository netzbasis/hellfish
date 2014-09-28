#!/bin/sh
#
# Debug output helper script
############################################################
DEBUG_PRINT_TO_FILE="" # default to stdout
DEBUG_PRINT_STACK=""
DEBUG_DEBUG="0"
############################################################
# $1 debug message
function dprint {
	DATE=$(_get_date)
	DINFO=$(echo $DEBUG_PRINT_STACK | rev | cut -d ':' -f 1 | rev)
	output_text "$DATE $DINFO: $1"
}

function dprint_stack_trace {
	DATE=$(_get_date)
	output_text "$DATE stacktrace $DEBUG_PRINT_STACK"
}

# $1 function name
function dpush {
	DEBUG_PRINT_STACK="$DEBUG_PRINT_STACK:$1"
	if [ $DEBUG_DEBUG -gt 0 ]
	then
		dprint_stack_trace
	fi
}

function dpop {
	DEBUG_PRINT_STACK=$(echo $DEBUG_PRINT_STACK | rev | cut -d ':' -f 2- | rev)
	if [ $DEBUG_DEBUG -gt 0 ]
	then
		dprint_stack_trace
	fi
}

# $1 exit code
function dprint_trace_exit_if_error {
	if [ $1 -gt 0 ]; then
		dprint_stack_trace
		exit $1
	fi
}

# $1 text
function output_text {
	if [ "x$DEBUG_PRINT_TO_FILE" = "x" ]; then
		echo "$1"
	else
		echo "$1" >> $DEBUG_PRINT_TO_FILE
		dprint_trace_exit_if_error $?
	fi
}

function _get_date {
	echo $(date +%Y%m%d-%H%M%S)
}
############################################################


