#!/bin/bash
# 2017 (c) Stefan Kremser
# Simple script to start monitor mode on the provided wlan interface

# color definitions (https://en.wikipedia.org/wiki/ANSI_escape_code)
RED='\033[0;31m'
YELLOW='\033[0;33;1m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

interface=${1:-wlan0}

# check if interface exists
ifconfig $interface down
if [ $? -eq 0 ]; then
        iwconfig $interface mode monitor
        iw dev $interface set channel ${2:-1} ${4:-}
        iwconfig $interface txpower ${3:-30}
        ifconfig $interface up
        echo -e "${GREEN}Enabled monitor mode on $interface"
        exit 0
else
        echo -e "${RED}ERROR: ${YELLOW}Please provide an existing interface as parameter! ${NC}"
        echo -e "${NC}Usage: startWlan.sh [interface:wlan0] [channel:1] [txpower:30] ${NC}"
        echo -e "${NC}Tips: check with ${CYAN}ifconfig ${NC}or ${CYAN}iwconfig ${NC}which interfaces are available! ${NC}"
        exit 1
fi
