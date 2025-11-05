# Azure Infrastructure Management with Terraform

A modular Terraform project for managing Azure infrastructure, including virtual machines, networking, user management, and RBAC configurations.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Modules](#modules)

## Overview

This project provides a comprehensive set of Terraform modules for managing Azure cloud infrastructure with a focus on:

- **Compute Resources**: Linux virtual machines with automated SSH key and password generation
- **Networking**: Virtual networks, subnets, public IPs, NSGs, and network interfaces
- **Identity Management**: Azure AD users and groups with CSV-based provisioning
- **Access Control**: Role-based access control (RBAC) management
- **Configuration Management**: Ansible playbook integration for VM configuration

## Project Structure

```
.
├── ansible/                    # Ansible playbook execution module
├── compute/                    # Virtual machine management
├── management/
│   ├── groups-management/      # Azure AD group management
│   ├── rbac/                   # Role-based access control
│   └── users-management/       # Azure AD user provisioning
├── network/                    # Network infrastructure
└── resource-group/             # Resource group management
```

## Modules

### Resource Group Module (`resource-group/`)

Creates and manages Azure resource groups with validation and tagging support.

### Network Module (`network/`)

Manages complete networking infrastructure including VNets, subnets, public IPs, NSGs, and NICs.

### Compute Module (`compute/`)

Deploys and manages Linux virtual machines with automated credential generation.

### User Management Module (`management/users-management/`)

Provisions Azure AD users from CSV files with automatic email generation.

### Group Management Module (`management/groups-management/`)

Creates and manages Azure AD security groups based on departments.

### RBAC Module (`management/rbac/`)

Manages Azure role assignments for teams and environments.

### Ansible Module (`ansible/`)

Executes Ansible playbooks against Azure VMs with flexible configuration.

