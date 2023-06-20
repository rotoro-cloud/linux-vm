apt update
apt install -y  nslookup netstat

echo 10.0.2.20 jump_host >> /etc/hosts
echo 172.20.236.101 app01 >> /etc/hosts
echo 172.20.236.10 str01 >> /etc/hosts
echo 172.20.235.10 db01 >> /etc/hosts


gip=$(nslookup google.com | grep Address | grep -vi "\#" | awk '{print $2}' | grep ^[0-9][0-9]) &&  echo $gip google.com >> /etc/hosts

archive_ip=$(nslookup archive.ubuntu.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip archive.ubuntu.com >> /etc/hosts

archive_ip2=$(nslookup archive.canonical.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip2 archive.canonical.com >> /etc/hosts
