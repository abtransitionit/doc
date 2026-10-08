
# Resource Types (What)

## Files and Objects
- **Local filesystem**: files, directories, symlinks, permissions, ownership.
- **Remote filesystem**: NFS, SMB/CIFS, SSHFS, rsync targets, SFTP.
- **Object storage**: AWS S3, GCS, Azure Blob, MinIO, Ceph RADOS Gateway, Backblaze B2.
- **Content-addressed stores**: Git LFS, IPFS, OCI registries (for blobs).
- **Structured stores**: databases, key-value stores, secrets managers (Vault, AWS Secrets Manager).
- **Concerns**: atomicity, partial writes, large files, streaming, encryption at rest, versioning, eventual consistency, presigned URLs, multipart uploads.

## Virtual Machines
- **Cloud providers**: AWS EC2, GCP Compute, Azure VM, OVH, Hetzner, DigitalOcean, Scaleway.
- **Private virtualization**: VMware vSphere, Proxmox, XCP-ng, Hyper-V, KVM/libvirt.
- **Local virtualization**: QEMU, VirtualBox, Multipass, Lima, Colima.
- **Bare-metal provisioning**: MAAS, Tinkerbell, iPXE, Foreman.
- **Edge/embedded**: Raspberry Pi, ESP32, IoT fleets.
- **Concerns**: images/AMIs, flavors/sizes, networking (VPC, security groups, floating IPs), storage volumes, cloud-init/user-data, SSH key injection, lifecycle (start/stop/reboot/terminate), pricing models, quotas, spot vs. on-demand.

## Clusters
- **Kubernetes on VMs**: kubeadm, k3s, RKE2, Talos, Kubespray.
- **Kubernetes in containers**: kind, k3d, minikube (docker driver), Podman-based.
- **Managed Kubernetes**: EKS, GKE, AKS, OVH Managed K8s, DigitalOcean DOKS.
- **OpenStack**: DevStack, Kolla-Ansible, OpenStack on bare metal, TripleO.
- **Other orchestrators**: Nomad, Docker Swarm, HashiCorp Consul clusters.
- **Data/ML clusters**: Spark, Ray, Hadoop, Slurm, Dask.
- **Concerns**: bootstrap, join tokens, CNI, CSI, ingress, RBAC, upgrades, node pools, autoscaling, multi-tenancy, federation.

## Git Repositories
- **Hosting platforms**: GitHub, GitLab, Bitbucket, Gitea, Forgejo, Codeberg.
- **Self-hosted**: bare Git over SSH, Gitolite, GitLab CE, Gitea.
- **Local**: working trees, bare repos, worktrees, submodules.
- **Operations**:
  - Create/delete repository.
  - Initialize from template (GitHub template repos, Cookiecutter, Copier).
  - Mirror / fork / import.
  - Reset history (orphan branch, squash, `git filter-repo`).
  - Branch/tag management, protection rules.
  - Webhooks, deploy keys, collaborators, teams.
  - CI/CD wiring (Actions, Pipelines, Runners).
  - Submodules, LFS, sparse checkout.
- **Concerns**: authentication (SSH keys, PATs, OAuth apps, GitHub Apps), rate limits, pagination, idempotency of "create if not exists," atomic multi-repo operations.

