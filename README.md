# 1. Projet de Banc de Mesures de Performance

Ce projet consiste à mettre en place un banc de mesures de performance pour évaluer la performance d'un site web ou d'une application web en collectant des données de mesure et en générant des rapports détaillés. Le banc de mesures utilisera des outils tels que Gatling, INA219 et Node-RED pour effectuer les mesures et analyser les résultats.

# 2. Table des matières
- [1. Projet de Banc de Mesures de Performance](#1-projet-de-banc-de-mesures-de-performance)
- [2. Table des matières](#2-table-des-matières)
- [3. Description](#3-description)
- [4. Caractéristiques](#4-caractéristiques)
- [5. Jalons](#5-jalons)
  - [5.1. Mise en place (14.08.2023 - 21.08.2023)](#51-mise-en-place-14082023---21082023)
    - [5.1.1. But](#511-but)
    - [5.1.2. Etapes](#512-etapes)
    - [5.1.3. Remarque](#513-remarque)
  - [5.2. 1ère itération (21.08.2023 - 04.09.2023)](#52-1ère-itération-21082023---04092023)
    - [5.2.1. But](#521-but)
    - [5.2.2. Étape](#522-étape)
    - [5.2.3. Remarque](#523-remarque)
  - [5.3. 2ème itération (04.09.2023 - 11.09.2023)](#53-2ème-itération-04092023---11092023)
    - [5.3.1. But](#531-but)
    - [5.3.2. Étape](#532-étape)
      - [5.3.2.1. Configuration de l'UI](#5321-configuration-de-lui)
      - [5.3.2.2. Sélection du conteneur LXD et Configuration du Serveur](#5322-sélection-du-conteneur-lxd-et-configuration-du-serveur)
      - [5.3.2.3. Génération de Comparatifs](#5323-génération-de-comparatifs)
      - [5.3.2.4. Tests et Validation](#5324-tests-et-validation)
    - [5.3.3. Remarque](#533-remarque)
  - [5.4. Bonus (11.09.2023 - 22.09.2023)](#54-bonus-11092023---22092023)
    - [5.4.1. Remarque](#541-remarque)
- [6. Matériel](#6-matériel)
- [7. Documentation](#7-documentation)
- [8. Sources](#8-sources)


# 3. Description

Le système sera conçu pour simuler des requêtes HTTP réalistes à l'aide de Gatling, mesurer la consommation électrique en utilisant l'INA219 connecté via le bus I2C, et collecter les mesures de performance à l'aide de Node-RED. Les rapports générés fourniront des informations détaillées sur les performances du système testé, y compris le temps de réponse, la consommation d'énergie par requête, l'utilisation du processeur, etc.

# 4. Caractéristiques

- **Génération de trafic web:** Utilisation de Gatling pour simuler des requêtes HTTP réalistes, configurer des scénarios de charge et évaluer les performances du système testé.

- **Mesure de la consommation électrique (INA219):** Utilisation d'un chip INA219 pour mesurer la consommation d'énergie avec précision en mesurant la tension et le courant du système testé.

- **Mesure de la consommation:** Utilisation de Node-RED pour relever les mesures de consommation des ressources du banc de tests, y compris la consommation d'énergie, l'utilisation du processeur, la consommation de mémoire, la bande passante et les temps de réponse.

- **Génération de rapports:** Utilisation de Node-RED pour générer des rapports détaillés sur les performances du système testé, y compris les mesures de performance et les données de consommation.

- **Interface utilisateur:** Utilisation d'une interface utilisateur conviviale pour configurer les tests, sélectionner les serveurs à tester et comparer les résultats des tests.

# 5. Jalons

## 5.1. Mise en place (14.08.2023 - 21.08.2023)
### 5.1.1. But 
Création d'une UI pour gérer les tests et permettre au projet de passer une étape pour devenir "utilisable" en production de fais, l'utilisateur dois pouvoir via l'UI choisir le conteneur LXD à tester, définir le serveur WEB, ajouter des paramètre (Avec/sans BD, SSL, Apache/Nginx, etc) et utiliser plusieurs tests pour créer un comparatif.
### 5.1.2. Etapes
- [ ] Création du repository du projet
- [ ] Mise en place de la structure de documentation
- [ ] Installation des Raspberry Pi dans l'environnement prévu
- [ ] Configuration des paramètres de base des Raspberry Pi
- [ ] Installation de LXD, Node-RED et Gatling sur les Raspberry Pi
- [ ] Configuration de l'INA219 pour la mesure de la consommation
### 5.1.3. Remarque
Ce jalon est une étape importante pour le projet, car il permettra de mettre en place l'environnement de test et de configurer les outils nécessaires pour effectuer les mesures. En atteignant ces objectifs, le projet sera prêt à passer à la prochaine étape et à commencer à effectuer des tests de performance.
## 5.2. 1ère itération (21.08.2023 - 04.09.2023)
### 5.2.1. But
Mettre en places un "proof of concept" qui se baseras simplement sur la génération d'un rapport PDF par node-red via les informations de monitoring d'une machine LXC mise sous pression par gattling.

Cette "PoC" ne permettras pas de :
1. L'impossibilité de sélectionner le serveur à tester.
1. L'absence d'interface utilisateur conviviale (UI/UX).
1. L'incapacité à comparer les performances entre différents serveurs.

### 5.2.2. Étape
Pour atteindre ces objectifs, les étapes suivantes seront entreprises :
- [ ] Configuration de Node-red pour la gestion des flux de données.
- [ ] Création d'une machine LXD avec un serveur apache simple
- [ ] Configurer l'outil Gatling pour générer des charges de test sur la machine LXD et collecter les données de performance.
- [ ] Configuration et test de relevé de l'INA219
- [ ] Test de création de PDF avec Node-Red
- [ ] Lancement des test de charge de Gatling depuis Node-Red
- [ ] Agrégation du lancement des test et des relevé de l'INA219
- [ ] Création du PDF contenant les résultat de Gatling et de l'INA219

### 5.2.3. Remarque

En atteignant ces étapes de validation, le PoC démontrera la capacité à générer un rapport PDF en utilisant Node-RED, en se basant sur les informations de surveillance d'une machine LXC soumise à des tests de charge avec Gatling. Cela jettera les bases d'une solution plus complète pour l'interface utilisateur, la comparaison de serveurs et d'autres fonctionnalités futures.

## 5.3. 2ème itération (04.09.2023 - 11.09.2023)
### 5.3.1. But 
Création d'une UI pour gérer les tests et permettre au projet de passer une étape pour devenir "utilisable" en production de fais, l'utilisateur dois pouvoir via l'UI choisir le conteneur LXD à tester, définir le serveur WEB, ajouter des paramètre (Avec/sans BD, SSL, Apache/Nginx, etc) et utiliser plusieurs tests pour créer un comparatif.
### 5.3.2. Étape
#### 5.3.2.1. Configuration de l'UI
- Développer une interface utilisateur conviviale et intuitive.
- Intégrer les champs de sélection du conteneur LXD et de configuration du serveur WEB.
- Permettre l'ajout et la gestion des différentes configurations de test.

#### 5.3.2.2. Sélection du conteneur LXD et Configuration du Serveur
- Mettre en place la fonctionnalité de sélection du conteneur LXD.
- Implémenter la configuration du serveur WEB (Apache/Nginx).
- Intégrer les paramètres tels que la présence de base de données, SSL, etc.

#### 5.3.2.3. Génération de Comparatifs
- Implémenter la fonctionnalité pour exécuter plusieurs tests.
- Collecter et enregistrer les résultats de chaque test sous la forme de JSON.
- Établir un mécanisme pour comparer les performances des différents tests.
- Permettre l'importation de JSON pour comparer directement le performance sans refaire de tests

#### 5.3.2.4. Tests et Validation
- Effectuer des tests approfondis pour s'assurer du bon fonctionnement de l'UI.
- Vérifier la cohérence et l'exactitude des données collectées.
- Assurer que l'UI est réactive et adaptée à différentes configurations.

### 5.3.3. Remarque

Ce jalon représente une avancée significative par rapport au précédent "proof of concept" (PoC), car il inclut la mise en place d'une interface utilisateur, la sélection de conteneurs LXD, la configuration des serveurs, et la possibilité de comparer les résultats de différents tests. En atteignant ces objectifs, le projet se rapprochera davantage d'une utilisation en production et offrira une expérience plus complète aux utilisateurs.

## 5.4. Bonus (11.09.2023 - 22.09.2023)
Selon suivi voir si il est possible de faire une troisième itération pour ajouter des fonctionnalités supplémentaires, telles que :
- [ ] Ajouter la possibilité de tester plusieurs serveurs en même temps.
- [ ] Ajouter la possibilitée de stocker les résultats dans une base de données.
- [ ] Ajouter la possibilité de générer des graphiques pour les résultats.
- [ ] Ajouter la possibilitée d'utiliser un capteur type prise connectée pour mesurer la consommation électrique d'un rack de serveur complet.
- [ ] Consultation d'un expert pour voir si il est possible de faire une version "boitier" du projet pour le rendre plus portable.
- [ ] Consultation d'un expert pour donner des résultats plus précis notament grâce a des statistique sur de multiple test.

### 5.4.1. Remarque
Ce jalon est facultatif et dépendra de la disponibilité des ressources et du temps restant. Iytel s'agit d'une opportunité pour le projet d'aller au-delà des objectifs initiaux et d'ajouter des fonctionnalités supplémentaires pour améliorer l'expérience utilisateur et les performances du système.

# 6. Matériel

- 2x Raspberry Pi 4
- Blocs d'alimentation Raspberry
- Platine de mesure INA219

# 7. Documentation
La documentation se trouve dans le dossier `docs` du repository. Il y a deux documents principaux :
- [Rapport de projet](docs/rapport.md) : Rapport de projet qui décrit les différentes étapes du projet pour le reproduire ou le modifier.
- [Manuel d'utilisation](docs/manuel.md) : Manuel d'utilisation qui décrit comment utiliser le projet une fois qu'il est installé.

La documentation est écrite en Markdown et peut être consultée directement sur GitLab ou convertie en PDF à l'aide de Pandoc.
Un [wiki](https://mylos.cifom.ch/gitlab/ToblerC/banc-de-mesures-de-la-consommation-electrique/-/wikis/home) est également disponible sur GitLab pour fournir des informations mieux structurées sur le projet.


# 8. Sources