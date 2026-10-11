# _env

Ce projet git documente les étapes pour créer 1 environnement de test au sein de Aduneo:datacenter@vmware

[//]: #(Reference)
[Step_List]: list/step_list.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Les étapes|[list][Step_List]|
<br>

# 1 environnement > C'est quoi


Exemple de nom d'environnement:
  - **dev**elopement
  - **qual**ification
  - **iso**production
  - **prod**uction

1 environnement est
  - une infrastructure (serveurs et services) isolée. 
  - en général, destiné à l'usage d'une typologie de user
    - environnement de **dev** pour les développeurs
    - environnement de **qualif** pour les recetteur
    - environnement de **production** pour les utilisateurs finaux


# A savoir
Le nombre et le nom des environnements peut aller de 2 à plus de 50 selon les besoins (serveurs, services, infra, user)