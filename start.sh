#!/bin/bash 

ERR=0

function result_msg {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        ERR=1
        echo "${RED} error with $2 ${NC}" >&2
    else
        echo "${GREEN}ok $2 ${NC}"
    fi
    return $status
}


RED_TEXT="Подожди, пока тестовая среда не установится. Это может занять до 5 минут."
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
echo -e "${YELLOW}Настраиваю систему...${NC}"

result_msg "useradd max -s $(which bash) -G sudo -m" "add user"

result_msg "sed -i '/password\trequisite\t\t\tpam_pwquality.so/ s/^#*/#/' /etc/pam.d/common-password" "patch pam1"
result_msg "sudo sed -i 's/pam_unix.so obscure use_authtok try_first_pass yescrypt/pam_unix.so minlen=1 sha512/g' /etc/pam.d/common-password" "patch pam2"

result_msg "echo 'max:supeRbison' | sudo chpasswdm" "upd max's pass"

result_msg "cp -R /home/osboxes/linux-vm /home/max" "copy repo"

result_msg "echo 'ws01' > /etc/hostname" "upd hostname"

if [ "$ERR" -eq 1 ]; then
    echo -e "${RED}Неудачно!"  
else
    echo -e "${GREEN}Все готово!"
fi



































