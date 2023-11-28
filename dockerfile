FROM ubuntu:latest

# Gerekli paketleri yükleme
RUN apt-get update && apt-get install -y \
    mosquitto \
    && rm -rf /var/lib/apt/lists/*

# Betiği kopyala
COPY your_script.sh /usr/local/bin/your_script.sh

# Çalıştırma izinleri verme
RUN chmod +x /usr/local/bin/your_script.sh

# Betiği çalıştır
CMD ["/usr/local/bin/your_script.sh"]
