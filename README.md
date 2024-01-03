# MQTT-Loadbalancer & Parallel Docker Containers
In this project, the system was initially tested with GNU/Parallel to run a large number of virtual IoT devices (~500) in parallel. As a solution for messages establishing real-time communication among IoT devices, a low-cost MQTT Broker cluster was designed to provide usability, scalability, and reliability.

# Installation
The system requires the installation of Docker and Docker Compose. Alternatively, Podman can be used if preferred.
Additionally, there is a version with swarm mode for the brokers. It can be used with or without swarm as desired.


## MQTT Broker Cluster Installation

If you want to use Swarm, you should use "mosquitto-broker-swarm" inside /containers/; if not, you should use "mosquitto-broker-no-swarm".
After entering the folder, execute the following command:

Swarm mode : 
```bash
docker stack deploy --compose-file docker-compose.yml MQTTLoadBalancer
```

No Swarm : 
```bash
docker-compose up -d
```

This commands creates the cluster.

## HA-Proxy MQTT Loadbalancer Installation

Navigate to MQTT-Loadbalancer/containers/ha-proxy/ folder and run the following command.
Important Note: Don't forget to make the necessary configurations you want from haproxy.cfg and create a new image using DockerFile!

```bash
docker-compose up -d
```


## Parallel Publisher Containers
Run 500 containers in parallel using the following command.

```bash
seq 1 500 | parallel -j 8 docker run --rm --network mosquitto-broker-no-swarm_mqtt-network eclipse-mosquitto mosquitto_pub -h mqtt-broker-1 -p 5005 -t test/nem -m '"parallel World {}"'
```
Important note: Don't forget to adjust the number of cores and network name according to your setup in the -j parameter.

# Extras
The "Scripts" folder contains orchestration and test tools written in both Python and Shell.

































