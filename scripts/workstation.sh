
# podman run -d -it --network workstation-test_mqtt-network eclipse-mosquitto mosquitto_sub -h mqtt-broker-1 -p 5005 -t test/nem

seq 1 1000 | parallel -j 8 podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m '"parallel World {}"'
