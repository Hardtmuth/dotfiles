#!/bin/bash

test -d /proc/sys/net/ipv4/conf/Tstroy || [ -d /proc/sys/net/ipv4/conf/crb ] \
&& echo '{"text":"Connected","class":"connected","percentage":100}' \
|| echo '{"text":"Disconnected","class":"disconnected","percentage":0}'


