podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m "Hello World"
podman run -d -it --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_sub -h mqtt-broker-1 -p 5005 -t test/nem


seq 1 200 | xargs -n 1 -P 5 -I {} podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m "xargs World"


seq 1 200 | parallel -j 8 podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m '"parallel World {}"'

seq 1 200 | parallel podman run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m '"parallel World {}"'