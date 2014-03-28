#!/bin/bash

############################################
#
# Connexion 3G + FTP
#
# Tim
############################################

#Heat the resistor
python /home/pi/cam/chauffe.py
sleep 5

#create png
/bin/bash /home/pi/cam/RRDtemp/createpng.sh

#Get pictures from the cam
if [[ $1 = "HD" ]] ; then
	echo "HD"
	raspistill -o /home/pi/cam/img/lastcapture.jpg -w 960 -h 720 -q 50 -n >> /tmp/sortiecam.log
fi

if [[ $1 = "LD" ]] ; then
	echo "LD"
	raspistill -o /home/pi/cam/img/lastcapture.jpg -w 640 -h 480 -q 40 -n >> /tmp/sortiecam.log
fi

if [[ $1 = "MP4" ]] ; then
	echo "MP4"
	raspivid -o /home/pi/cam/img/lastvideo.h264 -t 10000 --bitrate 1000000 -w 640 -h 480 -fps 12 -n
	rm /home/pi/cam/img/lastvideo.mp4
	sleep 1
	MP4Box -fps 12 -add /home/pi/cam/img/lastvideo.h264 /home/pi/cam/img/lastvideo.mp4
fi

#connect in 3G
sleep 5
/bin/bash /home/pi/cam/ppp-on
sleep 30

#send trought ftp
if [[ $2 = "fulltemp" ]] ; then
	echo "full temperature requested"
	/bin/bash /home/pi/cam/connecftp.sh fulltemp
else
	/bin/bash /home/pi/cam/connecftp.sh
fi
sleep 5

/bin/bash /home/pi/cam/ppp-off