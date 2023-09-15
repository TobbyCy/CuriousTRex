# 1. Manuel Utilisateur - Curious T-Rex- Projet de Surveillance des Raspberry Pi
<img src="../capture/CuruisTRex.png" alt="Image" width="100%" style="width:100%;">


<br><br><br><br><br>
<div style="page-break-after: always;"></div>

- [1. Manuel Utilisateur - Curious T-Rex- Projet de Surveillance des Raspberry Pi](#1-manuel-utilisateur---curious-t-rex--projet-de-surveillance-des-raspberry-pi)
- [2. Introduction](#2-introduction)
- [3. Matériel](#3-matériel)
  - [3.1. Nomenclature](#31-nomenclature)
- [4. Installation](#4-installation)
  - [4.1. Instalation physique](#41-instalation-physique)
  - [4.2. Instalation logiciel](#42-instalation-logiciel)
    - [4.2.1. Volt](#421-volt)
    - [4.2.2. Nidus](#422-nidus)
  - [4.3. Node-Red](#43-node-red)
  - [4.4. Utilisation](#44-utilisation)
  - [4.5. Maintenance](#45-maintenance)
  - [4.6. Licence](#46-licence)


<div style="page-break-after: always;"></div>

# 2. Introduction

Ce manuel utilisateur vous guidera à travers l'utilisation du système de surveillance des Raspberry Pi. Ce projet vise à surveiller la consommation d'énergie et la température des Raspberry Pi pour évaluer leurs performances. Suivez les étapes ci-dessous pour commencer.



# 3. Matériel
- **2x** Radiateur pour Raspberry Pi 4
- **2x** Raspberry Pi 4 /4GB RAM / 64GB SD
- **2x** Bloc d'alimentation Raspberry Pi 4
- **2x** Carte Micro SD 64GB
- **1x** cable Micro HDMI - HDMI (Déboguage)
- **1x** Plaque d'essai
- **1x** set de câbles de connexion
- **2x** Platine de mesure INA219
- **2x** câble USB-C Femelle 
- **2x** câble USB-C Mâle
## 3.1. Nomenclature

Pour simplifier la lecture du rapport ainsi que le travail, les Raspberry Pi seront nommés comme suit :
- **Volt** : Serveur Web
- **Nidus** : Serveur de monitoring

# 4. Installation
Pour installer le système de surveillance des Raspberry Pi, suivez les étapes ci-dessous.
Le but du projet est de proposer un système de monittoring complet et facile à installer.
## 4.1. Instalation physique
- Branchez les Raspberry Pi sur le réseau et sur un écran via le cable Micro HDMI - HDMI.
- Les Raspberry PI doivent se trouver sur le même réseau.
- Branchez les platines de mesure INA219 sur les ports GPIO des Raspberry Pi.
## 4.2. Instalation logiciel
### 4.2.1. Volt
Selon le but du projet, l'instalation de Volt est complétement à choix. Volt est est le serveur Web que vous souhaitez tester. En principe il devrait s'agir d'un serveur Web accessible en :80, simplement lié a la configuration de gatling cependant par la suite il faut personaliser le script de test pour qu'il corresponde à votre serveur Web.

Cependant, pour avoir les informations de monittoring il y a quand même une ou deux étapes à suivre.

- Il faut partager les clé SSH entre Nidus et Volt
- Il faut installer le script de monitoring sur Volt (mqtt.sh)


### 4.2.2. Nidus
Pour installer Nidus c'est l'inverse étant le serveur de monittoring, la procédure d'intallation est plus compliquée et surtout il faut suivre les étapes dans l'ordre.

SCRIPT A VENIR

## 4.3. Node-Red
Pour configurer Node-Red, une fois la procédure d'instalation terminée, il faut se rendre sur l'interface web de Node-Red. Pour cela il faut se rendre sur l'adresse IP de Nidus sur le port 1880. Par exemple : `http://nidus:1880` et une fois dessus il faut aller importer un projet qui celui de ce git. Pour cela il faut cliquer sur le menu en haut à droite, puis sur project, sur Clone Repositrory et entrer l'adresse du git 

## 4.4. Utilisation


## 4.5. Maintenance

1. **Mises à Jour :** Vérifiez régulièrement les mises à jour du projet pour bénéficier des dernières fonctionnalités et corrections de bugs.

2. **Problèmes Courants :** Consultez la section des problèmes courants de la documentation si vous rencontrez des difficultés.

## 4.6. Licence

Ce projet est sous licence GPL V3.0. Assurez-vous de respecter les termes de la licence lors de l'utilisation et de la distribution du logiciel.
