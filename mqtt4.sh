#!/bin/bash

# MQTT broker'ı başlat

# # MQTT yayıncıları başlat
# for i in {1..10}
# do
#   docker run -d --name mqtt-publisher-$i eclipse-mosquitto mosquitto_pub -h mqtt-broker -t test/topic -m "Hello from Publisher $i"
# done
# MQTT aboneleri başlat
# for i in {1..10}
# do
# docker run -d -it --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_sub -h mqtt-broker -t test/topic  
# done


while true
do
    # Sleep for 3 seconds
    sleep 3

    # Generate 30 unique random numbers between 1 and 500 without shuf
    selected_publishers=($(seq 1 500 | awk 'BEGIN{srand();} {print int(rand()*500)+1}' | sort -n | uniq | head -n 30))

    for publisher_index in "${selected_publishers[@]}"
    do
        echo "Publisher $publisher_index başlatılıyor..."
        docker run --rm -d --network getstartedlab_mqtt-net eclipse-mosquitto mosquitto_pub -h mqtt-broker -t test/topic -m "Message from publisher_$publisher_index"
    done
done





