#!/bin/bash

# Vérification des droits d'exécution
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant qu'utilisateur root. Utilisez 'sudo $0' pour lancer le script."
    exit 1
fi

# Vérification du répertoire de lancement
current_dir=$(pwd)
if [ "${current_dir##*/}" != "Nidus" ]; then
    echo "Le script doit être exécuté à partir du répertoire /home/Nidus."
    
    # Copie du script au bon endroit
    cp "$0" /home/Nidus/install.sh
    chmod +x /home/Nidus/install.sh
    
    # Exécution du script depuis le répertoire Nidus
    (cd /home/Nidus && sudo -u Nidus ./install.sh)
    
    exit 1
fi

# Écho pour indiquer le début du script
echo "Début de l'installation..."

# Changement du nom d'hôte en Nidus
echo "Changement du nom d'hôte en Nidus..."
sudo hostnamectl set-hostname Nidus

# Activation des services du Raspberry Pi OS nécessaires pour le projet
echo "Activation des services nécessaires..."
sudo systemctl enable ssh
if [ $? -eq 0 ]; then
    echo "Service SSH activé avec succès."
else
    echo "Erreur lors de l'activation du service SSH."
fi

sudo systemctl enable mosquitto
if [ $? -eq 0 ]; then
    echo "Service Mosquitto activé avec succès."
else
    echo "Erreur lors de l'activation du service Mosquitto."
fi

sudo systemctl enable nodered
if [ $? -eq 0 ]; then
    echo "Service Node-Red activé avec succès."
else
    echo "Erreur lors de l'activation du service Node-Red."
fi

# Création des clés SSH si elles n'existent pas déjà
if [ ! -f /home/Nidus/.ssh/id_rsa ]; then
    echo "Création des clés SSH..."
    sudo -u Nidus ssh-keygen -t rsa -b 2048 -f /home/Nidus/.ssh/id_rsa -N ""
    if [ $? -eq 0 ]; then
        echo "Clés SSH créées avec succès."
    else
        echo "Erreur lors de la création des clés SSH."
    fi
else
    echo "Les clés SSH existent déjà, aucune action requise."
fi

# Mise à jour de Node.js et installation de Node-Red
echo "Mise à jour de Node.js et installation de Node-Red..."
sudo -u Nidus bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
if [ $? -eq 0 ]; then
    echo "Node.js et Node-Red installés avec succès."
    
    # Installation des dépendances de Node-Red
    echo "Installation des dépendances de Node-Red..."
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-dashboard@3.5.0
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-contrib-pdfmake2@2.0.0
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-contrib-mqtt-plus@0.0.7
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-contrib-fs@1.4.1
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-contrib-easybotics-ina219-sensor@0.7.6
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-contrib-chart-image@1.2.0
    sudo -u Nidus npm install --prefix /home/Nidus/node-red-node-base64@0.3.0
else
    echo "Erreur lors de l'installation de Node.js et Node-Red, les dépendances de Node-Red ne seront pas installées."
fi

# Installation de Java JDK
echo "Installation de Java JDK..."
sudo apt install default-jdk
if [ $? -eq 0 ]; then
    echo "Java JDK installé avec succès."
else
    echo "Erreur lors de l'installation de Java JDK."
fi

# Création du répertoire .gatling
echo "Création du répertoire .gatling..."
sudo -u Nidus mkdir /home/Nidus/.gatling
if [ $? -eq 0 ]; then
    echo "Répertoire .gatling créé avec succès."
else
    echo "Erreur lors de la création du répertoire .gatling."
fi

# Téléchargement de Gatling
echo "Téléchargement de Gatling..."
sudo -u Nidus wget -O /home/Nidus/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip
if [ $? -eq 0 ]; then
    echo "Gatling téléchargé avec succès."
else
    echo "Erreur lors du téléchargement de Gatling."
fi

# Extraction de Gatling
echo "Extraction de Gatling..."
sudo -u Nidus unzip /home/Nidus/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip -d /home/Nidus/.gatling/
if [ $? -eq 0 ]; then
    echo "Gatling extrait avec succès."
else
    echo "Erreur lors de l'extraction de Gatling."
fi

# Installation de Mosquitto
echo "Installation de Mosquitto..."
sudo apt install mosquitto
if [ $? -eq 0 ]; then
    echo "Mosquitto installé avec succès."
else
    echo "Erreur lors de l'installation de Mosquitto."
fi

# Configuration de Mosquitto
echo "Configuration de Mosquitto..."
sudo tee /etc/mosquitto/mosquitto.conf > /dev/null <<EOL
listener 1883
allow_anonymous true
EOL

# Redémarrage de Mosquitto pour appliquer la configuration
echo "Redémarrage de Mosquitto..."
sudo service mosquitto restart
if [ $? -eq 0 ]; then
    echo "Mosquitto redémarré avec succès."
else
    echo "Erreur lors du redémarrage de Mosquitto."
fi


# Écho pour indiquer la fin du script
echo "Installation de Gatling, Mosquitto, Node-Red et ses dépendances terminée."
