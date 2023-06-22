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

userdel -r max
rm -rf /home/max/
rm -rf /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/cache/apt/archives/lock

apt install -y ssh sshpass tree plocate dnsutils net-tools curl vim
result_msg "$?" "install sshd and utils"

systemctl enable ssh --now
result_msg "$?" "enable ssh"

echo -e ""
test_msg "provision"
ERR=0
echo -e ""

echo -e "${YELLOW}Настраиваю окружение...${NC}"

useradd max -s $(which bash) -G sudo -m
result_msg "$?" "add user"

sed -i '/password\trequisite\t\t\tpam_pwquality.so/ s/^#*/#/' /etc/pam.d/common-password
result_msg "$?" "patch pam1"

sed -i 's/pam_unix.so obscure use_authtok try_first_pass yescrypt/pam_unix.so minlen=1 sha512/g' /etc/pam.d/common-password
result_msg "$?" "patch pam2"

echo 'max:supeRbison' | sudo chpasswd && usermod -U max
result_msg "$?" "upd maxs pass"

cp -R /home/osboxes/linux-vm/ /home/max/linux-vm/
result_msg "$?" "copy repo"

chown -R max:max /home/max/
result_msg "$?" "perm repo"

echo 'ws01' > /etc/hostname
result_msg "$?" "upd hostname"

echo -e ""
test_msg "creation"
ERR=0
echo -e ""

echo -e "${YELLOW}Проверяю...${NC}"


echo id max
result_msg "$?" "user max exist"

sudo su osboxes sh -c 'echo supeRbison | su - max -c id'
result_msg "$?" "user has correct pass"

sshpass -p supeRbison ssh -o StrictHostKeyChecking=no max@localhost 'exit'
result_msg "$?" "user ssh"

sudo -l -U max | grep ALL
result_msg "$?" "max can sudo"

echo -e ""
test_msg "tests"
ERR=0
echo -e ""

























