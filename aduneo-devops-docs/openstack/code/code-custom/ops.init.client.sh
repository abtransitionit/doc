#!/bin/bash
# File:Name:ops.init.client.sh
# File:Role:wrap process of install

lFolderCurrent="$(dirname $BASH_SOURCE)"

source ${lFolderCurrent}/ops.ve.common.sh
source ${lFolderCurrent}/ops.ve.controler.sh
source ${lFolderCurrent}/ops.ve.client.sh
${lFolderCurrent}/ops.common.sh
${lFolderCurrent}/ops.client.sh
