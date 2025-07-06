@echo off
wsl -e bash -c "docker run --gpus all --shm-size=32g -it -p 80:80 -v /home/theartofficial/comfyvol:/workspace ghcr.io/theartofficial/artofficialstudio:latest"
REM Change /home/theartofficial/comfyvol to the path in your WSL subsystem that you want to use!
