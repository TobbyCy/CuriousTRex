# Manuel Utilisateur - Curious T-Rex- Projet de Surveillance des Raspberry Pi
<img src="../capture/CuruisTRex.png" alt="Image" width="100%" style="width:100%;">


<br><br><br><br><br>
<div style="page-break-after: always;"></div>

## Introduction

Ce manuel utilisateur vous guidera à travers l'utilisation du système de surveillance des Raspberry Pi. Ce projet vise à surveiller la consommation d'énergie et la température des Raspberry Pi pour évaluer leurs performances. Suivez les étapes ci-dessous pour commencer.



# 6. Matériel
- **2x** Radiateur pour Raspberry Pi 4
- **2x** Raspberry Pi 4 /4GB RAM / 64GB SD
- **2x** Bloc d'alimentation Raspberry Pi 4
- **2x** Carte Micro SD 64GB
- **2x** cable RJ45 rose
- **1x** cable Micro HDMI - HDMI
- **1x** Plaque d'essai
- **1x** set de câbles de connexion
- **2x** Platine de mesure INA219
- **2x** câble USB-C Femelle 
- **2x** câble USB-C Mâle

# Installation
Pour installer le système de surveillance des Raspberry Pi, suivez les étapes ci-dessous.
Le but du projet est de proposer un système de monittoring complet et facile à installer.
## 

## **Connectez les Capteurs INA219 :** 
Assurez-vous que les capteurs INA219 sont correctement connectés à vos Raspberry Pi pour la surveillance de la consommation d'énergie.


## **Configuration MQTT :** 
Configurez l'accès à votre serveur MQTT en modifiant les paramètres appropriés dans le fichier de configuration.

## **Node-Red :** 
Importez les flux Node-Red fournis dans le projet pour automatiser la collecte de données.


## Utilisation

1. **Lancement de Node-Red :** Démarrez Node-Red sur votre ordinateur.

2. **Exécution des Flux :** Importez les flux de surveillance des Raspberry Pi dans Node-Red et exécutez-les. Cela collectera automatiquement les données de consommation d'énergie et de température.

3. **Visualisation des Données :** Utilisez les tableaux de bord Node-Red pour visualiser les données collectées.

4. **Tests de Performance (Facultatif) :** Si vous effectuez des tests de performance avec Gatling, suivez les instructions fournies dans la documentation associée.

## Maintenance

1. **Mises à Jour :** Vérifiez régulièrement les mises à jour du projet pour bénéficier des dernières fonctionnalités et corrections de bugs.

2. **Problèmes Courants :** Consultez la section des problèmes courants de la documentation si vous rencontrez des difficultés.

## Licence

Ce projet est sous licence GPL V3.0. Assurez-vous de respecter les termes de la licence lors de l'utilisation et de la distribution du logiciel.
