#-*-coding:utf-8-*- #Türkçe karakter kullanabilmek için tanımlıyoruz.
import time
import paho.mqtt.client as mqtt
                                                    
def on_disconnect(client , userdata , flags , rc):
    if rc != 0:
        client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
client = mqtt.Client(client_id = "" , userdata = None , transport = "tcp")
client.on_disconnect = on_disconnect #Callback (Geri Çağrı) fonksiyonu
client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
for i in range(1, 111):
    payload = str(i)
    client.publish(topic="test/nem", payload=payload, qos=0)
    print(f"Nem iletimi gerçekleştirildi. Payload: {payload}")
    time.sleep(1)  # Add a delay of 1 second between each message
client.loop_forever()