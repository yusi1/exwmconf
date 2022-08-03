#!/bin/bash

NEXTCLOUD_PASS=$(pass show use05.thegood.cloud/YUZi54780@outlook.com)

nextcloudcmd -u YUZi54780@outlook.com -p ${NEXTCLOUD_PASS} ~/Nextcloud https://use05.thegood.cloud
