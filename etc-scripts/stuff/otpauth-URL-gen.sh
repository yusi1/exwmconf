#!/usr/bin/env bash
 
read -p "Enter OTP Provider name: " OTP_PROVIDER
read -p "Enter OTP Token: " OTP_TOKEN

URI="otpauth://totp/$OTP_PROVIDER?secret=$OTP_TOKEN&issuer=$OTP_PROVIDER"

echo $URI
[ $(which termux-clipboard-set) ] && termux-clipboard-set $URI
[ $(which xclip) ] && [ $XDG_SESSION_TYPE == "x11" ] && xclip -selection c $URI
