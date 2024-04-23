FROM rayproject/ray:latest-cpu

RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
        net-tools \
        iputils-ping \
        telnet \
        curl && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sudo curl -s https://install.zerotier.com | sudo bash

COPY entrypoint.sh /entrypoint.sh

COPY . .

# Make the entrypoint script executable
RUN sudo chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]