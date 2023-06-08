#! /bin/bash

echo "$(cat -)" | socat - "tcp:${PRIVATE_ETH_IP}:8121"
