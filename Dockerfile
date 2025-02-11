FROM frolvlad/alpine-mono

LABEL maintainer "Mark <willietgwb@gmail.com>"

COPY start.sh /start
# Add and install mono
ENV TSHOCK_VERSION=4.5.17
ENV TERRARIA_VERSION=1.4.3.6

RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

RUN mkdir /world /config /logs /plugins /tshock && \
        cd /tshock && \
        wget https://github.com/NyxStudios/TShock/releases/download/v${TSHOCK_VERSION}/TShock${TSHOCK_VERSION}_Terraria_${TERRARIA_VERSION}.zip && \
        unzip TShock${TSHOCK_VERSION}_Terraria_${TERRARIA_VERSION}.zip && \
        rm TShock${TSHOCK_VERSION}_Terraria_${TERRARIA_VERSION}.zip && \
        chmod +x /tshock/TerrariaServer.exe && \
        chmod +x /start

# External data
VOLUME ["/world", "/config", "/logs", "/plugins"]

# Back to the working directory for the server
WORKDIR /tshock

EXPOSE 7777

ENTRYPOINT ["/start"]

