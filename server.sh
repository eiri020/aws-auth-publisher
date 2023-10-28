#!/usr/bin/env bash

require()
{
	source $(pwd)/$1/index.sh
}

require bash-rest-server/http

processHeaders

require routes

exit 0
