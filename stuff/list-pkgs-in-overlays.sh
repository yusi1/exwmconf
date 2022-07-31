#!/bin/bash

#for i in $(eselect repository list | grep "*" | awk '{print $2}'); do echo -e "\n=== $i overlay ===\n"; eix --installed-in-overlay $i; done
for i in $(eselect repository list | grep "*" | awk '{print $2}'); do echo -e "\n=== $i overlay ===\n"; eix --installed-in-overlay $i | grep -A 2 "Found"; echo -e "\n"; done
