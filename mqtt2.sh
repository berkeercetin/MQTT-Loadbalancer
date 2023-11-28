#!/bin/bash

# MQTT broker'ı başlat
docker run -d -p 1883:1883 eclipse-mosquitto

# MQTT subscriber ve publisher sayıları
SUB_COUNT=10
PUB_COUNT=10

# MQTT broker'ın IP adresi
BROKER_IP="localhost"

# Subscriber'ları başlat
for ((i=1; i<=$SUB_COUNT; i++))
do
    echo "Subscriber $i başlatılıyor..."
    #docker run -d --name=subscriber_$i eclipse-mosquitto mosquitto_sub -h $BROKER_IP -t topic/$i
    docker run -d --rm --name=subscriber_$i --network host eclipse-mosquitto mosquitto_sub -h  mqtt-broker-service -t test/topic

done

# Publisher'ları başlat ve her 60 saniyede bir 10 farklı publisher tetikle
while true
do
    sleep 10

    for ((i=1; i<=6; i++))
    do
    echo "Publisher $i başlatılıyor..."
        PUB_INDEX=$(( (RANDOM % $PUB_COUNT) + 1 ))
     docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto eclipse-mosquitto mosquitto_pub -h mqtt-broker-service -t test/topic -m "Hello MQTT"    # docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto -e INTERVAL=30 -e MESSAGE="'$RANDOM'" eclipse-mosquitto mosquitto_pub -h eclipse-mosquitto -t test/topic -m "$MESSAGE"
     #   docker run -d --name=publisher_$PUB_INDEX eclipse-mosquitto sh -c "mosquitto_pub -h $BROKER_IP -t topic/$PUB_INDEX -m 'Message from publisher_$PUB_INDEX'"
    done

    sleep 60
done
