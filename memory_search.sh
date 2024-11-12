#!/bin/bash

usage() {
    echo "Usage: $0 <operation_type> <profile> <keyword>"
    echo "operation_type:"
    echo "  0 - search profile information (ignore profile and keyword)"
    echo "  1 - search pid (list all PIDs if keyword is not provided)"
    echo "  2 - search process tree by application"
    echo "  3 - search network connections used by application"
    echo "  4 - search command execution"
    echo "profile: input profile name (required for operations 1-4)"
    echo "keyword: input string or integer to search information (optional for operations 1 and 4)"
    exit 1
}

if [ -z "$1" ]; then
    usage
fi

operation_type=$1
profile=$2
keyword=$3

if [ "$operation_type" -ge 1 ] && [ "$operation_type" -le 4 ] && [ -z "$profile" ]; then
    echo "Error: Profile name is required for operation type $operation_type"
    usage
fi

if [ "$operation_type" -ge 2 ] && [ "$operation_type" -le 3 ] && [ -z "$keyword" ]; then
	echo"Error: Keyword required for operation type $operation_type"
	usage
fi

case "$operation_type" in
    0)
        echo "Searching profile information..."
        vol.py -f memdumpWin7.mem imageinfo
        ;;
    1)
	if [ -n "$keyword" ]; then
		echo "Using profile=$profile to search for PID $keyword..."
		vol.py -f memdumpWin7.mem --profile=$profile pslist -p $keyword
	
        else
		echo "Listing all PIDs for profile=$profile..."
		vol.py -f memdumpWin7.mem --profile=$profile pslist
        fi
        ;;
    2)
	echo "Using profile=$profile to search process tree for $keyword..."
	vol.py -f memdumpWin7.mem --profile=$profile pstree | grep $keyword
        ;;
    3)
	echo "Using profile=$profile to search network connections for $keyword..."
	vol.py -f memdumpWin7.mem --profile=$profile netscan | grep $keyword
        ;;
    4)
	if [ -n "$keyword" ]; then
		echo "Using profile=$profile to search command execution for $keyword..."
		vol.py -f memdumpWin7.mem --profile=$profile cmdscan | grep $keyword
	else
		echo "Searching command execution using profile=$profile..."
		vol.py -f memdumpWin7.mem --profile=$profile cmdscan
	fi
        ;;
    *)
        echo "Invalid operation type."
        usage
        ;;
esac

