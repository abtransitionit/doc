#!/bin/bash

lCodeFolderPath=${HOME}/debug/git/aduneo/aduneo-docs/openstack/code/code-custom
scp ${lCodeFolderPath}/* opscontroler:/var/tmp
scp ${lCodeFolderPath}/* opscompute:/var/tmp
scp ${lCodeFolderPath}/* opsclient:/var/tmp

ssh opscontroler 'chmod +x /var/tmp/ops.*'
ssh opscompute   'chmod +x /var/tmp/ops.*'
ssh opsclient    'chmod +x /var/tmp/ops.*'


