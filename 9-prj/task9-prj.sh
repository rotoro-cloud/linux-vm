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

nat_if=$(ip a | grep "state DOWN" | awk '{ print $2 }' | awk -F: '{ print $1 }')

ip link set dev $nat_if up
result_msg "$?" "fix IF"

rm -rf /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/cache/apt/archives/lock

apt install mysql-server -y
result_msg "$?" "install MYSQL"

#mysqld --initialize-insecure; 
#result_msg "$?" "init MYSQL"

systemctl start mysql
result_msg "$?" "start MYSQL"

while ! mysql -uroot -e "show databases;" > /dev/null 2>&1; do
  printf '.'
  ((c++)) && ((c==30)) && break && result_msg "1" "30s connection to MYSQL"
  sleep 1
done

bash -c "mysql -uroot -e \"use mysql; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpassmysql'; CREATE USER 'djangouser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PASSWORD'; CREATE DATABASE lets_quiz; GRANT ALL PRIVILEGES ON lets_quiz.* TO 'djangouser'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;\""
result_msg "$?" "MYSQL user fix"

mysql -udjangouser -pPASSWORD lets_quiz < /home/max/linux-vm/9-prj/dump.sql
result_msg "$?" "data seeding"

cp /home/max/linux-vm/9-prj/pollme-code.tar.gz /home/max/pollme-code.tar.gz
result_msg "$?" "upload the code"

ssh -i /home/max/.ssh/id_rsa -o StrictHostKeyChecking=no max@app01 "echo supeRbison | sudo -S bash -c \"groupadd -r pollme;  useradd -r -d /home/max -s /bin/bash -g pollme pollme; chown -R max: /home/max; usermod -a -G max pollme; mkdir -p /home/max/.local; chmod g+x /home/max/.local;\""
result_msg "$?" "app01 provision"
