#!/bin/bash


function color_load()
{
    load=$1

    if (( $( echo "${load} > ($(get_cores)*4)" | bc -l) )); then
	echo -n "${load} | color=red "
	return
    fi

    if (( $( echo "${load} > ($(get_cores)*2)" | bc -l) )); then
	echo -n "${load} | color=#ffaa00 "
	return
    fi

    echo -n "${load} | color=green"
    return
}

function get_cores()
{
    echo $(sysctl -n hw.ncpu)
}

IFS=' ' read -r -a loads <<< $(uptime | sed 's/^.* averages: //')

loads[0]=$(color_load "${loads[0]}")
loads[1]=$(color_load "${loads[1]}")
loads[2]=$(color_load "${loads[2]}")


echo "Load: ${loads[0]}"
echo ---
echo "1 min: ${loads[0]}"
echo "5 min: ${loads[1]}"
echo "15 min: ${loads[2]}"
