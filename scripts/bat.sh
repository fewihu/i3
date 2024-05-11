#!/bin/bash

set -eux pipefail

while :
do
    let SLEEP=180
    POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')
    if [[ $POWER -le 15 ]]; then
	notify-send "Battery power is lower than 15% ($POWER%)!"
	let SLEEP=120
    fi
    if [[ $POWER -le 10 ]]; then
	( speaker-test -t sine -f 460 )& pid=$! ; sleep 1.2s ; kill -9 $pid
	let SLEEP=60
    fi
    sleep "$SLEEP"
done
