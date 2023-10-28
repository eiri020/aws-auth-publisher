#!/bin/bash
source config

# add ,bind=127.0.0.1 after fork for local setup, remove for docker
socat TCP4-LISTEN:${svc_port},fork EXEC:./server.sh
