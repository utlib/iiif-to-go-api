#!/bin/bash
url="http://localhost:8000"
vagrant up || exit 127
if [ ! -z `which xdg-open` ]; then
	xdg-open "$url"
elif [ ! -z `which open` ]; then
	open "$url"
fi
