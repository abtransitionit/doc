
# Access Mechanisms (How)

## Custom scripts
In Go, Python, Shell 

Each reimplementing auth, retries, idempotency.

## Command-line tools
`gh`, `glab`, `aws`, `gcloud`, `az`, `ovh`, `terraform`, `kubectl`, `helm`, `ansible`, `rsync`, `scp`, `ssh`, `git`, `docker`, `podman`, `virsh`, `qemu-img`, `openstack`, `cinder`, `glance`, `neutron`.

Each with its own flags, outputs, and exit codes.

## HTTP APIs
- **REST**: AWS, GCP, Azure, OVH, Kubernetes, GitHub, GitLab.
- **GraphQL**: GitHub v4, GitLab GraphQL.
- **gRPC**: containerd, etcd, CRI, CSI.
- **Webhooks / callbacks**: event-driven provisioning.

Each with its own auth, pagination, and error model.

## Native protocols
- SSH, SFTP, SCP, rsync.
- Git (smart HTTP, SSH, git://).
- SMB/CIFS, NFS.
- S3 API (and compatibles), Swift.
- libvirt, QMP, VNC, SPICE.
- Kubernetes API, kubelet, CRI.
- IPMI, Redfish, PXE, iPXE for bare metal.


## SDKs and libraries
- AWS SDK (boto3, aws-sdk-go)
- Google Cloud client libraries
- Azure SDK
- Kubernetes client-go / client-python
- GitHub Octokit
- GitLab python-gitlab
- libvirt bindings
- OpenStack SDK.

## Declarative / IaC tools
- Terraform, OpenTofu, Pulumi
- CloudFormation
- ARM/Bicep
- Ansible, Salt, Puppet, Chef
- Crossplane, Helm, Kustomize
- Jsonnet, Cue.

