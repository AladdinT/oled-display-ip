#!/bin/bash

echo "$0 is up and running"

# to enable i2c1 
# sudo dtoverlay i2c1

script_path=$(dirname "$(readlink -f "$0")")
saved_ssid="n\a"
saved_ip="n\a"

# while 1 
while true
do
    # check if connected to same saved network 
    if [[ "$saved_ssid" == "$(iwgetid -s)" && "$saved_ip" == "$(hostname -I)" ]]
    then
        sleep 2
    else
    # if new network
        if [ -z "$(hostname -I)" ]
        then
            # No connection
            /bin/python3 "${script_path}/display-text.py" "Not Connected\nto network"
            saved_ssid=$(iwgetid -s)
            saved_ip=$(hostname -I)
        else
            if [ -z "$(iwgetid -s)" ]
            then
            # ethernet connection
                ethernet_ip=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}' )
                /bin/python3 "${script_path}/display-text.py" "eth0\nhostname:\n$(hostname)\n${ethernet_ip}"
                saved_ssid=$(iwgetid -s)
                saved_ip=$(hostname -I)
            else
                # wifi connection
                wifi_ip=$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}' )
                /bin/python3 "${script_path}/display-text.py" "wlan0\nssid:$(iwgetid -s)\n${wifi_ip}"
                saved_ssid=$(iwgetid -s)
                saved_ip=$(hostname -I)
            fi
        fi
    fi
done