# [Ansible][Topic_Whatis] > [Howto][Howto_List] > Manage > Variable


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Variable_Whatis]:  ../whatis/variable_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Variable|[Whatis][Variable_Whatis]
<br>

# Définir une variable
```bash
# Declaration@Generic
variable 'variable_name' {
    Type:        ...
    Default:     ...
    Description: ...
    Validation:  ...
    Sensitive:   ...
}
```
- Type can be: string, number, bool, list, set, map, tuple, object
- Sensitive allow to hide value

## Exemple
```bash
# Declare 1 var named "content" with no default value. 
## Any value will be accept (i.e: string, list, object, Json, ...)
variable "content" {
}

variable "MyVar" { 
  type      = string
  default   = "Hello world" 
}

variable "MyVar" { 
  type      = number
  default   = 2931237
}

variable "MyVar" { 
  type      = bool
  default   = true
}
# col of item of same type (default = string)
variable "MyVar" { 
  type      = list
  default   = ["red", "blue", "red"]
  sensitive = true
}

# col of item of same type
variable "MyVar" { 
  type      = list(number)
  default   = [1, 3, 55, 1, 3]}

# col of item of same type (default = string) and duplicate not allowed
variable "MyVar" { 
  type      = set
  default   = ["red", "blue", "red"]
}

# col of item of same type and duplicate not allowed
variable "MyVar" { 
  type      = set(bool)
  default   = ["true", "false", "false"]
}

# col of kvpair
variable "MyVar" { 
  type      = map
  default   = { 
    color   = "red" 
    hex     = "#FF0000"
  }
}

# col of item of diffrent type
variable "MyVar" { 
  type      = tuple([string, bool, number])
  default   = ["Hello world", True, 4862]
}

# col of kvpair and value is typed
variable "MyVar" { 
  type      = object({ 
    name    = string 
    color   = string 
    age     = number 
    friends = list(string)
  })
  default = { 
    name = "Hello world" 
    color = "Red" 
    age = 54 
    friends = ["Jhon", "Ashley", "Ivan"]
  }
}

```
# Fournir une variable à 1 provider
```bash
# Method
resource "local_file" "message" {
  filename = var.filename 
  content  = var.content
}
# Method
resource "local_file" "message" {
  filename = ${var.filename} 
  content  = ${var.content}
}
```