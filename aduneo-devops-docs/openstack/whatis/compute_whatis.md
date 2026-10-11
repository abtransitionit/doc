# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Compute


[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Whatis_List]:    ../list/whatis_list.md
[Component_List]: ../list/component_list.md
[Image_Whatis]:   ../whatis/image_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[List][Component_List]
|Image|[Whatis][Image_Whatis]
<br>

# Definition
Compute est
  - 1 composant OpenStack

Compute interact with other component via Keystone
- keystone
- Placement
- Image
- Dashboard

# Component
- nova-api
- nova-api-metadata
- nova-compute
- nova-scheduler
- nova-conductor
- nova-novncproxy
- queue
- db

# Toknow
- A number of periodic processes run on the OpenStack Image service to support caching.
- When 1 request hits the Nova API (for a particular instance)
  - instance:info is fetched from the database
  - which contains
    - host@compute:hostname
    - ListVm on that host@compute
- Whan 1 cell is created => no hosts are bind to it
- Scheduler will never place instances there. 
- Scan database for compute node records and add them into the cell
- start compute node started such that it registers itself as a running service. 
- Scan and add it to the cell


This command will connect to any databases for which you have created cells (as above), look for hosts that have registered themselves there, and map those hosts in the API database so that they are visible to the scheduler as available targets for instances. Any time you add more compute hosts to a cell, you need to re-run this command to map them from the top-level so they can be utilized.  