import paho.mqtt.client as mqtt
import time

haproxy_address = "localhost"  # veya 127.0.0.1
port = 1884
topic = "example/topic"

client = mqtt.Client("publisher")

client.connect(haproxy_address, port)

for i in range(5):
    message = f"Hello, message {i}"
    client.publish(topic, message)
    print(f"Published: {message}")
    time.sleep(1)

client.disconnect()
