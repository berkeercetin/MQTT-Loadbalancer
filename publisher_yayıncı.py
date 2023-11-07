#-*-coding:utf-8-*- #Türkçe karakter kullanabilmek için tanımlıyoruz.
import paho.mqtt.client as mqtt
                                                    
def on_disconnect(client , userdata , flags , rc):
    if rc != 0:
        client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
client = mqtt.Client(client_id = "" , userdata = None , transport = "tcp")
client.on_disconnect = on_disconnect #Callback (Geri Çağrı) fonksiyonu
client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
client.publish(topic = "merhaba" , payload = "naber" , qos = 2)
print("Mesaj iletimi gerçekleştirildi.")
client.loop_forever()