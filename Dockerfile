FROM rayproject/ray:latest-cpu

RUN sudo apt update
RUN sudo apt install net-tools
RUN sudo apt install -y iputils-ping
RUN sudo apt install telnet
RUN sudo apt install -y curl
RUN sudo curl -s https://install.zerotier.com | sudo bash

