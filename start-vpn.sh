#!/bin/bash

nmcli connection up wg0
notify-send "Starting Wireguard Client..."
sudo wg
