# [Terraform][Topic_Whatis] > [Whatis][Whatis_List] > Variable


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Variable_Howto]:   ../howto/variable_howto.md
[Module_Whatis]:    ../whatis/module_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Variable|[How-to][Variable_Howto]
|Module|[Whatis][Module_Whatis]
<br>

# Type
- Input
- Output

# Type
- Primitive
  - bool
  - number
  - string
- complex
  - set
  - map
  - tuple
  - object
  - list
  

# Variable@Input
- Est 1 variable qui est disponible en entrée à un module
- doit **obligatoirement** être déclarée dans un fichier .tf
# Variable@Output
- Est 1 variable qui est provided en sortie par un module

# A savoir
les variables peuvent être transmisent via
- des fichier .tf
- des fichier .tfvars (qui ovveride les vars dans les .tf)
- des variable d'environnement
  - de type TF_VA_XXX
  - spécifique à Terraform (i.e XXX)
- la Cli