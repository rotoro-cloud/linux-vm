#!/bin/bash 

rm -rf /home/max/cave-of-cmds /opt/drak-app/ /usr/local/stegosaurus.pet /etc/stegosaurus.pet /root/stegosaurus.pet /etc/systemd/system/covid.service /usr/bin/stegosaurus.pet /home/max/endless
rm -rf /tmp/first /tmp/second /tmp/third /tmp/fourth
rm -rf stars.tar.gz /home/max/letters/

mkdir -p /home/max/cave-of-cmds/cow-house/pile-of-garbage;
mkdir -p /home/max/cave-of-cmds/stable;
mkdir -p /home/max/cave-of-cmds/garbage-dump;
mkdir -p /opt/drak-app/red/yellow/orange;mkdir -p /opt/drak-app/yellow/orange/red;mkdir -p /opt/drak-app/orange/red/yellow;
mkdir -p /home/max/tmp/forest/
mkdir -p /var/games/animals; mkdir -p /var/zoo/south/animals; mkdir -p /var/lib/docker/animals

echo 'Хорошо, ты умеешь разжимать! ' > /home/max/cave-of-cmds/horse.dat; gzip /home/max/cave-of-cmds/horse.dat;

touch /tmp/first; touch /tmp/second; touch /tmp/fourth;
touch /tmp/third -d "2020-02-02 20:02:20"

for i in {1..300};do echo "orange file" > /opt/drak-app/red/yellow/orange/orange.$RANDOM; done;
for i in {1..300};do echo "red file" > /opt/drak-app/yellow/orange/red/red.$RANDOM; done;
for i in {1..300};do echo "red file" > /opt/drak-app/orange/red/yellow/yellow.$RANDOM; done;

dd if=/dev/zero of=/home/max/cave-of-cmds/cow-house/pile-of-garbage/garbage.dat count=100024 bs=1024;
dd if=/dev/zero of=/usr/local/stegosaurus.pet count=100024 bs=1024;
dd if=/dev/zero of=/etc/stegosaurus.pet count=100024 bs=1024;
dd if=/dev/zero of=/root/stegosaurus.pet count=100024 bs=1024;

echo "Roskomnadzor: Telegram, give me the keys!" | base64 > /home/max/tmp/forest/elephant-key

echo "Stephen King, The Tommyknockers:" > /home/max/goal.txt
echo -e "" >> /home/max/goal.txt
echo "Late last night and the night before, tommyknockers, tommyknockers knocking on my door. I wanna go out, don't know if I can 'cuz I'm so afraid of the tommyknocker man." > /home/max/text.txt

echo "Thing to do: take the 'Ansible for beginners course' by ROTORO.CLOUD" > /opt/drak-app/orange/red/yellow/orange-scroll; 
echo "dragon.dragon85@gmail.com  mysecretpassword000" > /opt/drak-app/red/yellow/orange/red-scroll;
echo "Dear dragon, the best medicine for your disease will be the urgent '/etc/systemd/system/covid.service' file deletion. Just delete it! Best regards, Dr. Aibolit." > /opt/drak-app/yellow/orange/red/yellow-scroll; 
echo "" > /etc/systemd/system/covid.service;
echo "172.20.20.20 madagascar" > /etc/turtlehosts;

echo "I am lost..." > /usr/bin/stegosaurus.pet

for i in {1..534};do echo "Wise thought $RANDOM" >> /home/max/endless; done;
echo "Its ququ" >> /home/max/endless;
for i in {1..111};do echo "Wise thought $RANDOM" >> /home/max/endless; done;
echo "ququ here" >> /home/max/endless;
for i in {1..21};do echo "Wise thought $RANDOM" >> /home/max/endless; done;
echo "ququ, well you know" >> /home/max/endless;
for i in {1..51};do echo "Wise thought $RANDOM" >> /home/max/endless; done;

mkdir -p /home/max/sky/ ;
cd /home/max/sky/
for i in $(seq 1 500) ; do fallocate -l 24 /home/max/sky/star$i ; done ;
cd ..
tar -czf stars.tar.gz sky
rm -rf /home/max/sky/


mkdir -p /home/max/letters/ ;
cd /home/max/letters/
for i in {A..Z} ; do echo $i > $i ; done
xz ./*


chown -R max:max /home/max
