#! /bin/bash

#AUTHOR : HENRIQUE LUZ RODRIGUES
#DATE : 12/02/2020
#

__='
@@@@@@@@@
UBUNTU Release : 18.04
script for start or stop services at the project.
@@@@@@@@@
'
echo "$__"

startServices=mongodb,mysql,postgresql,freeradius,redis
stopServices=apache2

for service in ${startServices//,/ } 
	do
		if (( !$(ps -ef | grep -v grep | grep $service | wc -l) > 0 )) 
			then
				service $service start
				service $service status
			fi
	done

for service in ${stopServices//,/ } 
	do
		if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )) 
			then
				service $service stop
				service $service status
			fi
	done

source deploy/envs/rg_erp2/bin/activate
