#-*-coding:utf-8-*- #Türkçe karakter kullanabilmek için tanımlıyoruz.
import paho.mqtt.client as mqtt
def on_message (client , userdata , msg):
    print("MQTT Broker'dan Gelen Mesajın Konusu: " + msg.topic + " "+ "MQTT Broker'dan Gelen Mesaj: " + str(msg.payload))
        
def on_connect(client, userdata, flags, rc):
    if (rc == 0): 
        client.subscribe(topic = "test/sicaklik" , qos = 0)
        print("İstemci sicaklik konusuna abone olmuştur.")
    else:
        client.loop.stop()
                                                 
def on_disconnect(client , userdata , flags , rc):
    if rc != 0:
        client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
client = mqtt.Client(client_id = "" , userdata = None , transport = "tcp")
#Callbacks (Geri Çağrılar) fonksiyonlarını yazıyoruz.
client.on_disconnect = on_disconnect  
client.on_connect    = on_connect
client.on_message    = on_message
client.connect(host = "localhost" , port = 1883 , keepalive = 60 , bind_address = "")
client.loop_forever()