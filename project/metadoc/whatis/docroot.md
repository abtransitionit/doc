[//]: #(home)
[home]: ../../../README.md

[//]: #(doc)

[↖][home]

Related topics

| Topic | Location | Kind |
|---|---|---|
|[What is a DocSet](../whatis/docset.md)|internal|concept
|[What is a Domain](../whatis/domain.md)|internal|concept
|[What is a Documentation System](../whatis/doc.ptf.md)|internal|see

<h1 align="center">MetaDoc DocRoot</h1>


- A `DocRoot` is the root folder of a [documentation system](../whatis/doc.ptf.md).
- A `DocRoot` hosts a collection of [Domains](../whatis/domain.md).


# Example 
## Mono documentation system
- A [documentation system][doc ptf whatis] `DocRoot` folder that is a git repository 

```
docIT                 # ← THE DOCROOT        
 |                                      
 ├── Project          # ← DOMAIN        
 │      ├── gotest    # ← DOCSET        
 │      ├── rctl ...
 │      └── DocSet N. # ← DOCSET
 ├── system           # ← DOMAIN
 └── tool             # ← DOMAIN
```
## Multi documentation system
- A [documentation system][doc ptf whatis] with several `DocRoot` folders

```
docIT                 # ← THE DOCROOT      docMath                 # ← THE DOCROOT        
 |                                          |                                     
 ├── Project          # ← DOMAIN            ├── Theory          # ← DOMAIN       
 │      ├── gotest    # ← DOCSET            │      ├── set    # ← DOCSET       
 │      ├── rctl ...                        │      ├── ...                    
 │      └── DocSet N. # ← DOCSET            │      └── language # ← DOCSET    
 ├── system           # ← DOMAIN            ├── system           # ← DOMAIN    
 └── tool             # ← DOMAIN            └── tool             # ← DOMAIN     
```
