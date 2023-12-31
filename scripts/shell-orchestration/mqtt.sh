#!/bin/bash

# Docker container adı
#CONTAINER_NAME="mqtt-broker-service "

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
        docker run --rm -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_pub -h mqtt-broker -t test/topic -m "Hello World" 
}

listen_subscribers() {
    echo "MQTT subscriber'ları dinleme modunda..."
docker run -d -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_sub -h 127.0.0.1 -t test/nem  
}
while true; do
    check_subs
    sleep 5
    # MQTT broker'ını kontrol et
    # check_broker
    # MQTT publisher'lara mesaj gönder
    send_message
    # MQTT subscriber'ları dinle
    # 5 saniye bekleyerek tekrar gönder
done

#   docker run  -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_sub -h mqtt-broker -t test/topic   
#   docker run  -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_sub -h mqtt-broker-2 -t test/topic 
#   docker run  -d -rm --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_sub -h haproxy-lb -p 1883 -t test/nem
#   docker run --rm -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_pub -h haproxy-lb -p 1884 -t test/topic -m "Hello World"

  docker run  -d -it --network getstartedLab_mqtt-net eclipse-mosquitto mosquitto_sub -h haproxy-lb-swarm -p 1883 -t test/nem
 docker run  --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_pub -h haproxy-lb-swarm -p 1883 -t test/nem -m "Hello World"