# [Maia][Topic_Whatis] > [List][List_List] > Best Practice


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[List_List]:  ../list/list_list.md

# List
- Créer 1 tenant par environnement ?
- Créer 1 bastion par env
- Définir la méthode de déploiement
  - **Blue-Green**: 
    - Déployer la nouvelle release
    - laisser la prod tourner
    - valider la release
    - transférer le tyrafic User de la prod vers la nouvelle release
- Définir les quotas (env qui doivent exister en parallèle)
  - nom des environnement
  - objets dans les environnements



## Le Bastion
- le seul port accéssible : port 22
- port accéssible uniquement pour certaines adresse mac/ip (si c'est possible)
## Les Vm
les [seuls] ports accéssibles:
  - Le port 22 sur le bastion
