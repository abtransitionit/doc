[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[Company nubo whatis]: https://www.nubo.fr/
[openstack whatis]: /concept/cluster/whatis/openstack.md

Related topics

| Topic | Location | Kind    |
| - | - | - |
|[What is The Company Nubo][Company nubo whatis]|external| 

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is Nubo</h1>


# Definition
- A sovereign cloud infrastructure
- Built specifically for French government ministries by **DGFiP** (**D**irection **g**énérale des **fi**nances **p**ubliques)
- Based on [Openstack][openstack whatis]
- Approximately **13,500 VMs** and **440 application** projects (as of mid-2024)
- Deployed across **2 sites in Île-de-France**, each with 2 independent regions
    - **internal** (aka. **RIE**), the inter-ministerial network
    - **public**, the Internet


# Nubo Instances

|Name|Geographic localization |Tag|Description|
|-|-|-|-|
|nubo11|1|RIE| internal on region 1
|nubo11|1|public| public  on region 1
|nubo21|2|RIE| internal on region 2
|nub22|2|public| public  on region 2

The Nubo cloud is deployed accross 2 **regions** dedicated to either
- **RIE exposure** (internet)
- **Internet exposure** (public)




# Other "Nubo" Projects (Less Likely)

For completeness, there are also unrelated projects named Nubo:
- **Nubo (PyPI package)**: A Python tool for deploying Linux VMs on multiple cloud providers (last release ~11 years ago).
- **Nubo (Blockchain marketplace)**: An academic virtual services marketplace using Quorum blockchain.
- **NUBOMEDIA**: An elastic PaaS for real-time multimedia (different spelling, "Nubo**media**").

Given the French government context in your table, the **inter-ministerial cloud** interpretation is the correct one.


# Also
- there is a IT company named [Nubo][Company nubo whatis]


# Documentation and References

1. **Official Government Page** (French):  
   [Le Cloud interministériel - numerique.gouv.fr](https://www.numerique.gouv.fr/offre-accompagnement/cloud-administrations/le-cloud-interne/)  
   This is the primary official description of the Nubo and Pi clouds, their technical characteristics, service catalog, and support model.

2. **FOSDEM 2025 Talk**:  
   ["Nubo: the French government sovereign cloud"](https://archive.fosdem.org/2025/schedule/event/fosdem-2025-6234-nubo-the-french-government-sovereign-cloud/)  
   A conference presentation by DGFiP and OpenStack representatives explaining why they chose open-source infrastructure.

3. **Court of Accounts Report** (French PDF):  
   ["Enjeux de souveraineté des SI civils de l'État"](https://www.ccomptes.fr/sites/default/files/2025-10/20251031-S2025-1479-Enjeux-souverainete-des-SI-civils-de-l-Etat.pdf)  
   Provides detailed analysis of Nubo's costs, usage, and governance challenges.

4. **GitHub API Documentation** (different "Nubo" project):  
   [sirini/nubo API_CONTRACT_V1.md](https://github.com/sirini/nubo/blob/main/docs/API_CONTRACT_V1.md)  
   ⚠️ **Note**: This appears to be an unrelated project (likely a personal/small-scale application) with its own API contract. It is **not** the French government cloud.



# Todo


# Par ou commencer
- Installer govc 

# Todo for app
- Bastion
- Test Auto
- HD
- PRA
- PCA
- Tooling
  - supervision
  - monitoring
  - backup
    - retention
    - externalisation
- Db
  - prefer NoSql
- Tool
  - Heat
  - Terraform
  - Ansible
  