import paho.mqtt.client as mqtt

haproxy_address = "localhost"  # veya 127.0.0.1
port = 1884
topic = "example/topic"

def on_message(client, userdata, message):
    print(f"Received message: {message.payload.decode()}")

client = mqtt.Client("subscriber")
client.on_message = on_message

client.connect(haproxy_address, port)
client.subscribe(topic)

print("Waiting for messages. To exit, press Ctrl+C.")
client.loop_forever()
