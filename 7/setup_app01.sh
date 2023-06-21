#!/bin/bash 

ERR=0

function test_msg {
    if [ "$ERR" -eq 1 ]; then
        echo -e "${RED}Неудачно в стадии $1! ${NC}"  
    else
        echo -e "${GREEN}Все готово в стадии $1! ${NC}"
    fi
}

function result_msg {
    local status=$1
    if [ $status -ne 0 ]; then
        ERR=1
        echo -e "${RED} ошибка с $2 ${NC}" >&2
    else
        echo -e "${GREEN} ok $2 ${NC}"
    fi
}


RED_TEXT="Подожди, пока обе машины не настроятся."
GREEN_TEXT="https://t.me/RoToRoCloud"

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
PURPLE='\033[1;36m'
NC='\033[0m'

echo -e "${YELLOW}                       *     .--."
echo -e "                            / /  '"
echo -e "           +               | |"
echo -e "                  '         \ \__,"
echo -e "              *          +   '--'  *"
echo -e "                  +   /\ "
echo -e "     +              .'  '.   *"
echo -e "            *      /======\      +"
echo -e "                  ;:.  _   ;"
echo -e "                  |:. (_)  |"
echo -e "                  |:.  _   |"
echo -e "        +         |:. (_)  |          *"
echo -e "                  ;:.      ;"
echo -e "                .' \:.    / '."
echo -e "               / .-'':._.''-. \ "
echo -e "               |/    /||\    \|"
echo -e "${GREEN}             _..--^''''^^'':--.._"
echo -e "       _.-'(-   _'    /    '-_   ';'-._"
echo -e "     -'          ROTORO CLOUD          '-"
echo -e ""
echo -e "${RED}${RED_TEXT}"
echo -e ""

echo -e "${GREEN}${GREEN_TEXT}"
echo -e ""
read -p "${YELLOW}Внимание, перед запуском убедись, что вторая машина работает! Если не уверен нажми CTRL+C${NC}"



## sudo echo app01 > cat /etc/hostname
 
for i in {3..254}; do 
    addr=$(awk -F. '{ print $1 }' <<< $my_ip).$(awk -F. '{ print $2 }' <<< $my_ip).$(awk -F. '{ print $3 }' <<< $my_ip).$i ; 
    ping -c1 -W0.1 -t100 $addr > /dev/null; 
    if [[ $? -eq 0  && $(awk -F. '{ print $4 }' <<< $my_ip) != "$i" ]]; then 
        export app01=$addr; break; 
    fi; 
done;

 [ -n "$app01" ] && sed '/xzxz/d' /etc/hosts || echo -e "${RED}Не могу найти вторую ВМ! ${NC}"
 
 
 
 
 
