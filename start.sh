#!/bin/bash
apiurl="http://localhost:8000"
miradorurl="http://localhost:8222"
vagrant up || exit 127
if [ ! -z `which xdg-open` ]; then
	xdg-open "$apiurl"
	xdg-open "$miradorurl"
elif [ ! -z `which open` ]; then
	open "$apiurl"
	open "$miradorurl"
fi
