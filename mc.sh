#!/bin/bash

read -p "Entrez le nom du dossier pour le serveur (ex: mc_test) :" DIR
serv_path=~/"$DIR"
mkdir -p "$serv_path"

check_java=$(java --version)


if [[ $check_java == *"not found"* ]];then
    echo "Installation de java..."
    sudo apt-get install -y default-jre
fi

check_screen=$(screen --version)

if [[ $check_screen == *"not found"* ]];then
    echo "Installation de screen..."
    sudo apt-get install -y screen
fi

export SCREENDIR=$HOME/.screen 
mkdir -p $SCREENDIR
chmod 700 $SCREENDIR

if [ -f "$serv_path/server.jar" ]; then
    echo "Le serveur existe déjà dans $serv_path"
else 

    echo "choix version"
    choix="Choix (1-5) :"

    select i in "1.21.11" "1.20.6" "1.19.4" "1.18.2" "1.8.9" # versions
    do 
        case $i in
        "1.21.11")
            URL="https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar"
            break ;;
        "1.20.6")
            URL="https://piston-data.mojang.com/v1/objects/145ff0858209bcfc164859ba735d4199aafa1eea/server.jar"
            break ;;
        "1.19.4")
            URL="https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar"
            break ;;
        "1.18.2")
            URL="https://piston-data.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar"
            break ;;
        "1.8.9")
            URL="https://launcher.mojang.com/v1/objects/b58b2ceb36e01bcd8dbf49c8fb66c55a9f0676cd/server.jar"
            break ;;
        *) echo "Choix invalide";;
        esac
    done

    echo "Téléchargement de la version $opt dans $serv_path..."
    cd "$serv_path"
    wget "$URL"


    echo "Initialisation EULA..." 
    java -Xmx1G -Xms1G -jar server.jar nogui &
    java_PID=$! 

    sleep 20
    kill $java_PID

    echo "eula=true" > eula.txt
    cd ..
fi

run(){
    if screen -list | grep -q "minecraft"; then
        return 0 
    else
        return 1 
    fi
}

status(){

    if ( run ); then
        echo "Running"
    else
        echo "not run"
    fi
}

start_serv() {
    if run;then
        echo "Le serveur est déjà démarré."
    else

        cd "$serv_path"
        screen -dmS minecraft java -Xmx1024M -Xms1024M -jar server.jar nogui
        echo "Serveur lancer dans un screen"
    fi
}

stop_serv() {
    if run; then
        screen -S minecraft -p 0 -X stuff "stop$(printf '\r')" 
        echo "Commande stop. Attente..."

        while pgrep -u $USER -f server.jar > /dev/null; do sleep 1; done 
        echo "Serveur bien arrêté."
    else
        echo "Le serveur n'est pas démarré."
    fi
}


case "$1" in 
    start) 
        start_serv
        ;;
        
    stop) 
        stop_serv
        ;;

    restart)
        start_serv
        stop_serv
        start_serv
        ;;

    status)
        status;;

    log)  
        if [ -f "$serv_path/logs/latest.log" ]; then
            tail -f "$serv_path/logs/latest.log"
        else
            echo "Fichier de logs introuvable."
        fi 
        ;;

    *) 
        echo "Usage: $0 {start|stop|status|restart|log}"
        exit 1
        ;;
esac

exit 0