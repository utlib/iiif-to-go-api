#!/bin/bash
splashurl="http://127.0.0.1:8222/splash"
vagrant up || exit 127
if [ ! -z `which xdg-open` ]; then
	xdg-open "$splashurl" > /dev/null 2>&1
elif [ ! -z `which open` ]; then
	open "$splashurl" > /dev/null 2>&1
fi
