@echo off
:: Remove all containers (running and stopped)
wsl -e bash -c "docker rm -f $(docker ps -aq)"

:: Pull the latest version of the image
wsl -e bash -c "docker pull ghcr.io/theartofficial/artofficialstudio:latest"

:: Create the storage location
:: Remember to Change /home/theartofficial/comfyvol to the path in your WSL subsystem that you want to use!
wsl -e bash -c "mkdir /home/theartofficial/comfyvol"

:: Run the container
:: Remember to Change /home/theartofficial/comfyvol to the path in your WSL subsystem that you want to use!
wsl -e bash -c "docker run --gpus all --shm-size=32g -it -p 80:80 -v /home/theartofficial/comfyvol:/workspace ghcr.io/theartofficial/artofficialstudio:latest"
