# for ((i=1; i<=100; i++)); do
# podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m "Hellos ${i} " &
# done

# # Tüm arka plan işlemlerinin bitmesini bekle
# wait

for ((i=1; i<=100; i++)); do
podman run  --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m "Hello World ${i} " &

done

