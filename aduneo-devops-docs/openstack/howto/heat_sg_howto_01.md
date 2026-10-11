# create sg
lSG_DESC="allow ping and ssh"
lSG_NAME="sg-std"
openstack security group create ${lSG_NAME} \
  --description "${lSG_DESC}" 


# create sg:sgr
lSG_NAME="sg-std"
lSGR_PROTOCOL="icmp"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --protocol ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM}


openstack security group rule create 
  --protocol tcp 
  --dst-port 22:22 
  --remote-ip 0.0.0.0/0 SecurityGroup_Si

lSGR_PROTOCOL="tcp"
lSGR_PORT="22"
openstack security group rule create 
  --protocol ${lSGR_PROTOCOL} \
  --dst-port ${lSGR_PORT} \
  --remote-ip 129.240.12.61 5157 dbad-f96b-4921-b9ba-520b5e2ce995


# create sg:sgr
lSG_NAME="sg-std"
lSGR_PROTOCOL="tcp"
lSGR_PORT="22"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --protocol  ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM} \
  --dst-port  ${lSGR_PORT}

