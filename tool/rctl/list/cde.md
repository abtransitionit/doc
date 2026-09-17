[//]: #(home)
[home]: ../../README.md

[//]: #(doc)

[↖][home]

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">list of cdes</h1>


# rctl CLI Reference

## Global Flags

| Flag | Short | Default | Description |
| :--- | :---: | :--- | :--- |
| `--config` | `-c` | `~/.rctl/inventory.yaml` | Path to inventory configuration file |
| `--json` | `-j` | `false` | Output structured JSON stream |
| `--verbose` | `-v` | `false` | Enable debug logging to stderr |

---

## Exit Codes

| Exit Code | Meaning | Action / Resolution |
| :---: | :--- | :--- |
| **0** | Success | All target commands executed successfully |
| **1** | Command Failure | One or more remote processes returned a non-zero exit code |
| **2** | Invalid CLI Args | Check syntax, required flags, or mutually exclusive options |
| **3** | Config Error | Validate syntax and schema of `inventory.yaml` |
| **4** | Transport Error | Verify network connectivity, SSH keys, or target host state |