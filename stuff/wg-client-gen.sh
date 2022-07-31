#!/bin/bash

# =================Function to print help
printhelp () {
	echo "Usage: $script [OPTION...]"
	echo "  -r    remove temporary files created by the script"
	echo "  -c    copy publickey and presharedkey to current dir"
	echo "  -g    remove previously generated config files in current dir"
	echo "  -h    print help"
	exit 0
	}

# =================Arguments to the script
script="${0}"
args="${@:1}"

# check for the help argument and print help
case $args in
    *"-h"* )
	printhelp	
	;;
    *"-g"* )
	generatedfiles=("./client.conf"
			"./wireguard-client-config.png")

	for i in ${generatedfiles[@]}; do
	    [ -f "$i" ] &&
		rm "./$i"
	done
	;;
    * )
	printhelp
	rtemp
	;;
esac

# don't return anything about the script running with arguments
# if there is no arguments passed to the script.
[ -z "$args" ] || echo "Running script with arguments: $args"

# =================Temporary files that will be created
#                  by this script.
files=("/tmp/a"  # where the privatekey will be temporarily stored
       "/tmp/b"  # where the publickey will be temporarily stored
       "/tmp/c") # where the presharedkey will be temporarily stored

# ================Function to remove temporary files created by this script.
rtemp () {
    for i in ${files[@]}; do
	if [ ! "$args" == *"k"* ]; then
	    [ -f "$i" ] && shred -n 200 -u "$i"
	fi
    done
}

# ===============Function to keep certain files.
keep () {
	cp "${files[1]}" ./publickey
	cp "${files[2]}" ./presharedkey
	[ -f "$i" ] && shred -n 200 -u "$i"
}

# ===============Set permissions for files that are to
#                be created by this script.
umask 077

# ===============Client config ([Interface] section in client config file)
read -p "Wireguard client IP (e.g 10.10.0.2/32): " address
privatekey=$(wg genkey > ${files[0]} && cat ${files[0]})
publickey=$(wg pubkey < ${files[0]} > ${files[1]} && cat ${files[1]})
read -p "DNS for client (DEFAULT 1.1.1.1): " dns

# determine if subnet mask was provided from user input
# and if not, use <ip_address>/32
[[ "$address" =~ /[0-9][0-9]$ ]] && address="$address" || address="$address/32" 

# if no DNS was supplied use 1.1.1.1 
[ -z "$dns" ] && dns="1.1.1.1"

# ===============Client config ([Peer] section in client config file for server)
read -p "Server public IP address and port (e.g 12.14.25.45:51820): " endpoint
allowedips="0.0.0.0/0"
presharedkey=$(wg genpsk > ${files[2]} && cat ${files[2]})
read -p "Are you behind NAT (e.g home connection) (y/n) (DEFAULT:y): " mtu
read -p "Public key of server: " srvpublickey

case $mtu in
    [yY]* )
        mtu="1380"
	keepalive="21"
	;;
    [nN]* )
	mtu="1500"
	keepalive="0"
	;;
    * )
	mtu="1380"
	keepalive="21"
	;;
esac

# if no port was specified for server address use default port 51820
[[ "$endpoint" =~ :[0-9]?*$ ]] && endpoint="$endpoint" || endpoint="$endpoint:51820"

# ===============Client config file "generation" using created variables
cat << __EOF >> client.conf
[Interface]
Address = $address
PrivateKey = $privatekey
MTU = $mtu
DNS = $dns

[Peer]
PublicKey = $srvpublickey
PresharedKey = $presharedkey
AllowedIPs = $allowedips
Endpoint = $endpoint
PersistentKeepAlive = $keepalive
__EOF

# ===============Generate qrcode from client config for use
#                with wireguard app on phones for example.
qrencode -t png -o wireguard-client-config.png < client.conf

# ===============remove temporary files
if [[ "$args" == *"c"* ]]; then
	keep
fi

[[ "$args" == *"r"* ]] && rtemp || echo "Not removing temporary files, remove these files manually: ${files[@]}"
