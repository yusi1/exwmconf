#!/bin/bash

nmcli connection down wg0
notify-send "Stopping Wireguard client..."
sudo wg
