#!/bin/bash 

echo 10.0.2.20 jump_host >> /etc/hosts
echo 172.20.236.101 app01 >> /etc/hosts
echo 172.20.236.10 str01 >> /etc/hosts
echo 172.20.235.10 db01 >> /etc/hosts


myip=$(ip a | grep "scope global" | grep enp0 | awk '{print $2}' | awk -F/ '{print $1}') && echo $myip ws01 >> /etc/hosts

gip=$(nslookup google.com | grep Address | grep -vi "\#" | awk '{print $2}' | grep ^[0-9][0-9]) &&  echo $gip google.com >> /etc/hosts

archive_ip=$(nslookup archive.ubuntu.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip archive.ubuntu.com >> /etc/hosts

archive_ip2=$(nslookup archive.canonical.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip2 archive.canonical.com >> /etc/hosts

archive_ip3=$(nslookup security.ubuntu.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip3 security.ubuntu.com >> /etc/hosts

archive_ip4=$(nslookup us.archive.ubuntu.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip4 us.archive.ubuntu.com >> /etc/hosts

archive_ip5=$(nslookup banjo.canonical.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip5 banjo.canonical.com >> /etc/hosts

archive_ip6=$(nslookup kazooie.canonical.com | grep Address | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vi "\#" | head -1 |awk '{print $2}') && echo $archive_ip5 kazooie.canonical.com >> /etc/hosts
