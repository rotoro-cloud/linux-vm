#!/bin/bash 

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
PURPLE='\033[1;36m'
NC='\033[0m'

iptables -L INPUT | grep jump_host | grep -i ssh || echo -e "${RED}Проблема в правиле SSH с jump_host! ${NC}"
iptables -L INPUT | grep app01 | grep -i http || echo -e "${RED}Проблема в правиле HTTP с app01! ${NC}"

iptables -L INPUT -n | tail -1 | awk '{print $5}'| grep '0.0.0.0/0' && iptables -L INPUT -n | tail -1 | awk '{print $4}'| grep '0.0.0.0/0' && iptables -L INPUT -n | tail -1 | awk '{print $2}'| grep all

if [ $? -ne 0 ]; then
    echo -e "${RED} Проблема в дефолтном правиле! ${NC}"
fi
