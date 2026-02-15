# Minecraft Server Manager

Ce script Bash permet l'installation automatisée, la configuration et la gestion d'un serveur Minecraft sur les systèmes basés sur linux (Debian/Ubuntu). Il simplifie le processus de déploiement en gérant les dépendances, le téléchargement des binaires officiels et l'exécution en arrière-plan via `screen`.

## Fonctionnalités

* **Gestion des dépendances** : Vérification et installation automatique de Java (JRE) et de GNU Screen.
* **Déploiement automatisé** : Création du répertoire de travail et téléchargement de la version du serveur choisie voir https://gist.github.com/cliffano/77a982a7503669c3e1acb0a0cf6127e9?permalink_comment_id=5104349 pour avoir une autre version.
* **Configuration EULA** : Acceptation automatique des conditions d'utilisation (EULA) après initialisation.
* **Contrôle de processus** : Démarrage, arrêt sécurisé et redémarrage du serveur dans une session détachée.
* **Surveillance** : Consultation de l'état du serveur et lecture des journaux (logs) en temps réel.

## Prérequis

* Système d'exploitation : Linux (Debian, Ubuntu ou dérivés).
* Privilèges : Accès `sudo` requis pour l'installation des paquets système.
* Connexion Internet pour le téléchargement des composants.

## Installation

1. Cloner le dépôt ou copier le script sur votre machine.
2. Attribuer les permissions d'exécution au fichier :
```bash
chmod +x mc.sh

```


3. Lancer le script pour initier l'installation :
```bash
./mc.sh

```


Suivez les instructions à l'écran pour définir le nom du dossier et la version du jeu.

## Utilisation

Une fois l'installation terminée, le script s'utilise avec les arguments suivants :

| Commande | Description |
| --- | --- |
| `start` | Démarre le serveur Minecraft dans une session screen nommée "minecraft". |
| `stop` | Envoie la commande d'arrêt au serveur et attend la fermeture propre du processus. |
| `restart` | Relance le serveur. |
| `status` | Indique si le serveur est actuellement en cours d'exécution. |
| `log` | Affiche le flux de sortie du serveur (latest.log) en temps réel. |

### Exemple

```bash
./mc.sh start
./mc.sh status

```

## Structure du projet

* **Répertoire du serveur** : Créé dans le répertoire personnel de l'utilisateur (`~/`) si pas de chemin spécifié.
* **Session Screen** : Le serveur tourne sous l'alias `minecraft`, permettant de s'y attacher manuellement via `screen -r minecraft`.

