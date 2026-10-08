[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md
[k8s whatis]:      ../whatis/kubernetes.md
[openstack whatis]: ../whatis/openstack.md
Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Host][host whatis]|

<h1 align="center">What is a Cluster</h1>

The concept of Cluster

# Definition
- Set of [hosts][host whatis] (aka. **Nodes**)

# Kind
- **Container cluster**: each node is a container
- **VM cluster**: each node is a VM
- **Bare-Metal Cluster**: each node is a Bare-Metal
- **Heteregeneous Cluster**: each node is in (Container, VM, Bare-Metal) 


# Example 
- [Kubernetes Cluster][k8s whatis]
- [OpenStack Cluster][openstack whatis]