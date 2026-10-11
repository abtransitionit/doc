
# Glance > Policy
{
    "publicize_image": "role:admin"
}    

# Container > /var/tmp/varenv.sh

export lCodeFolderPath=/home/mxadmin/debug/git/aduneo/aduneo-docs/openstack/code/code-custom
scp ${lCodeFolderPath}/* opscontroler:/var/tmp
scp ${lCodeFolderPath}/* opscompute:/var/tmp


