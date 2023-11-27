#!/bin/bash

# MQTT broker'ı başlat
docker run -d -p 1883:1883 eclipse-mosquitto

# MQTT subscriber ve publisher sayıları
SUB_COUNT=500
PUB_COUNT=500

# MQTT broker'ın IP adresi
BROKER_IP="localhost"

# Subscriber'ları başlat
for ((i=1; i<=$SUB_COUNT; i++))
do
    docker run -d --name=subscriber_$i eclipse-mosquitto mosquitto_sub -h $BROKER_IP -t topic/$i
done

# Publisher'ları başlat ve her 60 saniyede bir 60 farklı publisher tetikle
while true
do
    for ((i=1; i<=60; i++))
    do
        PUB_INDEX=$(( (RANDOM % $PUB_COUNT) + 1 ))
        docker run -d --name=publisher_$PUB_INDEX eclipse-mosquitto sh -c "mosquitto_pub -h $BROKER_IP -t topic/$PUB_INDEX -m 'Message from publisher_$PUB_INDEX'"
    done

    sleep 60
done
