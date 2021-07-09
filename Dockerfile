FROM frolvlad/alpine-mono

MAINTAINER Mark <willietgwb@gmail.com>

COPY start.sh /start
# Add and install mono
ENV TSHOCK_VERSION=4.5.4
ENV TERRARIA_VERSION=1.4.2.3

RUN mkdir /world /config /logs /plugins /tshock && \
        cd /tshock && \
        wget https://github.com/NyxStudios/TShock/releases/download/v4.5.4/TShock4.5.4_Terraria1.4.2.3.zip && \
        unzip TShock4.5.4_Terraria1.4.2.3.zip && \
        rm TShock4.5.4_Terraria1.4.2.3.zip && \
        chmod +x /tshock/TerrariaServer.exe && \
        chmod +x /start

# External data
VOLUME ["/world", "/config", "/logs", "/plugins"]

# Back to the working directory for the server
WORKDIR /tshock

EXPOSE 7777

ENTRYPOINT ["/start"]
