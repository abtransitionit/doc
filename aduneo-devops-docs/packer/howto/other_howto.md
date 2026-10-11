# [Packer][Topic_Whatis] > [Howto][Howto_List] > Var


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Howto_List]:       ../list/howto_list.md
[Var_Whatis]:       ../whatis/var_whatis.md


See Also:

|Nom|Tag|Description|
|-|-|-|
|Var|[whatis][Var_whatis]
<br>


# Allow image@(docker, final) to play .bashrc
```bash
source "docker" "ubuntu" {
  image   = "${var.image_custom_docker_repo_path}/${var.image_docker_in_name}:${var.image_docker_in_tag}"
  pull    = false
  commit  = true
  changes = [
    "CMD [\"-c\", \"/bin/bash\"]"
  ]
}

```