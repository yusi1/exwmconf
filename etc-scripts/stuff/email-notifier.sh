msg=$(getmail --rcfile personal -v | grep "[1-9] messages*" | awk '{print "Email: " $1 " messages recieved"}')

if [[ ! -z "${msg}" ]]; then
    notify-send -t 10000 "${msg}"
fi
