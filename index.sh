#!/bin/bash
source config

socat TCP4-LISTEN:${svc_port},fork EXEC:./server.sh
