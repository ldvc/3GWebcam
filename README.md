3GWebcam
========

Outdoor webcam 3G with a raspberry

Prerequesites Camera :

apt-get install wvdial ftp
copy wvdial.conf to /etc/wvdial.conf (or adapt to your 3G provider, change the PIN code, scripts are made to use 100 MB/ month)

fill root crontab (crontab -e) with
0 12 * * * /bin/bash -x /home/pi/cam/pushcam.sh MP4 fulltemp
0 9,16 * * * /bin/bash -x /home/pi/cam/pushcam.sh HD
0 10,11,13,14,15,17,18 * * *  /bin/bash -x /home/pi/cam/pushcam.sh LD
30 12,18 * * * /bin/bash -x /home/pi/cam/maintenance.sh 1500
*/5 * * * * /home/pi/cam/readtemp.pl > /dev/null
0 8 * * 6 /sbin/shutdown -r now



4. edit /etc/modules and load module in this order (to avoid an issue between camera and spi/i2c)
w1-therm
w1-gpio pullup=1
i2c-dev
i2c-bcm2708
spi-bcm2708
snd-bcm2835
