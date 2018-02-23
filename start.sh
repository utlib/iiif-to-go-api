#!/bin/bash
splashurl="`dirname $0`/splash/index.html"
vagrant up || exit 127
if [ ! -z `which xdg-open` ]; then
	xdg-open "$splashurl"
elif [ ! -z `which open` ]; then
	open "$splashurl"
fi
