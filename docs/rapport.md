# 1. Rapport de projet
# 2. Sommaire
- [1. Rapport de projet](#1-rapport-de-projet)
- [2. Sommaire](#2-sommaire)
- [3. Introduction](#3-introduction)
- [4. Instalation physique](#4-instalation-physique)
- [5. Shéma de principe](#5-shéma-de-principe)
- [6. Raspbian](#6-raspbian)
  - [6.1. Instalation](#61-instalation)
  - [6.2. Configuration](#62-configuration)
- [7. LXD](#7-lxd)
  - [7.1. Instalation](#71-instalation)
  - [7.2. Configuration](#72-configuration)
- [8. Node-RED](#8-node-red)
  - [8.1. Instalation](#81-instalation)
  - [8.2. Configuration](#82-configuration)
- [9. Gatling](#9-gatling)
  - [9.1. Instalation](#91-instalation)
  - [9.2. Configuration](#92-configuration)
- [10. Sources](#10-sources)

# 3. Introduction
Le système sera conçu pour simuler des requêtes HTTP réalistes à l'aide de Gatling, mesurer la consommation électrique en utilisant l'INA219 connecté via le bus I2C, et collecter les mesures de performance à l'aide de Node-RED. Les rapports générés fourniront des informations détaillées sur les performances du système testé, y compris le temps de réponse, la consommation d'énergie par requête, l'utilisation du processeur, etc.
# 4. Instalation physique
# 5. Shéma de principe
```ascii
           +---------+      +-------------+
           |   Volt  |      |   Nidus     |
           |_________|      |_____________|
           |  RPI 4  |      |  RPI 4      |
           |_________|      |_____________|
           | LXD VM  |      | Node-RED    |
           |         |      | Gatling     |
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
# 6. Raspbian
Raspbian est un système d'exploitation libre basé sur Debian optimisé pour le Raspberry Pi. Depuis 2015, Raspbian est fourni avec un ensemble d'outils appelé Pixel. Pixel est un environnement de bureau qui comprend un navigateur Web, un éditeur de texte, des logiciels de programmation, des outils de calcul, des jeux et des logiciels de productivité. Pixel est un environnement de bureau léger et réactif conçu pour les ordinateurs monocarte Raspberry Pi.
## 6.1. Instalation
## 6.2. Configuration
# 7. LXD
LXD est un hyperviseur de conteneurs open source, léger, basé sur le noyau Linux et conçu pour fournir des machines virtuelles et des images de conteneurs à des systèmes d'exploitation Linux. LXD est un système de gestion de conteneurs qui offre une expérience utilisateur similaire à celle des machines virtuelles, mais en utilisant des technologies de conteneur et des fonctionnalités de noyau Linux. Il est disponible pour les distributions Linux et est intégré à Ubuntu depuis la version 15.04 (Vivid Vervet).
## 7.1. Instalation
## 7.2. Configuration
# 8. Node-RED
Node-RED est un outil de programmation visuelle open source conçu pour connecter des périphériques, des API et des services en ligne. Il fournit un éditeur de flux basé sur un navigateur qui facilite la connexion de nœuds en utilisant des liens glisser-déposer qui peuvent être exécutés dans un environnement Node.js. Les nœuds peuvent être des fonctions JavaScript ou des modules npm, tels que node-red-contrib-gpio, node-red-contrib-sqlite, node-red-contrib-modbustcp, etc. Node-RED est livré avec un ensemble de nœuds de base prêts à l'emploi, mais il existe maintenant plus de 2000 nœuds de la communauté qui sont disponibles pour une utilisation.
## 8.1. Instalation
## 8.2. Configuration
# 9. Gatling
Gatling est un outil de test de charge open source basé sur Scala, conçu pour tester les performances des applications et des sites Web. Gatling simule des utilisateurs virtuels qui envoient des requêtes HTTP vers le système cible. Il enregistre les temps de réponse des requêtes et les présente sous forme de graphiques. Gatling est livré avec un éditeur de scénario basé sur un navigateur qui permet aux utilisateurs de créer des scénarios de test de charge en utilisant un langage de domaine spécifique (DSL) appelé Gatling DSL. Gatling DSL est un langage de programmation basé sur Scala qui permet aux utilisateurs de définir des scénarios de test de charge en utilisant des mots-clés tels que exec, pause, feed, etc.
## 9.1. Instalation
## 9.2. Configuration
# 10. Sources