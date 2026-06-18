DIVISION="313"
IMAGE_NAME="tp-div_${DIVISION}"

read -p "Ingresar nombre de usuario de Docker hub: " DOCKER_USER

docker build -t "${IMAGE_NAME}:latest" .
docker tag "${IMAGE_NAME}:latest" "${DOCKER_USER}/${IMAGE_NAME}:latest"
docker login
docker push "${DOCKER_USER}/${IMAGE_NAME}:latest"

#sudo apt install htop tmux speedtest-cli -y