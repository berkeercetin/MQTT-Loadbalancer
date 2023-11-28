#!/bin/bash

# Docker servis adı
SERVICE_NAME="mqtt-broker-service"

# MQTT broker servisini başlatma fonksiyonu
start_broker_service() {
    echo "MQTT broker servisi başlatılıyor..."
    docker service create --name $SERVICE_NAME --replicas 3 -p 1883:1883 eclipse-mosquitto
}

check_broker_service() {
    if [ "$(docker service ls --filter "name=$SERVICE_NAME" --format '{{.Replicas}}')" == "3/3" ]; then
        echo "MQTT broker servisi çalışıyor."
    else
        echo "MQTT broker servisi çöktü. Yeniden başlatılıyor..."
        start_broker_service
    fi
}

send_message() {
    echo "Mesaj Gönderildi..."
    docker run -d --rm --name mqtt-publisher -h localhost eclipse-mosquitto mosquitto_pub -h $SERVICE_NAME -t test/topic -m "Hello MQTT"
}

listen_subscribers() {
    echo "MQTT subscriber'ları dinleme modunda..."
    docker run -d --rm --name mqtt-subscriber -h localhost eclipse-mosquitto mosquitto_sub -h $SERVICE_NAME -t test/topic
}

# Ana döngü
while true; do
    sleep 5

    # MQTT broker servisini kontrol et
    check_broker_service

    # MQTT publisher'lara mesaj gönder
    send_message

    # MQTT subscriber'ları dinle
    listen_subscribers

    # 5 saniye bekleyerek tekrar gönder
done
