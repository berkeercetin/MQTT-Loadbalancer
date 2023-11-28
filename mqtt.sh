#!/bin/bash

# Docker container adı
CONTAINER_NAME="mqtt-broker-service "

# # MQTT broker container'ını başlatma fonksiyonu
#  start_broker() {
#      echo "MQTT broker başlatılıyor..."
#      docker run -d --name $CONTAINER_NAME -p 1883:1883 eclipse-mosquitto
#  }

# check_broker() {
#     if [ "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)" == "true" ]; then
#         echo "MQTT broker çalışıyor."
#     else
#         echo "MQTT broker çöktü. Yeniden başlatılıyor..."
#         start_broker
#     fi
# }

check_subs() {
    if [ "$(docker inspect -f '{{.State.Running}}' mqtt-subscriber 2>/dev/null)" == "true" ]; then
        echo "MQTT Sub çalışıyor."
    else
        echo "MQTT Sub çöktü. Yeniden başlatılıyor..."
        listen_subscribers
    fi
}

send_message() {
     echo "Mesaj Gönderildi..." 
     docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto eclipse-mosquitto mosquitto_pub -h eclipse-mosquitto -t test/topic -m "Hello MQTT"    # docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto -e INTERVAL=30 -e MESSAGE="'$RANDOM'" eclipse-mosquitto mosquitto_pub -h eclipse-mosquitto -t test/topic -m "$MESSAGE"
}

listen_subscribers() {
    echo "MQTT subscriber'ları dinleme modunda..."
    docker run -d --rm --name mqtt-subscriber --network host eclipse-mosquitto mosquitto_sub -h localhost -t test/topic
}
# Ana döngü
while true; do
sleep 5
    # MQTT broker'ını kontrol et
    # check_broker

    # MQTT publisher'lara mesaj gönder
    send_message

    # MQTT subscriber'ları dinle
    check_subs

    # 5 saniye bekleyerek tekrar gönder
    
done

