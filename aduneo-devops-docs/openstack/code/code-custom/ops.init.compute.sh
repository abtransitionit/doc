#!/bin/bash
# File:Name:ops.init.compute.sh
# File:Role:wrap process of install

lFolderCurrent="$(dirname $BASH_SOURCE)"

source ${lFolderCurrent}/ops.ve.common.sh
source ${lFolderCurrent}/ops.ve.compute.sh
${lFolderCurrent}/ops.common.sh
${lFolderCurrent}/ops.compute.sh
