#!/usr/bin/env bash

# ask () {
#     read -p "Do you wish to add this email account to the password store? " yn
#     case $yn in
#         [Yy]* ) echo "Adding ($plainemail) to the password store..." ;
# 		pass add $plainemail ; break;;
#         [Nn]* ) exit;;
#         * ) echo "Please answer yes or no.";;
#     esac
# }

email="$@"
domain=$(echo $email | cut -d@ -f2 | sed 's/[^.]*$//g;s/\.//g')
plainemail="Email/${domain^}/$email"
pass=$(pass show $plainemail | head -n1)

[ ${pass} ] && echo "${pass}"
