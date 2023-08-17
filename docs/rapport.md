# 1. Rapport de projet
# 2. Sommaire
- [1. Rapport de projet](#1-rapport-de-projet)
- [2. Sommaire](#2-sommaire)
- [3. Introduction](#3-introduction)
- [4. Instalation physique](#4-instalation-physique)
  - [Nidus](#nidus)
  - [Volt](#volt)
- [5. Shéma de principe](#5-shéma-de-principe)
- [6. OS](#6-os)
  - [Ubuntu](#ubuntu)
  - [Raspbian](#raspbian)
  - [6.1. Première instalation](#61-première-instalation)
  - [6.2. Configuration](#62-configuration)
- [8. Node-RED](#8-node-red)
  - [8.1. Instalation](#81-instalation)
  - [8.2. Configuration](#82-configuration)
    - [Instalation des plugins](#instalation-des-plugins)
    - [Sécurisation de Node-Red](#sécurisation-de-node-red)
- [9. Gatling](#9-gatling)
  - [9.1. Instalation](#91-instalation)
    - [Prerequis](#prerequis)
    - [Download](#download)
  - [Vérification de l'installation](#vérification-de-linstallation)
  - [9.2. Configuration](#92-configuration)
- [Apache et Site Web](#apache-et-site-web)
  - [1. Installation](#1-installation)
  - [Mise en place d'un site Web](#mise-en-place-dun-site-web)
- [10. Sources](#10-sources)

# 3. Introduction
Le système sera conçu pour simuler des requêtes HTTP réalistes à l'aide de Gatling, mesurer la consommation électrique en utilisant l'INA219 connecté via le bus I2C, et collecter les mesures de performance à l'aide de Node-RED. Les rapports générés fourniront des informations détaillées sur les performances du système testé, y compris le temps de réponse, la consommation d'énergie par requête, l'utilisation du processeur, etc.
# 4. Instalation physique
## Nidus
![](../capture/Nidus.jpg)
## Volt
![](../capture/Volt.jpg)

# 5. Shéma de principe
```ascii
           +---------+      +-------------+
           |   Volt  |      |   Nidus     |
           |_________|      |_____________|
           |  RPI 4  |      |  RPI 4      |
           |_________|      |_____________|
           | Apache  |      | Node-RED    |
           | No-Proc |      | Gatling     |
           |         |      | INA219      |
           +---------+      +-------------+
              ^   |             ^   |
              |   |             |   |
              |   |             |   |
              |   |             |   |
              |   v             |   v
         +-----------------------------+
         |       Réseau local          |
         +---+-------------------+-----+
             | Dashboard Node-Red|
             +-------------------+
                        ^
                        |
                        |
                  +------------+
                  |Utilisateur |
                  +------------+

```
# 6. OS
Dans le cadre de ce projet il y auras plusieurs OS utilisée mais pour débuter nous allons utiliser Ubuntu.
## Ubuntu
Ubuntu est un OS largement utilisé pour les serveurs et les ordinateurs de bureau. Ubuntu est livré avec un ensemble d'outils de développement et de productivité, y compris un navigateur Web, un éditeur de texte, des logiciels de programmation, des outils de calcul, des jeux et des logiciels de productivité. Ubuntu est un environnement de bureau léger et réactif conçu pour les ordinateurs de bureau et les serveurs.
## Raspbian
Raspbian est un système d'exploitation libre basé sur Debian optimisé pour le Raspberry Pi. Depuis 2015, Raspbian est fourni avec un ensemble d'outils appelé Pixel. Pixel est un environnement de bureau qui comprend un navigateur Web, un éditeur de texte, des logiciels de programmation, des outils de calcul, des jeux et des logiciels de productivité. Pixel est un environnement de bureau léger et réactif conçu pour les ordinateurs monocarte Raspberry Pi.
## 6.1. Première instalation
Dans un premier temps nous allons installer Ubuntu en version desktop sur Volt. La raison dèrière ce choix est que pour tester au plus vite tous les concepts du projet il est plus simple de travailler sur un environnement de bureau.

Sur Nidus c'est Raspbian enversion desktop qui sera installé pour les mêmes raisons que pour Volt.

La raison dèrière ce choix est que Ubuntu core est plus léger que raspbian et plus utilisée pour les serveur web et que Raspbian est plus performant sur les Raspberry pi que Ubuntu core
Dernier point important, étant donnée que l'INA219 sera branché à Nidus, il est plus simple de mettre raspbian sur Nidus pour avoir accès au GPIO.

Dans un second temps pour avoir des mesures plus précise nous allons installer des versions core de Ubuntu et de raspbian.

Adresse IP de Volt : 157.26.228.130
Adresse IP de Nidus : 157.26.251.158


## 6.2. Configuration
# 8. Node-RED
Node-RED est un outil de programmation visuelle open source conçu pour connecter des périphériques, des API et des services en ligne. Il fournit un éditeur de flux basé sur un navigateur qui facilite la connexion de nœuds en utilisant des liens glisser-déposer qui peuvent être exécutés dans un environnement Node.js. Les nœuds peuvent être des fonctions JavaScript ou des modules npm, tels que node-red-contrib-gpio, node-red-contrib-sqlite, node-red-contrib-modbustcp, etc. Node-RED est livré avec un ensemble de nœuds de base prêts à l'emploi, mais il existe maintenant plus de 2000 nœuds de la communauté qui sont disponibles pour une utilisation.
## 8.1. Instalation
```bash
tobby@Nidus:~ $ bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
Running Node-RED install for user tobby at /home/tobby on debian


This can take 20-30 minutes on the slower Pi versions - please wait.

  Stop Node-RED                       ✔
  Remove old version of Node-RED      ✔
  Remove old version of Node.js       ✔   
  Install Node.js 18 LTS              ✔   v18.17.1   Npm 9.6.7
  Clean npm cache                     ✔
  Install Node-RED core               ✔   3.0.2
  Move global nodes to local          -
  Npm rebuild existing nodes          ✔
  Install extra Pi nodes              ✔
  Add shortcut commands               ✔
  Update systemd script               ✔
                                      

Any errors will be logged to   /var/log/nodered-install.log
All done.
You can now start Node-RED with the command  node-red-start
  or using the icon under   Menu / Programming / Node-RED
Then point your browser to localhost:1880 or http://{your_pi_ip-address}:1880

Started :  mer 16 aoû 2023 14:12:19 CEST 
Finished:  mer 16 aoû 2023 14:16:01 CEST
 
**********************************************************************************
 ### WARNING ###
 DO NOT EXPOSE NODE-RED TO THE OPEN INTERNET WITHOUT SECURING IT FIRST
 
 Even if your Node-RED doesn't have anything valuable, (automated) attacks will
 happen and could provide a foothold in your local network
 
 Follow the guide at https://nodered.org/docs/user-guide/runtime/securing-node-red
 to setup security.
 
 ### ADDITIONAL RECOMMENDATIONS ###
  - Remove the /etc/sudoers.d/010_pi-nopasswd file to require entering your password
    when performing any sudo/root commands:
 
      sudo rm -f /etc/sudoers.d/010_pi-nopasswd
 
  - You can customise the initial settings by running:
 
      node-red admin init
 
  - After running Node-RED for the first time, change the ownership of the settings
    file to 'root' to prevent unauthorised changes:
 
      sudo chown root:root ~/.node-red/settings.js
 
**********************************************************************************
 
  Would you like to customise the settings now (y/N) ? y

Node-RED Settings File initialisation
=====================================
This tool will help you create a Node-RED settings file.

✔ Settings file · /home/tobby/.node-red/settings.js

User Security
=============
✔ Do you want to setup user security? · Yes
✔ Username · Tobby
✔ Password · ***********
✔ User permissions · full access
✔ Add another user? · Yes
✔ Username · FMA
✔ Password · ******** (Pa$$w.rd)
✔ User permissions · read-only access
✔ Add another user? · Yes
✔ Username · BVI
✔ Password · ******** (Pa$$w.rd)
✔ User permissions · read-only access
✔ Add another user? · No

Projects
========
The Projects feature allows you to version control your flow using a local git repository.

✔ Do you want to enable the Projects feature? · No

Flow File settings
==================
✔ Enter a name for your flows file · flows.json
✔ Provide a passphrase to encrypt your credentials file · 

Editor settings
===============
✔ Select a theme for the editor. To use any theme other than "default", you will need to install @node-red-contrib-themes/theme-collection in your Node-RED user directory. · dark
✔ Select the text editor component to use in the Node-RED Editor · monaco (default)

Node settings
=============
✔ Allow Function nodes to load external modules? (functionExternalModules) · Yes


Settings file written to /home/tobby/.node-red/settings.js
To use the 'dark' editor theme, remember to install @node-red-contrib-themes/theme-collection in your Node-RED user directory

tobby@Nidus:~ $ sudo systemctl enable nodered.service
Created symlink /etc/systemd/system/multi-user.target.wants/nodered.service → /lib/systemd/system/nodered.service.

```
![Alt text](../capture/RPI/Node-Red/PostInstall.png)
## 8.2. Configuration
### Instalation des plugins
![Alt text](../capture/RPI/Node-Red/palette1.png)
![Alt text](../capture/RPI/Node-Red/palette2.png)
![Alt text](../capture/RPI/Node-Red/palette3.png)
![Alt text](../capture/RPI/Node-Red/palette4.png)
![Alt text](../capture/RPI/Node-Red/Dashboard.png)
### Sécurisation de Node-Red
# 9. Gatling
Gatling est un outil de test de charge open source basé sur Scala, conçu pour tester les performances des applications et des sites Web. Gatling simule des utilisateurs virtuels qui envoient des requêtes HTTP vers le système cible. Il enregistre les temps de réponse des requêtes et les présente sous forme de graphiques. Gatling est livré avec un éditeur de scénario basé sur un navigateur qui permet aux utilisateurs de créer des scénarios de test de charge en utilisant un langage de domaine spécifique (DSL) appelé Gatling DSL. Gatling DSL est un langage de programmation basé sur Scala qui permet aux utilisateurs de définir des scénarios de test de charge en utilisant des mots-clés tels que exec, pause, feed, etc.

La dernière version de Gatling est la version 3.9.5 qui est compatible avec Java 8 et Java 11. Dans ce projet, nous utiliserons Java 11 pour exécuter Gatling.

## 9.1. Instalation
### Prerequis
```bash
tobby@Nidus:~ $ sudo apt install default-jdk
tobby@Nidus:~/.node-red $ java -version
openjdk version "11.0.18" 2023-01-17
OpenJDK Runtime Environment (build 11.0.18+10-post-Debian-1deb11u1)
OpenJDK 64-Bit Server VM (build 11.0.18+10-post-Debian-1deb11u1, mixed mode)
tobby@Nidus:~/.node-red $ 


```
### Download

```bash
tobby@Nidus:~ $ mkdir .gatling
tobby@Nidus:~ $ ls -la
total 104
drwxr-xr-x 18 tobby tobby 4096 16 aoû 15:10 .
drwxr-xr-x  3 root  root  4096 16 aoû 13:58 ..
-rw-------  1 tobby tobby  453 16 aoû 14:26 .bash_history
-rw-r--r--  1 tobby tobby  220  3 mai 04:53 .bash_logout
-rw-r--r--  1 tobby tobby 3523  3 mai 04:53 .bashrc
drwxr-xr-x  2 tobby tobby 4096  3 mai 05:02 Bookshelf
drwxr-xr-x  4 tobby tobby 4096 16 aoû 13:58 .cache
drwx------  5 tobby tobby 4096 16 aoû 13:58 .config
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Desktop
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Documents
drwxr-xr-x  2 tobby tobby 4096 16 aoû 15:10 .gatling
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Images
drwxr-xr-x  3 tobby tobby 4096  3 mai 05:02 .local
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Modèles
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Musique
drwxr-xr-x  4 tobby tobby 4096 16 aoû 15:05 .node-red
drwxr-xr-x  4 tobby tobby 4096 16 aoû 14:15 .npm
-rw-------  1 tobby tobby   22 16 aoû 14:15 .npmrc
-rw-r--r--  1 tobby tobby  807  3 mai 04:53 .profile
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Public
drwxr-xr-x  2 tobby tobby 4096 16 aoû 14:06 .ssh
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Téléchargements
drwxr-xr-x  2 tobby tobby 4096 16 aoû 13:58 Vidéos
-rw-------  1 tobby tobby  106 16 aoû 14:27 .Xauthority
-rw-------  1 tobby tobby 2521 16 aoû 14:27 .xsession-errors
-rw-------  1 tobby tobby 2521 16 aoû 14:02 .xsession-errors.old
tobby@Nidus:~ $ wget -O ~/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip
--2023-08-16 15:12:41--  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip
Résolution de repo1.maven.org (repo1.maven.org)… 146.75.116.209, 2a04:4e42:8d::209
Connexion à repo1.maven.org (repo1.maven.org)|146.75.116.209|:443… connecté.
requête HTTP transmise, en attente de la réponse… 200 OK
Taille : 77080673 (74M) [application/zip]
Sauvegarde en : « /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip »

/home/tobby/.gatling/gatling-charts-highcharts-bundl 100%[====================================================================================================================>]  73.51M  11.0MB/s    ds 5.8s    

2023-08-16 15:12:47 (12.8 MB/s) — « /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip » sauvegardé [77080673/77080673]

tobby@Nidus:~ $ unzip ~/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip -d ~/.gatling/
Archive:  /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/conf/
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/conf/recorder.conf  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/conf/logback.xml  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/conf/gatling.conf  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/conf/gatling-akka.conf  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-transport-classes-epoll-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-handler-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-charts-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final-windows-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/native-osx-x86_64-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/native-windows-x86_64-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/javax.jms-api-2.0.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jackson-annotations-2.15.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-persist_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/akka-slf4j_2.13-2.6.20.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/config-1.4.2.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-core_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/service-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/unbescape-1.1.6.RELEASE.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final-osx-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/commons-pool2-2.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/Saxon-HE-10.6.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-classfile_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-scanner-1.1.3-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/java-diff-utils-4.12.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-recorder-bc-shaded-1.73.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/logback-core-1.2.12.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-classpath_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-mqtt-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/util-control_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-resolver-dns-classes-macos-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/file-tree-views-2.1.9.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-logging_2.13-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/pebble-3.2.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-asm-shaded-9.5-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/HdrHistogram-2.1.12.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-library-2.13.10.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-commons-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/caffeine-2.9.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/io_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jdbc-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-apiinfo_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-http-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/util-relation_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/collections_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jsonpath-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jodd-util-6.1.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-parallel-collections_2.13-0.2.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/logback-classic-1.2.12.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-core-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/error_prone_annotations-2.10.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-incubator-transport-native-io_uring-0.0.21.Final-linux-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/boopickle_2.13-1.3.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final-linux-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-graphite-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-http-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jms-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jackson-core-2.15.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-http2-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jms-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/util-interface-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/util-logging_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-charts-highcharts-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/native-linux-x86_64-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/lightning-csv-8.2.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-handler-proxy-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-swing_2.13-3.0.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-incubator-transport-native-io_uring-0.0.21.Final-linux-aarch_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-reflect-2.13.10.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jmespath-core-0.5.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-http-client-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-redis-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-common-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-transport-native-epoll-4.1.92.Final-linux-aarch_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-bundle-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jdbc-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/fast-uuid-0.2.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-jdk-util-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/redisclient_2.13-3.42.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-buffer-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jodd-lagarto-6.0.6.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-parser-combinators_2.13-2.3.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-recorder-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/slf4j-api-1.7.36.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final-linux-aarch_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-enterprise-plugin-commons-1.5.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/compiler-bridge_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jna-platform-5.12.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-mqtt-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-compiler-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/util-position_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-http-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-resolver-dns-native-macos-4.1.92.Final-osx-aarch_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jsr305-3.0.2.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-resolver-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-mqtt-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scopt_2.13-3.7.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-commons-shared-unstable-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-app-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jackson-databind-2.15.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-commons-shared-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/sfm-util-8.2.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/quicklens_2.13-1.9.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/spire-macros_2.13-0.17.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/native-osx-aarch64-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/akka-actor_2.13-2.6.20.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-transport-native-epoll-4.1.92.Final-linux-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-transport-native-unix-common-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-redis-java-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jline-terminal-3.19.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-java8-compat_2.13-1.0.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-compile-core_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final-osx-aarch_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-socks-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zero-allocation-hashing-0.10.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/core-macros_2.13-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jna-5.12.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/typetools-0.6.3.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/jmespath-jackson-0.5.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-resolver-dns-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/scala-compiler-2.13.10.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-transport-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/checker-qual-3.19.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-incubator-transport-classes-io_uring-0.0.21.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-boringssl-static-2.0.61.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/t-digest-3.1.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/brotli4j-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-codec-dns-4.1.92.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-netty-util-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-tcnative-classes-2.0.61.Final.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/netty-resolver-dns-native-macos-4.1.92.Final-osx-x86_64.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/compiler-interface-1.8.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/native-linux-aarch64-1.11.0.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/gatling-core-3.9.5.jar  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/lib/zinc-persist-core-assembly-1.8.0.jar  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin/
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin/recorder.bat  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin/gatling.sh  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin/gatling.bat  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin/recorder.sh  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/lib/
 extracting: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/lib/.keep  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/simulations/
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/simulations/computerdatabase/
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/simulations/computerdatabase/ComputerDatabaseSimulation.java  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/resources/
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/user-files/resources/search.csv  
   creating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/results/
 extracting: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/results/.keep  
  inflating: /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/LICENSE  
tobby@Nidus:~ $ cd .gatling/
tobby@Nidus:~/.gatling $ ls -la
total 75288
drwxr-xr-x  3 tobby tobby     4096 16 aoû 15:12 .
drwxr-xr-x 18 tobby tobby     4096 16 aoû 15:10 ..
drwxr-xr-x  7 tobby tobby     4096 10 mai 11:19 gatling-charts-highcharts-bundle-3.9.5
-rw-r--r--  1 tobby tobby 77080673 10 mai 11:19 gatling-charts-highcharts-bundle-3.9.5-bundle.zip
tobby@Nidus:~/.gatling $ cd gatling-charts-highcharts-bundle-3.9.5/
tobby@Nidus:~/.gatling/gatling-charts-highcharts-bundle-3.9.5 $ ls -la
total 48
drwxr-xr-x 7 tobby tobby  4096 10 mai 11:19 .
drwxr-xr-x 3 tobby tobby  4096 16 aoû 15:12 ..
drwxr-xr-x 2 tobby tobby  4096 10 mai 11:19 bin
drwxr-xr-x 2 tobby tobby  4096 10 mai 11:19 conf
drwxr-xr-x 2 tobby tobby 12288 10 mai 11:19 lib
-rw-r--r-- 1 tobby tobby 11367 10 mai 11:19 LICENSE
drwxr-xr-x 2 tobby tobby  4096 10 mai 11:19 results
drwxr-xr-x 5 tobby tobby  4096 10 mai 11:19 user-files
```
## Vérification de l'installation
```
tobby@Nidus:~/.gatling/gatling-charts-highcharts-bundle-3.9.5/bin $ ./gatling.sh
GATLING_HOME is set to /home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5
Do you want to run the simulation locally, on Gatling Enterprise, or just package it?
Type the number corresponding to your choice and press enter
[0] <Quit>
[1] Run the Simulation locally
[2] Package and upload the Simulation to Gatling Enterprise Cloud, and run it there
[3] Package the Simulation for Gatling Enterprise
[4] Show help and exit
1
août 16, 2023 4:28:28 PM java.util.prefs.FileSystemPreferences$1 run
INFO: Created user preferences directory.
computerdatabase.ComputerDatabaseSimulation is the only simulation, executing it.
Select run description (optional)
InstallVerif
Simulation computerdatabase.ComputerDatabaseSimulation started...

================================================================================
2023-08-16 16:29:14                                           5s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=23     KO=0     )
> Home                                                     (OK=6      KO=0     )
> Home Redirect 1                                          (OK=6      KO=0     )
> Search                                                   (OK=5      KO=0     )
> Select                                                   (OK=3      KO=0     )
> Page 0                                                   (OK=3      KO=0     )

---- Users ---------------------------------------------------------------------
[-------------------------------------                                     ]  0%
          waiting: 5      / active: 5      / done: 0     
---- Admins --------------------------------------------------------------------
[-------------------------------------                                     ]  0%
          waiting: 1      / active: 1      / done: 0     
================================================================================


================================================================================
2023-08-16 16:29:19                                          10s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=71     KO=0     )
> Home                                                     (OK=12     KO=0     )
> Home Redirect 1                                          (OK=12     KO=0     )
> Search                                                   (OK=11     KO=0     )
> Select                                                   (OK=10     KO=0     )
> Page 0                                                   (OK=9      KO=0     )
> Page 1                                                   (OK=8      KO=0     )
> Page 2                                                   (OK=5      KO=0     )
> Page 3                                                   (OK=3      KO=0     )
> Form                                                     (OK=1      KO=0     )

---- Users ---------------------------------------------------------------------
[##############------------------------------------------------------------] 20%
          waiting: 0      / active: 8      / done: 2     
---- Admins --------------------------------------------------------------------
[--------------------------------------------------------------------------]  0%
          waiting: 0      / active: 2      / done: 0     
================================================================================


================================================================================
2023-08-16 16:29:24                                          15s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=101    KO=2     )
> Home                                                     (OK=12     KO=0     )
> Home Redirect 1                                          (OK=12     KO=0     )
> Search                                                   (OK=12     KO=0     )
> Select                                                   (OK=12     KO=0     )
> Page 0                                                   (OK=12     KO=0     )
> Page 1                                                   (OK=12     KO=0     )
> Page 2                                                   (OK=11     KO=0     )
> Page 3                                                   (OK=10     KO=0     )
> Form                                                     (OK=4      KO=0     )
> Post                                                     (OK=3      KO=0     )
> Post Redirect 1                                          (OK=1      KO=2     )
---- Errors --------------------------------------------------------------------
> status.find.is(201), but actually found 200                         2 (100,0%)

---- Users ---------------------------------------------------------------------
[###################################################-----------------------] 70%
          waiting: 0      / active: 3      / done: 7     
---- Admins --------------------------------------------------------------------
[#####################################-------------------------------------] 50%
          waiting: 0      / active: 1      / done: 1     
================================================================================


================================================================================
2023-08-16 16:29:26                                          17s elapsed
---- Requests ------------------------------------------------------------------
> Global                                                   (OK=105    KO=3     )
> Home                                                     (OK=12     KO=0     )
> Home Redirect 1                                          (OK=12     KO=0     )
> Search                                                   (OK=12     KO=0     )
> Select                                                   (OK=12     KO=0     )
> Page 0                                                   (OK=12     KO=0     )
> Page 1                                                   (OK=12     KO=0     )
> Page 2                                                   (OK=12     KO=0     )
> Page 3                                                   (OK=12     KO=0     )
> Form                                                     (OK=4      KO=0     )
> Post                                                     (OK=4      KO=0     )
> Post Redirect 1                                          (OK=1      KO=3     )
---- Errors --------------------------------------------------------------------
> status.find.is(201), but actually found 200                         3 (100,0%)

---- Users ---------------------------------------------------------------------
[##########################################################################]100%
          waiting: 0      / active: 0      / done: 10    
---- Admins --------------------------------------------------------------------
[##########################################################################]100%
          waiting: 0      / active: 0      / done: 2     
================================================================================

Simulation computerdatabase.ComputerDatabaseSimulation completed in 17 seconds
Parsing log file(s)...
Parsing log file(s) done
Generating reports...

================================================================================
---- Global Information --------------------------------------------------------
> request count                                        108 (OK=105    KO=3     )
> min response time                                    108 (OK=108    KO=111   )
> max response time                                   1563 (OK=1563   KO=114   )
> mean response time                                   162 (OK=163    KO=112   )
> std deviation                                        168 (OK=170    KO=1     )
> response time 50th percentile                        115 (OK=115    KO=112   )
> response time 75th percentile                        120 (OK=121    KO=113   )
> response time 95th percentile                        351 (OK=352    KO=114   )
> response time 99th percentile                        620 (OK=620    KO=114   )
> mean requests/sec                                  6.353 (OK=6.176  KO=0.176 )
---- Response Time Distribution ------------------------------------------------
> t < 800 ms                                           104 ( 96%)
> 800 ms <= t < 1200 ms                                  0 (  0%)
> t >= 1200 ms                                           1 (  1%)
> failed                                                 3 (  3%)
---- Errors --------------------------------------------------------------------
> status.find.is(201), but actually found 200                         3 (100,0%)
================================================================================

Reports generated in 0s.
Please open the following file: file:///home/tobby/.gatling/gatling-charts-highcharts-bundle-3.9.5/results/computerdatabasesimulation-20230816142907884/index.html
```
## 9.2. Configuration
# Apache et Site Web
## 1. Installation
```bash
sudo apt install apache2
sudo systemctl status apache2
sudo systemctl enable apache2
```
## Mise en place d'un site Web
J'ai créee un site web très simple reprenant le readme du projet. Et il comporte trois pages ainsi que du CSS.
```bash
scp -r /home/toblerc/Documents/ES_2024/banc-de-mesures-de-la-consommation-electrique/siteWeb/www/html tobby@Volt:/var/www/html/
```
# 10. Sources
Node-Red [Install](https://nodered.org/docs/getting-started/raspberrypi)
Sécurisation de [Node-Red](https://nodered.org/docs/user-guide/runtime/securing-node-red)

Télèchargement [Gatling](https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip)
Tuto Avancé [Gatling](https://gatling.io/docs/gatling/tutorials/advanced/)
Tuto [Gatling](https://gatling.io/docs/gatling/tutorials/quickstart/)