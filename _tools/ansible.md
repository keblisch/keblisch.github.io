---
layout: base
title: Ansible
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Ansible
{: .no_toc }

Ansible is an automation tool to deploy IT systems via declarative configurations.

| Usage | Implementation | License         | Current Version |
| :---- | :------------- | :-------------- | :-------------- |
| CLI   | Python         | GPL-3.0 license | 2.21.4          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Ansible documentation:
  [Ansible Documentation](https://docs.ansible.com/projects/ansible/latest/index.html>)
- Official Ansible repository: [ansible/ansible](https://github.com/ansible/ansible)

## 2 Configuration

- Ansible can be configured with dedicated environment variables and configuration files
- Ansible configurations are evaluated from the following sources in that precedence order:
  1. Environment variable
  2. `$ANSIBLE_CONFIG` file
  3. `./ansible.cfg` file
  4. `~/.ansible.cfg`
  5. `/etc/ansible/ansible.cfg` file

Ansible configurations can be managed with the following commands:

```bash
# list every config option and its default
ansible-config list

# show which config file is currently active
ansible-config view

# list every config option and its current value with its origin
ansible-config dump
```

The following configurations can be set in Ansible configuration files:

```conf
[defaults]
inventory = /etc/ansible/hosts   # host list
log_path = /var/og/ansible.log   # logs location
roles_path = /etc/ansible/roles  # roles location
gathering = implicit             # gather facts
timeout = 10                     # SSH timeout
forks = 5                        # hosts at once
```

The following configurations can be set with environment variables:

```bash
ANSIBLE_INVENTORY='/etc/ansible/hosts'   # host list
ANSIBLE_LOG_PATH='/var/og/ansible.log'   # logs location
ANSIBLE_ROLES_PATH='/etc/ansible/roles'  # roles location
ANSIBLE_GATHERING='implicit'             # gather facts
ANSIBLE_TIMEOUT=10                       # SSH timeout
ANSIBLE_FORKS=5                          # hosts at once
```
