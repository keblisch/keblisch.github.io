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

- Official Ansible repository: [ansible/ansible](https://github.com/ansible/ansible)
- Official Ansible documentation:
  [Ansible Documentation](https://docs.ansible.com/projects/ansible/latest/index.html>)

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

```ini
[defaults]
inventory  = /etc/ansible/hosts   # host list
log_path   = /var/og/ansible.log  # logs location
roles_path = /etc/ansible/roles   # roles location
gathering  = implicit             # gather facts
timeout    = 10                   # SSH timeout
forks      = 5                    # hosts at once
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

## 3 Inventories

- Ansible can manage any number of hosts at once via remote connections
  - Thereby no agent needs to be installed on target hosts
- Hosts are defined in inventory files
  - These can be in INI or YAML format
  - Thereby `/etc/ansible/hosts`/`/etc/ansible/hosts.yml` is used per default
  - Thereby Ansible can be pointed to a custom file

Inventory files in INI format can be defined as follows:

```ini
# define hosts via their domain name or IP address
server1.company.com
server2.company.com

# alias host definitions
my_alias       ansible_host=server3.company.com
my_other_alias ansible_host=server4.company.com

# define connections to use for hosts
server5.company.com ansible_connection=ssh        # SSH (default for Linux)
server6.company.com ansible_connection=winrm      # PowerShell Remoting (default for Windows)
server7.company.com ansible_connection=localhost  # locally on current machine

# define ports to use for connections
server8.company.com ansible_connection=ssh ansible_port=22  # default for SSH

# define users to use for hosts
server9.company.com ansible_user=root            # default for Linux
server10.company.com ansible_user=administrator  # default for Windows

# define passwords for users
server11.company.com ansible_user=root ansible_password=qwerty

# group host definitions
[my_group]
server5.company.com  # group new host definition
server1.company.com  # group existing host definition
my_alias             # group existing host definition by its alias

# group other groups
[my_parent_group:children]
my_group
```

Inventory files in YAML format can be defined as follows:

```yaml
# root
all:

  # define hosts via their domain name or IP address
  hosts:
    server1.company.com:
    server2.company.com:

    # alias host definitions
    my_alias:
      ansible_host: server3.company.com
    my_other_alias:
      ansible_host: server4.company.com

    # define connections to use for hosts
    server5.company.com:
      ansible_connection: ssh        # SSH (default for Linux)
    server6.company.com:
      ansible_connection: winrm      # PowerShell Remoting (default for Windows)
    server7.company.com:
      ansible_connection: localhost  # locally on current machine

    # define ports to use for connections
    server8.company.com:
      ansible_connection: ssh
      ansible_port: 22  # default for SSH

    # define users to use for hosts
    server9.company.com:
      ansible_user: root            # default for Linux
    server10.company.com:
      ansible_user: administrator   # default for Windows

    # define passwords for users
    server11.company.com:
      ansible_user: root
      ansible_password: qwerty

  # group host definitions
  children:
    my_group:
      hosts:
        server5.company.com:  # group new host definition
        server1.company.com:  # group existing host definition
        my_alias:             # group existing host definition by its alias

    # group other groups
    my_parent_group:
      children:
        my_child_group:
          hosts:
            server12.company.com:
        my_other_child_group:
          hosts:
            server13.company.com:
```

- <u>Best practices</u>:
  - Store passwords in Ansible Vault instead of using them in plain text
  - Prefer passwordless SSH key authentication above SSH password authentication
