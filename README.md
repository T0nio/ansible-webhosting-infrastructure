# Webhosting infrastructure

The ansible configuration of typical web-hosting infrastructure with some VPS, a dedicated server and a backup server

## Playbooks

- installBackup: it's the playbook to prepare the backup server. It'll set the good SSH configuration, create the rights users and install [Borg](https://github.com/borgbackup/borg). It's designed to work with Debian 9 Stretch.
- installVPS: a typical VPS installation for PHP website hosting (for exaple Wordpress). It's designed to work with Debian 9 Stratch.

## Config files

To be able to use the roles, you'll need to override all the .dist files:
- hosts : it's the inventory. Designed with groups
- group_vars/*.yml: all the groups dependant variables
- host_vars/*.yml: all the hosts dependant variables.

In the .dist files, you'll find example to show you the structure of these files.



## Ressources

We used [geerlingguy's NGINX role](https://github.com/geerlingguy/ansible-role-nginx) as a base for our NGINX role.
