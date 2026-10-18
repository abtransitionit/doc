[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Repository][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]: /concept/resource/whatis/ep.md
[ope whatis]: /concept/resource/whatis/operation.md
[container whatis]: /concept/image/whatis/container.md
[registry container list]: /concept/image/list/registry.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Resource][res whatis]|
|[What is an Operation][ope whatis]|
|[What is a Container][container whatis]|

<h1 align="center">List of Well known Repositories</h1>

The concept of Repository

# List
List of well-known repositories.

| Repository | Kind | Type | Link |
| :--- | :--- | :--- | :--- |
| GitHub | git | Git hosting / code collaboration | [https://github.com](https://github.com) |
| GitLab | git | Git hosting / DevOps platform | [https://gitlab.com](https://gitlab.com) |
| Bitbucket | git | Git hosting / Atlassian ecosystem | [https://bitbucket.org](https://bitbucket.org) |
| Azure DevOps | git | Git hosting / Microsoft ecosystem | [https://dev.azure.com](https://dev.azure.com) |
| Gitea | git | Self-hosted Git service | [https://gitea.com](https://gitea.com) |
| Codeberg | git | Non-profit Git hosting | [https://codeberg.org](https://codeberg.org) |
| Docker Hub | container | Container image registry | [https://hub.docker.com](https://hub.docker.com) |
| GitHub Container Registry | container | Container image registry | [https://ghcr.io](https://ghcr.io) |
| Quay | container | Container image registry | [https://quay.io](https://quay.io) |
| Harbor | container | Self-hosted container registry | [https://goharbor.io](https://goharbor.io) |
| npm Registry | package | JavaScript package registry | [https://npmjs.com](https://npmjs.com) |
| PyPI | package | Python package index | [https://pypi.org](https://pypi.org) |
| Maven Central | package | Java artifact repository | [https://central.sonatype.org](https://central.sonatype.org) |
| crates.io | package | Rust package registry | [https://crates.io](https://crates.io) |
| RubyGems | package | Ruby package registry | [https://rubygems.org](https://rubygems.org) |
| Packagist | package | PHP package repository | [https://packagist.org](https://packagist.org) |
| NuGet | package | .NET package registry | [https://nuget.org](https://nuget.org) |
| APT Repository | package | Debian/Ubuntu packages managed by APT | [https://wiki.debian.org/DebianRepository](https://wiki.debian.org/DebianRepository) |
| RPM Repository | package | Red Hat/Fedora packages managed by YUM/DNF | [https://docs.fedoraproject.org/en-US/quick-docs/repositories/](https://docs.fedoraproject.org/en-US/quick-docs/repositories/) |
| Terraform Registry | module | Terraform module/provider registry | [https://registry.terraform.io](https://registry.terraform.io) |
| Artifact Hub | chart | Helm charts / cloud-native packages | [https://artifacthub.io](https://artifacthub.io) |
| Software Heritage | archive | Source code archive | [https://archive.softwareheritage.org](https://archive.softwareheritage.org) |
| Repository | Kind | Type | Link |
# List

| Context | Definition | Key Characteristics | Example Platforms / Tools | Repository Link |
| :--- | :--- | :--- | :--- | :--- |
| **Version Control (Git)** | A central location storing all files, folders, and the complete revision history of a project. | Tracks changes at the file level; enables branching, merging, cloning, and collaboration via commits. | GitHub, GitLab, Subversion (SVN) | [GitHub Repositories](https://docs.github.com/en/repositories) |
| **Version Control (GitLab)** | A Git-based repository hosted on GitLab with built-in CI/CD, merge requests, and issue tracking. | Supports branching, merging, protected branches, and integrates with GitLab pipelines. | GitLab | [GitLab Repositories](https://docs.gitlab.com/user/project/repository/) |
| **Container Image (Docker Hub)** | A collection of related container images grouped under a single name, differentiated by tags (e.g., `latest`, `v1`). | Stores read-only templates for containers; images identified by name + tag or digest; public or private. | Docker Hub | [Docker Hub Repositories](https://docs.docker.com/docker-hub/repos/) |
| **Container Image (GitLab Registry)** | A GitLab-integrated registry for storing and managing Docker/OCI container images. | Tightly integrated with GitLab CI/CD; supports tagging, cleanup policies, and access control. | GitLab Container Registry | [GitLab Container Registry](https://docs.gitlab.com/user/packages/container_registry/) |
| **Container Image (Azure ACR)** | A managed, private Docker registry service on Azure for storing and managing container images. | Supports geo-replication, webhooks, ACR Tasks, and integration with AKS and Azure Pipelines. | Azure Container Registry (ACR) | [Azure Container Registry Concepts](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-concepts) |
| **Container Image (Oracle OCI Registry)** | Oracle Cloud Infrastructure's managed container registry for storing and sharing container images. | Supports public and private repos, image scanning, and integration with OKE and OCI DevOps. | Oracle Cloud Infrastructure Registry (OCIR) | [Oracle Cloud Container Registry](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryconcepts.htm) |
| **Artifact Registry** | A named collection of software packages or artifacts in a specific format (e.g., Maven, npm, Docker). | Groups different versions of the same artifact; supports hosted, remote (proxy), or virtual repository types. | GitLab Artifact Registry, Google Artifact Registry | [GitLab Artifact Registry](https://docs.gitlab.com/user/packages/) |
| **Package Registry (npm)** | A repository for JavaScript packages managed by npm or compatible registries. | Stores versioned packages; supports scoped packages, dist-tags, and private registries. | npm, Verdaccio, GitHub Packages | [npm Registry](https://docs.npmjs.com/about-the-public-npm-registry) |
| **Package Registry (Maven)** | A repository for Java artifacts (JARs, POMs) used by Maven or Gradle builds. | Organizes artifacts by groupId/artifactId/version; supports snapshots and releases. | Maven Central, Nexus, Artifactory | [Maven Central](https://central.sonatype.org/) |
| **Package Registry (PyPI)** | The Python Package Index, a repository for Python packages installable via pip. | Hosts wheels and source distributions; supports versioning and metadata. | PyPI, devpi, GitHub Packages | [PyPI](https://pypi.org/) |
| **Infrastructure as Code (Terraform)** | A repository of reusable Terraform modules published for public or private use. | Versioned modules; supports providers, inputs, outputs, and semantic versioning. | Terraform Registry, GitLab Terraform Registry | [Terraform Registry](https://registry.terraform.io/) |
| **Helm Charts** | A repository hosting packaged Kubernetes applications as Helm charts. | Versioned charts; supports dependencies, values override, and OCI-based distribution. | Artifact Hub, ChartMuseum | [Artifact Hub](https://artifacthub.io/) |
| **APT Repository** | A repository for Debian/Ubuntu packages managed by APT. | Hosts `.deb` packages with signed metadata; supports distributions and components. | Debian, Ubuntu, Launchpad PPA | [Debian Repository](https://wiki.debian.org/DebianRepository) |
| **RPM Repository** | A repository for Red Hat/Fedora packages managed by YUM/DNF. | Hosts `.rpm` packages with repodata metadata; supports GPG signing. | Fedora, EPEL, RPM Fusion | [Fedora Repository](https://docs.fedoraproject.org/en-US/quick-docs/repositories/) |


