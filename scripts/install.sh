#!/bin/bash
echo "Ce script va installer Gatling, Mosquitto, Node-Red et ses dépendances, et tout cela prendras un certain temps donc allez vous chercher un café."

# Nom d'utilisateur et répertoire d'utilisation
user="tobby"
user_home="/home/$user"

# Fonction pour exécuter une commande en silence (redirection de la sortie)
run_command_silently() {
    "$@" > /dev/null 2>&1
    return $?
}
echo ""
# Changement du nom d'hôte en Nidus
echo "Changement du nom d'hôte en Nidus..."
hostnamectl set-hostname Nidus
echo ""
# Mise à jour de Node.js et installation de Node-Red
echo "Mise à jour de Node.js et installation de Node-Red..."
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-install --confirm-root --confirm-pi --no-init
if [ $? -eq 0 ]; then
   echo "Node.js et Node-Red installés avec succès."
else
   echo "Erreur lors de l'installation de Node.js et Node-Red."
   exit 1
fi
echo ""

# Instalation de Git
echo "Installation de Git..."
run_command_silently sudo apt install git -y
if [ $? -eq 0 ]; then
    echo "Git installé avec succès."
else
    echo "Erreur lors de l'installation de Git."
fi
echo ""

# Activation des services du Raspberry Pi OS nécessaires pour le projet
echo "Activation des services nécessaires..."
sudo systemctl enable ssh
if [ $? -eq 0 ]; then
    echo "Service SSH activé avec succès."
else
    echo "Erreur lors de l'activation du service SSH."
fi
echo ""
sudo raspi-config nonint do_i2c 0
# Création des clés SSH si elles n'existent pas déjà
if [ ! -f $user_home/.ssh/id_rsa ]; then
    echo "Création des clés SSH..."
    sudo -u $user ssh-keygen -t rsa -b 2048 -f $user_home/.ssh/id_rsa -N ""
    if [ $? -eq 0 ]; then
        echo "Clés SSH créées avec succès."
    else
        echo "Erreur lors de la création des clés SSH."
    fi
else
    echo "Les clés SSH existent déjà, aucune action requise."
fi
echo ""
# Installation de Java JDK
echo "Installation de Java JDK..."
run_command_silently sudo apt install default-jdk -y
if [ $? -eq 0 ]; then
    echo "Java JDK installé avec succès."
else
    echo "Erreur lors de l'installation de Java JDK."
fi
echo ""
# Création du répertoire .gatling
echo "Création du répertoire .gatling..."
sudo mkdir $user_home/.gatling
if [ $? -eq 0 ]; then
    echo "Répertoire .gatling créé avec succès."
else
    echo "Erreur lors de la création du répertoire .gatling."
fi
echo ""
# Téléchargement de Gatling
echo "Téléchargement de Gatling..."
run_command_silently sudo wget -O $user_home/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip
if [ $? -eq 0 ]; then
    echo "Gatling téléchargé avec succès."
else
    echo "Erreur lors du téléchargement de Gatling."
fi
echo ""
# Extraction de Gatling
echo "Extraction de Gatling..."
run_command_silently sudo unzip $user_home/.gatling/gatling-charts-highcharts-bundle-3.9.5-bundle.zip -d $user_home/.gatling/
if [ $? -eq 0 ]; then
    echo "Gatling extrait avec succès."
else
    echo "Erreur lors de l'extraction de Gatling."
fi
echo ""
# Installation de Mosquitto
echo "Installation de Mosquitto..."
run_command_silently sudo apt install mosquitto -y
if [ $? -eq 0 ]; then
    echo "Mosquitto installé avec succès."
else
    echo "Erreur lors de l'installation de Mosquitto."
fi
echo ""
# Configuration de Mosquitto
echo "Configuration de Mosquitto..."
sudo tee /etc/mosquitto/mosquitto.conf > /dev/null <<EOL
listener 1883
allow_anonymous true
EOL
echo ""
# Redémarrage de Mosquitto pour appliquer la configuration
echo "Redémarrage de Mosquitto..."
sudo service mosquitto restart
if [ $? -eq 0 ]; then
    echo "Mosquitto redémarré avec succès."
else
    echo "Erreur lors du redémarrage de Mosquitto."
fi
echo ""
# Activation du service Mosquitto
echo "Activation du service Mosquitto..."
systemctl enable mosquitto
if [ $? -eq 0 ]; then
    echo "Service Mosquitto activé avec succès."
else
    echo "Erreur lors de l'activation du service Mosquitto."
fi
echo ""
# Acfivation du service Node-Red
echo "Activation du service Node-Red..."
sudo systemctl enable nodered.service
if [ $? -eq 0 ]; then
    echo "Service Node-Red activé avec succès."
else
    echo "Erreur lors de l'activation du service Node-Red."
fi
echo ""
# Installation des dépendances de Node-Red
echo "Installation des dépendances de Node-Red..."
echo ""
echo ""
echo "Installation des themes..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict @node-red-contrib-themes/theme-collection
echo "Installation du dashboard..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-dashboard@3.6.0
echo "Installation de pdfmake2..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-contrib-pdfmake2@2.0.0
echo "Installation de mqtt-plus..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-contrib-mqtt-plus@0.0.7
echo "Installation de fs..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-contrib-fs@1.4.1
echo "Installation de INA219 sensor..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-contrib-easybotics-ina219-sensor@0.7.6
echo "Installation de chart image..."
echo ""
run_command_silently sudo apt-get install libcairo2-dev libjpeg-dev libgif-dev build-essential g++ -y
run_command_silently sudo apt-get install build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev -y
run_command_silently sudo apt-get install libpixman-1-dev libxcb-composite0-dev -y
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-contrib-chart-image
echo "Installation de base64..."
echo ""
sudo npm install -g --unsafe-perm node-red --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --omit=dev --engine-strict node-red-node-base64
echo ""
echo ""

# Écho pour indiquer la fin du script
echo "Installation de Gatling, Mosquitto, Node-Red et ses dépendances terminée."
echo ""
echo "Initialisation du de Node-Red..."
echo ""
node-red admin init
echo ""
echo "Redémarrage de Node-Red..."
echo ""
sudo systemctl restart nodered.service
echo ""
echo "Installation terminée."
echo ""
echo "Vous pouvez maintenant vous connecter à Node-Red à l'adresse suivante : http://localhost:1880"
