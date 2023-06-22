#!/bin/bash

apt install mysql-server

mysqld --initialize-insecure; systemctl start mysql

while ! mysql -uroot -e "show databases;" > /dev/null 2>&1; do
  printf '.'
  sleep 1
done

bash -c "mysql -uroot -e \"use mysql; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpassmysql'; CREATE USER 'djangouser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PASSWORD'; CREATE DATABASE lets_quiz; GRANT ALL PRIVILEGES ON lets_quiz.* TO 'djangouser'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;\""

mysql -udjangouser -pPASSWORD lets_quiz < /home/max/linux-vm/9-prj/dump.sql

cp /home/max/linux-vm/9-prj/pollme-code.tar.gz /home/max/pollme-code.tar.gz

ssh -i /home/max/.ssh/id_rsa -o StrictHostKeyChecking=no max@app01 "echo supeRbison | sudo -S bash -c \"groupadd -r pollme;  useradd -r -d /home/max -s /bin/bash -g pollme pollme; chown -R max: /home/max; usermod -a -G max pollme\""
