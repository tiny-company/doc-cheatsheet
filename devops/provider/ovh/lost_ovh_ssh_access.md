# Lost ovh ssh access

## Description

En cas de perte des acces ssh (port close) (ATTENTION, LA CONSOLE VNC EST EN QWERTY):

- Passer en rescue mode :
    - Aller sur le dashboard de l'instance et Redemarrer en mode rescue
    - Apres quelques instants, allez sur la console VNC, elle vous indiquera un mot de passe temporaire pour un acces root
    - Se connecter en ssh avec ce mot de passe temporaire: ``ssh root@{IP_INSTANCE}``
    - Il est possible que ssh refuse l'acces, auquel cas: ``ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "{IP_INSTANCE}"``
- Creer un compte avec mot de passe pour acces via la console VNC:
    - Afficher les disques: ``fdisk -l``
    - Monter le disque principal (en general /dev/sdb1): ``mount /dev/sdb1 /mnt``
    - Passer en root sur le ce repo: ``chroot /mnt``
    - Regarder la liste des utilisateurs: ``/etc/passwd``
    - Choisir un qui a des acces root puis lui donner un mot de passe fort, mais pas trop long, VNC n'ayant pas la fonction copier/coller: ``passwd {user}``
    - Quitter
- Corriger le probleme de configuration sshd:
    - Retourner sur le dashboard de l'instance et quitter le mode rescue
    - Une fois le serveur en marche, aller sur la console VNC et se connecter avec le compte de l'etape precedente
    - Passer en sudo: ``sudo su``
    - Verifier les erreurs sshd: ``sshd -t``
    - Les corriger dans /etc/sshd_config
	- Si il s'agit de l'erreur ``/etc/ssh/sshd_config line 186: Directive 'PubkeyAcceptedAlgorithms' is not allowed within a Match block``
    - Enlever la ligne, et placer, AVANT LE MATCH BLOCK, la ligne: ``HostKeyAlgorithms +ssh-rsa``
    - Redemarrer ssh: ``service sshd restart``
- Supprimer le mot de passe de l'utilisateur:
    - Si le service est de retour, supprimer le mot de passe: ``passwd -d {user}``
