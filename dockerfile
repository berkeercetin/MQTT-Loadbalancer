# Use the official nginx image as the base image
FROM nginx

# Copy the nginx source code to the /usr/src directory
COPY nginx-1.25.3.tar.gz /usr/src/

# Install the necessary dependencies for building nginx
RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dev \
    libssl-dev

# Change to the /usr/src directory and extract the nginx source code
WORKDIR /usr/src
RUN tar -xzvf nginx-1.25.3.tar.gz

# Change to the nginx source code directory and configure nginx with the stream and mqtt preread modules
WORKDIR /usr/src/nginx-1.25.3
RUN ./configure --with-stream --with-stream_mqtt_preread_module

# Compile and install nginx
RUN make && make install

# Copy the nginx configuration file to the /usr/local/nginx/conf directory
COPY nginx.conf /usr/local/nginx/conf/

# Expose the port 12345 for the stream server
EXPOSE 12345

# Start nginx in the foreground
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
