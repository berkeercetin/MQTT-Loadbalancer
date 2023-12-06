# #!/bin/bash

# # MQTT broker'ı başlat
# docker run -d -p 1883:1883 eclipse-mosquitto

# # MQTT subscriber ve publisher sayıları
# SUB_COUNT=10
# PUB_COUNT=10

# # MQTT broker'ın IP adresi
# BROKER_IP="localhost"

# # Subscriber'ları başlat
# for ((i=1; i<=$SUB_COUNT; i++))
# do
#     echo "Subscriber $i başlatılıyor..."
#     #docker run -d --name=subscriber_$i eclipse-mosquitto mosquitto_sub -h $BROKER_IP -t topic/$i
#     docker run -d --rm --name=subscriber_$i --network host eclipse-mosquitto mosquitto_sub -h  mqtt-broker-service -t test/topic

# done

# # Publisher'ları başlat ve her 60 saniyede bir 10 farklı publisher tetikle
# while true
# do
#     sleep 10

#     for ((i=1; i<=6; i++))
#     do
#     echo "Publisher $i başlatılıyor..."
#         PUB_INDEX=$(( (RANDOM % $PUB_COUNT) + 1 ))
#      docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto eclipse-mosquitto mosquitto_pub -h mqtt-broker-service -t test/topic -m "Hello MQTT"    # docker run -d --rm --name mqtt-publisher --link mqtt-broker-shell:eclipse-mosquitto -e INTERVAL=30 -e MESSAGE="'$RANDOM'" eclipse-mosquitto mosquitto_pub -h eclipse-mosquitto -t test/topic -m "$MESSAGE"
#      #   docker run -d --name=publisher_$PUB_INDEX eclipse-mosquitto sh -c "mosquitto_pub -h $BROKER_IP -t topic/$PUB_INDEX -m 'Message from publisher_$PUB_INDEX'"
#     done

#     sleep 60
# done




#   for i in {1..10}
#   do
#      docker run -d -it --name mqtt-subscriber-sicaklik-${i} --network getstartedLab_mqtt-net eclipse-mosquitto mosquitto_sub -h 127.0.0.1 -p 1883 -t test/nem
#   done

#   for i in {1..100}
#   do
#   docker run --rm -it --network getstartedLab_mqtt-net eclipse-mosquitto mosquitto_pub -h haproxy-lb -p 1883 -t test/sicaklik -m "15 derece"
#   sleep 2
#   docker run --rm -it --network getstartedLab_mqtt-net eclipse-mosquitto mosquitto_pub -h haproxy-lb -p 1883 -t test/nem -m "nem yuksek"
#  done

# for i in {4..25}
# do
#   #docker run --rm -d --network  mosquitto_mqtt-network  eclipse-mosquitto mosquitto_pub -h haproxy-lb -p 1883 -t test/sicaklik -m "15 derece" &
#   docker run --name no_swarm_messager${i}  --network  mosquitto_mqtt-network eclipse-mosquitto mosquitto_pub -h haproxy-lb -p 1883 -t test/nem -m "nem yuksek"
#   #docker run --rm -d --network  getstartedLab_mqtt-net eclipse-mosquitto mosquitto_pub -h haproxy-lb-swarm -p 1883 -t test/nem -m "nem yuksek" 
# done


# Tüm işlemlerin bitmesini bekleyin
#wait

for i in {1..25}; do
  docker start no_swarm_messager${i}
done
