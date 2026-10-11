# [Terraform][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md

# Define string
## Method
```bash
vm_code = <<-EOF
   #!/bin/bash
   set -e -x 
   apt update -y
   apt upgrade -y
   lIP="github.com"
   lPath="docker/compose/releases/download/1.29.2"
   lRes="docker-compose-Linux-x86_64"
   lUrl="https://${lIP}/${lPath}/${lRes}"
   curl -L ${lUrl} -o /usr/local/bin/docker-compose
   chmod +x /usr/local/bin/docker-compose
EOF
```

## Method
```bash
user_data = file("${path.module}/server-init.sh")
```
