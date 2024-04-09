# Python command
pyenv install 3.9.18
pyenv global 3.10.12
python3 -m venv bink-env
source bink-env/bin/activate
deactivate

# Ray luncher command
ray dashboard example-full.yaml
ray submit example-full.yaml test.py
ray attach example-full.yaml
ray start --address=172.27.224.1:6379 --object-manager-port=8076 --object-store-memory=78643200 --num-cpus=1 --dashboard-agent-listen-port=9001
ray up example-full.yaml
ray down example-full.yaml

# Docker hub
docker build -t welcome-to-docker .
docker tag myimage:v1.0 myusername/myrepo:v1.0
docker login
docker push myusername/myrepo:v1.0

# Worker command
docker run -it -d --name "ray_container" --network=host --rm --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --ulimit nofile=65536:65536 rayproject/ray:latest-cpu bash
sudo apt update
sudo apt install net-tools
sudo apt install iputils-ping
sudo apt install telnet
sudo apt install curl

# zerotier-cli
curl -s https://install.zerotier.com | sudo bash

zerotier-one -d
zerotier-cli status
zerotier-cli join
zerotier-cli leave
zerotier-cli listnetworks
zerotier-cli info -j

