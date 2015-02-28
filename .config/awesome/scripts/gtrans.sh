#!/bin/bash

if [ -x /usr/bin/trans ]; then
	result=`xsel -o | sed "s/[\"'<>]//g" | /usr/bin/trans -no-ansi -b`
	notify-send -u normal -t 10000 "$result"
else
	notify-send -u critical "translate-shell (https://github.com/soimort/translate-shell) required"
fi
