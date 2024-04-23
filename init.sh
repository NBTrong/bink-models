docker stop ray_container
docker rm ray_container

# Remove bink-worker image
docker rmi bink-worker

# Build bink-worker image
docker build -t bink-worker .
docker run -it -d --name "ray_container" --network=host --rm --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --ulimit nofile=65536:65536 bink-worker
docker logs -f ray_container