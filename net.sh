#!/bin/bash

userId='XXX'
passwd='XXX'
mac=`ifconfig | grep wan | awk '{ print tolower($5) }'`

status=0
echo "net start:$(date +%F-%T)" >>/root/net.log
while true; do
	ping -c2 -A 119.29.29.29 >/dev/null
	ret=$?
	ping -c2 -A 223.6.6.6 >/dev/null
	ret2=$?
	if [[ ${ret} -eq 0 || ${ret2} -eq 0 ]]; then
		if [ $status -eq 0 ];then
			status=1
			echo 0 > /sys/class/leds/red:sys/brightness
			echo 1 > /sys/class/leds/green:sys/brightness
		fi
		continue
	else
		if [ $status -eq 1 ]; then
			status=0
			echo 0 > /sys/class/leds/green:sys/brightness
			echo 1 > /sys/class/leds/red:sys/brightness
		fi
		wlanacip=`ifconfig | grep -A1 "wan" | grep 'inet addr' |awk -F ':' '{print $2}'|awk '{print $1}'`
		url="http://x.x.x.x:8888/webauth.do?wlanacip=172.168.1.5&wlanacname=zax_xxx&wlanuserip=${wlanacip}&mac=${mac}&vlan=xxxx&url=http://1.1.1.1"
		curl -fs "${url}" \
			-H 'Content-Type: application/x-www-form-urlencoded' \
			-H 'Origin: http://x.x.x.x:8888' \
			-H "Referer: ${url}" \
			-H 'Upgrade-Insecure-Requests: 1' \
			-H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1' \
			--data-raw "hostIp=http%3A%2F%2F127.0.0.1%3A8080%2F&loginType=&auth_type=0&isBindMac1=0&pageid=-1&templatetype=1&listbindmac=0&recordmac=1&isRemind=0&loginTimes=&groupId=&distoken=&echostr=&url=http%3A%2F%2F1.1.1.1&isautoauth=&notice_pic_loop1=%2Fportal%2Fuploads%2Fpc%2Fdemo3%2Fimages%2Flogo.jpg&notice_pic_loop2=%2Fportal%2Fuploads%2Fpc%2Fdemo3%2Fimages%2Frrs_bg.jpg&userId=${userId}&passwd=${passwd}&isBindMac=bindmac" \
			--insecure > /dev/null
        echo "net restart:$(date +%F-%T)" >>/root/net.log
		sleep 10
		continue
	fi
	sleep 3
	continue
done
