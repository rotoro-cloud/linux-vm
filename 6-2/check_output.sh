#!/bin/bash 

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
PURPLE='\033[1;36m'
NC='\033[0m'

iptables -L OUTPUT | grep db01 | grep dpt:mysql || echo -e "${RED}Проблема в правиле для базы с ws01! ${NC}"
iptables -L OUTPUT | grep str01 | grep -w dpt:http$ || echo -e "${RED}Проблема в правиле для репо с ws01! ${NC}"

iptables -L OUTPUT | tail -2 | grep DROP | grep -w dpt:http$ || echo -e "${RED}Проблема в общем правиле для http с ws01! ${NC}"
iptables -L OUTPUT | tail -2 | grep -w dpt:https | grep DROP || echo -e "${RED}Проблема в общем правиле для https с ws01! ${NC}"
