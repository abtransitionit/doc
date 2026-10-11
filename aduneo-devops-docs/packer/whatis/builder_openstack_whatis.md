# [Packer][Topic_Whatis] > [Whatis][Whatis_List] > Builder > Openstack


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Template_Howto]:     ../howto/template_howto.md
[Gophercloud_Whatis]:     openstack:projecthttps://github.com/gophercloud/gophercloud

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Template|[How-to][Template_Howto]
<br>

# Definition

- Start 1 machine from 1 image@(source, openstack)
- Provision the machine (aka openstack:server)
- Save the machine back to 1 image@openstack
- Uses Api:[gophercloud][Gophercloud_Whatis] to communicate with openstack:server

# Process

|Step|Description|
|-|-|
|Authentication|The user is authenticated and scoped to a project in their domain.
|Extension Check|The builder checks what extensions are available.
|Flavor Check|Checks if the flavor id for the server actually exists.
|Keypair Creation|Creates a temporary keypair for SSH communication.
|Launch Server|Starts a server with the supplied image id and flavor with the security groups listed in the template.
|Allocate IP|Attempts to release an IP from the pool and set the ower to your project. Then the server is given this public IP. (There are other options for IP allocation as well)
|Wait for SSH|Keep trying to ssh to the server. It might not be done booting. This is the most common step to fail initially becuse of too strict security groups or wrong ip pool name. (You could also provision in the local network, so public IPs are structly not needed. Then this step will be skipped)
|Run Provisioners|Run whatever provisioner(s) you have configured. The possibilities here are endless. This step will wait until provisioning is completed before it continues.
|Stop Server|The server is stopped so we safely create an image.
|Create Image|An image creation is queued. We wait for it to complete.
|Delete Server|The server is deleted.
|Delete Keypair|The temporary keypair is deleted.
|Post-Processor|Run post-processors on the final image (optional)


# Toknow
- Packer builds Docker containers without the use of Dockerfiles. 
