# Todo for the deployment of Ansible

## VPS

- [x] Refactor de la recette ansible
- [x] Ajout du role sendmail
- [ ] Tester la recette sur un VPS vide
- [x] Aligner MTV & PAM sur la recette ansible
- [x] Tester la recette sur un VPS utilisé 
- [x] Mettre en place la backup (borg)
- [x] Tester la backup
- [ ] Script de déploiement ? Ou pas pertinent ?
- [ ] Faire un script de restoring
- [x] Ajout de la création d'un user webopaccess + add group + change home
- [ ] Vérifier que ça marche en conditions réelle ! (prochain déploiement)

## Backup 

- [x] Faire un ansible d'install (a minima iptable, changement port SSH)

## Mutualised dedicated

- [ ] Ansible d'installation 
- [ ] Ansible d'ajout d'un site (création du VHost, letsencrypt, folder)
- [ ] Ajout d'un user webop
- [ ] Mise en place de la backup

## Improvments

- [ ] Passer la connexion SSH au backup server en key
- [ ] Mettre en oeuvre un workflow différent pour Wordpress ou HTML