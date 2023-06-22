#!/bin/bash 

sed 's/The Apache /The Apache2 /g' -i /lib/systemd/system/apache2.service
