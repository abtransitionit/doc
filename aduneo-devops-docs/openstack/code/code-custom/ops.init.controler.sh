#!/bin/bash
# File:Name:ops.init.controler.sh
# File:Role:wrap process of install

lFolderCurrent="$(dirname $BASH_SOURCE)"

source ${lFolderCurrent}/ops.ve.common.sh
source ${lFolderCurrent}/ops.ve.controler.sh
${lFolderCurrent}/ops.common.sh
${lFolderCurrent}/ops.controler.sh
