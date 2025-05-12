# **ArtOfficial Studio: Docker Container Installation Guide** 

## **Preface** 

Welcome to **ArtOfficial Studio** — a powerful Docker-based container application designed to make cutting-edge AI tools and model training accessible to everyone. The first-time set-up is simple, just install docker, and then it is only one click to pull all of the latest models, workflows, and ComfyUI features. Whether you’re an artist, researcher, or enthusiast, this tool offers:

* Works on Windows, Linux, or Cloud!
* One-click access to the **latest AI models**  
* **SAGEATTENTION**, **TORCH COMPILE**, and **Animated Previews** just work\!
* Simple interfaces for running various AI Tools
  - ComfyUI
  - Kohya_ss
  - diffusion-pipe
  - FluxGym
* Easy setup of **LoRA training tools**
* JupyterLab for full filesystem control!  
* Persistent storage for your models while always using the **latest software updates**

No technical background? No worries. This guide is written to walk you through each step from scratch. If you have any issues, chatGPT is your friend\! It is probably better at answering your questions than even I would be. I am also available on discord to help you get started, I have a dedicated channel to ArtOfficial Studio there\!

**General Installation steps:**

1. Create a Github Account and create a token for logging into docker (one-time)  
2. DM me your Github Account Username on Patreon or Discord (one-time)  
3. Install Docker for Linux or Windows (one-time) or access a cloud GPU through any of the providers
4. Log-in to ghcr.io docker container registry (one-time)  
5. Run the docker container with a volume mounted so data is stored even when the docker container is deleted (optional)
6. To pull the latest changes, delete the docker container (remember, all downloaded data is stored on the volume, so it won’t be deleted), and run the docker container again. You now have a completely up to date instance of all the tools with all of your hard work still available\!

# 📘 Table of Contents
1. [How to Create a GitHub Classic Token for Container Access](#how-to-create-a-github-classic-token-for-container-access-one-time-setup-for-all-connection-methods)
   - [Steps](#steps)
     
## Local Installation
2. [What is Docker? (Beginner Friendly)](#what-is-docker-beginner-friendly)
3. [How to Install Docker with GPU Support](#how-to-install-docker-with-gpu-support-one-time-setup)
   - [Windows (WSL2 + NVIDIA)](#windows-with-wsl2-and-nvidia-gpu)
   - [Linux](#linux)
4. [How to Log in to Docker with GitHub Token](#how-to-log-in-to-docker-with-github-token-one-time-setup)
5. [How to Run the ArtOfficial Studio Docker Image](#how-to-run-the-artofficial-studio-docker-image)
6. [Mounting a Volume Drive to Persist Data](#-mounting-a-volume-drive-to-persist-data)
7. [How to Restart the Docker Image Without Losing Data](#-how-to-restart-the-docker-image-without-losing-data)

## RunPod Cloud GPU Installation
8. [Create a New Template](#2-create-a-new-template)
9. [Optional - Create a Network Volume](#6-optional-create-a-network-volume)
10. [Deploy the Pod](#7-deploy-the-pod)
    
## Paperspace Cloud GPU Installation
11. [Connect Paperspace to GitHubRegistry](#1-connect-paperspace-to-githubregistry)
12. [Deploy Container on GPU of Choice](#2-deploy-container-on-gpu-of-choice)
13. [Connect to Application Link](#3-connect-to-application-lin)

## Using ArtOfficial Studio
14. [Using the Home Page](#app-links)
15. [Model Downloader](#model-downloader-tab)
16. [Training Tools](#training-tools-tab)
17. [CivitAI Downloader](#civitai-downloader-tab)
18. [HuggingFace Downloader](#huggingface-downloader-tab)

---

## How to Create a GitHub Classic Token for Container Access (One-time setup for all connection methods)

To access my private container image hosted on GitHub Container Registry (GHCR), you need a GitHub Classic Token. DM me your GitHub username once you have a token, and I will give you access.

### Steps:
1. Go to [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Log in to your GitHub account. If you do not have one, create one.
3. Go to **Settings**
4. Go to the **Developer Settings** on the far left menu (should be all the way at the bottom)
5. Click Personal Access Tokens --> "Tokens (classic)" on the left side.
6. Click "Generate new token" → "Generate New Token (Classic)"
7. Give it a name like Docker Access
8. Set expiration date (optional)
9. Under scopes, check: **read:packages** and **repo (all checkboxes)**
![Screenshot from 2025-04-25 19-36-18](https://github.com/user-attachments/assets/edbb9250-da96-49bb-ade2-72e2ba95d7f9)



10. Click **Generate Token**
11. Copy and save your token securely. You won't be able to see it again!

---

# Local Installation

## First Time Setup starts here

If your Nvidia Driver does not support cu128, there are other cuda versions available as well, if you need a different cuda version, please let me know! Not too difficult to create a new image.

`ghcr.io/theartofficial/artofficialstudio:latest`  

`ghcr.io/theartofficial/artofficialstudio:cu126latest`

`ghcr.io/theartofficial/artofficialstudio:cu125latest`

`ghcr.io/theartofficial/artofficialstudio:cu124latest`

Nvidia 50xx series requires cu128, which is why that is my official release. Drivers are backward compatible, so there is no reason not to update to the latest driver that supports the latest CUDA version. But for those who cannot, the cu126 or cu125 version should work the same.

---

## What is Docker? (Beginner Friendly)

Docker is like a virtual box that runs software in isolated environments called containers. These containers come pre-packaged with all dependencies.

Think of it like this:
1. You download an "app box"
2. You run the box
3. The app inside just works — no installs, no errors, no dependencies

---

## How to Install Docker with GPU Support (One-time setup)

### Windows (with WSL2 and NVIDIA GPU)
[Video tutorial: Installing Nvidia-Docker On Windows 10/11](https://youtu.be/PB7zM3JrgkI?si=T3LOD8y7yim51opS)

1. To install WSL2, open command prompt or powershell and run:
```bash
wsl --install
```
Restart if prompted.

2. Confirm installation with:
```bash
wsl -l -v
```

3. Install Docker Desktop  
   Download [Docker Desktop](https://www.docker.com/products/docker-desktop)  
   Choose **WSL2** backend during installation.

4. After install, open Docker Desktop → **Settings** → **Resources** → **WSL Integration**, and enable your Ubuntu distro.
   ![image](https://github.com/user-attachments/assets/7ce7ecd0-d591-4ecd-a7ad-9c526bb8523d)

6. Pop an Ubuntu Shell
   After you've completed these steps, go to powershell and type this command:

   ```bash
   wsl -d Ubuntu
   ```
   An Ubuntu shell should pop up. 

8. Install NVIDIA Container Toolkit in WSL2
   
   Type the following into the Ubuntu Shell: 
  ```bash
  sudo apt-get update
  sudo apt-get install -y nvidia-container-toolkit
  sudo nvidia-ctk runtime configure --runtime=docker
  ```

8. Verify GPU in Docker
  ```bash
  docker run --gpus all nvidia/cuda:12.2.0-base-ubuntu20.04 nvidia-smi
  ```
If this does not throw an error, then you are all set to run ComfyUI with GPU enabled!

9. You are ready to head to, "How to Log in to Docker with GitHub Token"!
---

### Linux  
[Ubuntu tutorial: How to Run Docker with GPU?](https://docs.docker.com/engine/install/)  
Official Docker install docs: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

---

## How to Log in to Docker with GitHub Token (One-time setup)

  ```bash
  docker login ghcr.io -u YOUR_GITHUB_USERNAME -p YOUR_GITHUB_TOKEN
  ```

Replace YOUR_GITHUB_USERNAME and YOUR_GITHUB_TOKEN with your GitHub credentials.

## First Time Setup Ends Here

---

## Download the Docker Image

To deploy the container faster locally, it is best practice to download the container first and then run it locally. do so with this command:

```
docker pull ghcr.io/theartofficial/artofficialstudio:latest
```


## Mounting a Volume Drive to Persist Data

Docker is able to use your hard drive to store all of the contianer data. The contianer is set up so all of the important ComfyUI and Training Tool data goes into the "/workspace" folder, so that is where we want to mount our volume. Make sure you do not change the :/workspace part of the command, only change the path for your volume.

### Windows:

There is a conversion to go from a windows path to a WSL path:

Example1:

WindowsPath = WSL Path

C:/Your/Path/Here = /mnt/c/your/path/here

  ```
  -v /mnt/c/your/path/here:/workspace
  ```

Example2:

Windows Path = WSL Path

E:/This/Is/Path = /mnt/e/this/is/path

  ```
  -v /mnt/e/this/is/path:/workspace
  ```

### Linux:

  ```
  -v /home/artofficial/vol1:/workspace
  ```

Use the same run command as in the section below, and make sure you use the correct path.

This saves everything to your local drive.

---

## How to Run the ArtOfficial Studio Docker Image

  ```bash
  docker run \
    --gpus all \
    -it \
    -p 80:80 \
    -v /mnt/c/yourpcpath:/workspace \ 
    ghcr.io/theartofficial/artofficialstudio:latest
  ```

If you plan on doing lora training, you'll need to increase the shm size that is passed to the container with this command instead

  ```bash
  docker run \
    --gpus all \
    --shm-size=32g \
    -it \
    -p 80:80 \
    -v /mnt/c/yourpcpath:/workspace \
    ghcr.io/theartofficial/artofficialstudio:latest
  ```

Replace the path with your actual folder location.

Access via browser:  
http://localhost:80

---

## How to Restart the Docker Image Without Losing Data

Clean up:
```bash
docker rm -f $(docker ps -aq)
```

Then rerun the same Docker command as before.

You're all set! Dive into ArtOfficial Studio and explore the frontier of AI creation.

## How to update your Docker Image to the latest

Just run the pull command again

```
docker pull ghcr.io/theartofficial/artofficialstudio:latest
```

Running the container without pulling it will still update ComfyUI and all custom nodes, but you won't have any of the new ArtOfficial Studio features released, so if you want to try out a new model or new training too that's been released, make sure to pull the image again.

---

# Runpod Installation

If your pod's driver does not support cu128, there are other versions available. Simply swap 

`ghcr.io/theartofficial/artofficialstudio:latest` 

for one of the following:

`ghcr.io/theartofficial/artofficialstudio:cu126latest` 

`ghcr.io/theartofficial/artofficialstudio:cu125latest` 

`ghcr.io/theartofficial/artofficialstudio:cu124latest` 

For 50xx series, cu128 is required.

The 4090s on runpod for example, only support cu12.4 at the time of writing this.

To filter by cuda version, use this dropdown:
![image](https://github.com/user-attachments/assets/03a879c6-140a-44f3-a678-e5287892acaa)

## How to Install the Container on a Cloud GPU with RunPod (Process for other cloud services should be similar)

**A warning before we begin, this does take longer to start than most Comfy Templates on RunPod, but that is because it gives you EVERYTHING you need. From Lora training tools, to Sageattention, to Controlnets, you won't have to search around the internet to find projects, nodes or models, so although the startup time is high, it will save you time overall.**

### 1. Go to RunPod:
   - Sign in to your account at [RunPod.io](https://runpod.io).

### 2. Create a New Template:
   - Navigate to **My Templates** and click **+ New Template**.
     
![Screenshot from 2025-04-23 18-04-15](https://github.com/user-attachments/assets/684e9fee-0852-4072-a37a-5a5783ab6467)

### 3. Create the Template:
   - In the template settings, select **"Docker Image"** and paste the following image URL (replace with cu126 version if necessary):
     ```bash
     ghcr.io/theartofficial/artofficialstudio:latest
     ```
   - **Registry Credentials:** Ensure you enter your GitHub username and token to authenticate the container.
   - Select your credentials from the dropdown list after creating them.
   - Only port necessary to expose is 80, the rest of the applications can be launched from the main control panel!
   - Create an Environment Variable called "RUNPOD" with the value 1. This will let the system know that you're using runpod, so that gradio will work correctly.
     
![Screenshot from 2025-04-25 09-59-27](https://github.com/user-attachments/assets/1bbdb065-bf9b-4862-ae88-803146e03884)
![image](https://github.com/user-attachments/assets/f8232297-d4bd-42c6-9e78-02539263ca2c)


### 4. Save the Template:
   - Click **Save Template** once everything is correct.

### 5. Optional - Create a Network Volume:
   - This step is not necessary but is highly recommended to avoid redownloading files every time.
   - Navigate to **Storage** in the left menu.
   - Choose the options that best suit you. The **Europe datacenter** tends to have the best performance, but select what works best for you.
     
![Screenshot from 2025-04-24 07-01-50](https://github.com/user-attachments/assets/41e459fb-486a-4b66-89f0-177a0d2e0b2f)

### 6. Deploy the Pod:
   - Go to **Pods** and click **+ Deploy** or, if using a network volume, deploy from it.
   - Ensure you have the correct filter settings for the pod:
     
![Screenshot from 2025-04-24 07-06-59](https://github.com/user-attachments/assets/050780c1-af6a-4703-a553-59ba68ab1a99)

   - Select the GPU (For this example, we use a 5090).
     - For most workflows, **16GB of VRAM** is sufficient. Some might require **24GB**, especially for 720p video generation.
   - Choose **Change Template** and select the template created earlier.
     
![Screenshot from 2025-04-24 07-09-20](https://github.com/user-attachments/assets/823c81fe-6596-44fa-8525-33b372bd7f44)

### 7. Deploy On-Demand:
   - Click **Deploy On-Demand**. You should see the logs start to run.
   - If you encounter an error such as "No container found," this may indicate a network or setup issue with the pod.

### 8. Verify Logs:
   - Once successful, your system logs should indicate that everything is running, and you'll see messages like “downloading ------>” if it’s your first time using the template.
   - If you see an "unauthorized" error, this means the credentials are incorrect or access hasn't been granted yet.
     
![Screenshot from 2025-04-24 07-14-34](https://github.com/user-attachments/assets/e87e1d8f-ba3c-4508-871b-576617aa2d32)

### 9. Connect:
  - Once everything is working, the **Connect** button will become active. Click it to access your container.
    
![Screenshot from 2025-04-24 07-18-33](https://github.com/user-attachments/assets/06c41b13-38c5-4fc3-8ecb-106f740bd15a)

### 10. Connect to port 80:
  - The app runs on port 80, so click that and the front-end UI will open.

By following these steps, you’ll have a fully working setup with the ArtOfficial Studio container running on your RunPod cloud GPU!

---

# Paperspace Installation

### 1. **Connect Paperspace to GitHubRegistry**
- Click on your profile in the top right and select "Team Settings"
  
 ![image](https://github.com/user-attachments/assets/136ba2af-8df7-434a-bb9a-5976d89319ae)

- Go to the "Containers" Tab, select the "GitHub Container Registry" from the dropdown, and hit "NEXT"
  
![image](https://github.com/user-attachments/assets/61b6359e-2ff7-4112-892b-e29c96491c45)

- Fill out the info as shown below. Hit "Test Connection" to make sure your access to the github repo is available
  
![Screenshot from 2025-04-25 13-03-58](https://github.com/user-attachments/assets/23b25418-0e63-4374-9c76-55275b24bc6c)

### 2. **Deploy Container on GPU of Choice**
- Select which GPU to deploy in the dropdown.
- Give the container a nickname
- Select "Private container registry"
- Select the Container Registry you set up in the previous step
- use the docker image that is compatible with your GPU
`ghcr.io/theartofficial/artofficialstudio:latest`  
`ghcr.io/theartofficial/artofficialstudio:cu126latest`
`ghcr.io/theartofficial/artofficialstudio:cu125latest`
`ghcr.io/theartofficial/artofficialstudio:cu124latest`

![image](https://github.com/user-attachments/assets/56f2c98a-b8b0-4b2f-93df-66400fb1a519)

- Make sure port 80 is exposed, then click "DEPLOY"
  
![image](https://github.com/user-attachments/assets/74ea9b96-a6d5-4b0b-a2da-703a30a342b4)


### 3. **Connect to Application Link**
- Once you see tensorboard messages at the end of the log, your instance is ready to go!
  
![Screenshot from 2025-04-25 13-19-28](https://github.com/user-attachments/assets/98f47462-a36a-4886-a7f7-3e969eb199eb)

- From the console dashboard, click the "Endpoint" Link, and you will be connected to the App Links page of the application!
  
![image](https://github.com/user-attachments/assets/68e28f57-103c-48d9-982f-f0df5509c25a)


---

# Using ArtOfficial Studio
## To launch ArtOfficial Studio:
   
   Local: Navigate to `http://localhost:80/`
   
   Runpod: Connect to port 80
   
   Paperspace: just navigate to the url provided by the by Paperspace.

## App Links  
   App links provides all of the connections to other services maintained by the app
   
![image](https://github.com/user-attachments/assets/b4ba566a-99e2-4496-8dea-0f30cbff842b)

## Model Downloader Tab
   The **Model Downloader** tab allows you to select and download models straight into the correct folder for **ComfyUI**. Once downloaded, Head to the "App Links" tab to access **ComfyUI**. Models should be automatically placed in the   correct directories.
   
![Screenshot from 2025-04-25 11-02-51](https://github.com/user-attachments/assets/1f25722f-6ca8-4e84-a691-c11b5034574a)

## Training Tools Tab  
   This tab provides tools to train LoRAs. Select a tool and hit install. The installation logs will appear in the **Installation Log** box. If any errors occur, you can send the logs for troubleshooting.
   - Diffusion Pipe is tested and working well
   - FluxGym Installation is clean, need to test functionality
   - Kohya Installation is clean, need to test functionality
     
![Screenshot from 2025-04-25 11-03-05](https://github.com/user-attachments/assets/df25ce90-4e43-48a7-b402-87fe279edd24)

## CivitAI Downloader Tab
   This feature allows you to download files from CivitAI. Simply provide the URL, model type, desired filename, and your CivitAI token, and it will automatically place the file in the right ComfyUI folder.
   
![Screenshot from 2025-04-25 11-03-23](https://github.com/user-attachments/assets/80851482-7170-4b8b-9ac5-e949acd15730)

## HuggingFace Downloader Tab:  

   Similar to the CivitAI downloader, this tool allows you to download models from HuggingFace by providing the URL, download path, and optionally a HuggingFace token.
![Screenshot from 2025-04-25 11-03-36](https://github.com/user-attachments/assets/530dd127-e771-4840-99d4-ce9285999249)

---
