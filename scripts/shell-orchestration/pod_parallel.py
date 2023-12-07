import subprocess
import concurrent.futures

def start_container(i):
    subprocess.run(["podman", "run", "--rm", "--network", "mosquitto-broker-no-swarm_mqtt-network", "eclipse-mosquitto", "mosquitto_pub", "-h", "mqtt-broker-1", "-p", "5005", "-t", "test/nem", "-m", f"Hello World {i}"])

with concurrent.futures.ThreadPoolExecutor(max_workers=100) as executor:
    executor.map(start_container, range(1, 101))
