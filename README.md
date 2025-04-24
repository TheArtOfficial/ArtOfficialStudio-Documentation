# **ArtOfficial Studio: Docker Container Installation Guide** 

## **Preface** 

Welcome to **ArtOfficial Studio** — a powerful Docker-based container application designed to make cutting-edge AI tools and model training accessible to everyone. The first-time set-up may seem complex, but once docker is installed, it is only one click to pull all of the latest models, workflows, and ComfyUI features. Whether you’re an artist, researcher, or enthusiast, this tool offers:

* One-click access to the **latest AI models**  
* SAGEATTENTION AND TORCH COMPILE just work\!
* Simple interfaces through port forwarding  
* Easy setup of **LoRA training tools**  
* Persistent storage for your models while always using the **latest software updates**

No technical background? No worries. This guide is written to walk you through each step from scratch. If you have any issues, chatGPT is your friend\! It is probably better at answering your questions than even I would be. I am also available on discord to help you get started, I have a dedicated channel to ArtOfficial Studio there\!

**General Installation steps:**

1. Create a Github Account and create a token for logging into docker (one-time)  
2. DM me your Github Account Username on Patreon or Discord (one-time)  
3. Install Docker for Linux or Windows (one-time)  
4. Log-in to ghcr.io docker container registry (one-time)  
5. Run the docker container with a volume mounted so data is stored even when the docker container is deleted  
6. To pull the latest changes, delete the docker container (remember, all downloaded data is stored on the volume, so it won’t be deleted), and run the docker container again\!

**Table of Contents**
### Local Installation
- [1. How to Create a GitHub Classic Token for Container Access](#1-how-to-create-a-github-classic-token-for-container-access)
  - [Steps](#steps)
- [2. What is Docker (Beginner Friendly)](#2-what-is-docker-beginner-friendly)
- [3. How to Install Docker with GPU Support](#3-how-to-install-docker-with-gpu-support)
  - [Windows (with WSL2 and NVIDIA GPU)](#windows-with-wsl2-and-nvidia-gpu)
  - [Linux](#linux)
- [4. How to Log in to Docker with GitHub Token](#4-how-to-log-in-to-docker-with-github-token)
- [5. How to Run the ArtOfficial Studio Docker Image](#5-how-to-run-the-artofficial-studio-docker-image)
- [6. Mounting a Volume Drive to Persist Data](#6-mounting-a-volume-drive-to-persist-data)
- [7. How to Restart the Docker Image Without Losing Data](#7-how-to-restart-the-docker-image-without-losing-data)

### Runpod Installation
- [8. How to Install the Container on a Cloud GPU with RunPod](#8-how-to-install-the-container-on-a-cloud-gpu-with-runpod)

### Using ArtOfficial Studio
- [9. Using the Home Page](#9-using-the-home-page)
- [10. Training Tools](#10-training-tools)
- [11. CivitAI Downloader](#11-civitai-downloader)
- [12. HuggingFace Downloader](#12-huggingface-downloader)

# Local Installation

## First Time Setup starts here

If your Nvidia Driver does not support cu128, there is a cu126 version available as well! Just swap  
`ghcr.io/theartofficial/artofficialstudio:latest`  
for  
`ghcr.io/theartofficial/artofficialstudio:cu126latest`

Nvidia 50xx series requires cu128, which is why that is my official release. Drivers are backward compatible, so there is no reason not to update to the latest driver that supports the latest CUDA version. But for those who cannot, the cu126 version should work the same.

---

## 1. How to Create a GitHub Classic Token for Container Access (One-time setup)

To access my private container image hosted on GitHub Container Registry (GHCR), you need a GitHub Classic Token. DM me your GitHub username once you have a token, and I will give you access.

### Steps:
1. Go to [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Log in to your GitHub account. If you do not have one, create one.
3. Click "Tokens (classic)" on the left side.
4. Click "Generate new token" → "Generate New Token (Classic)"
5. Give it a name like Docker Access
6. Set expiration date (optional)
7. Under scopes, check: read:packages
8. Click **Generate Token**
9. Copy and save your token securely. You won't be able to see it again!

---

## 2. What is Docker? (Beginner Friendly)

Docker is like a virtual box that runs software in isolated environments called containers. These containers come pre-packaged with all dependencies.

Think of it like this:
1. You download an "app box"
2. You run the box
3. The app inside just works — no installs, no errors, no dependencies

---

## 3. How to Install Docker with GPU Support (One-time setup)

### Windows (with WSL2 and NVIDIA GPU)
[Video tutorial: Installing Nvidia-Docker On Windows 10/11](https://www.youtube.com/watch?v=FwOsSscx_98)

1. Install WSL2
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

5. Install NVIDIA GPU Driver with WSL2 Support  
   Get the latest driver from [NVIDIA Downloads](https://www.nvidia.com/download).

6. Install NVIDIA Container Toolkit in WSL2
```bash
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker || echo "If this fails, restart Docker Desktop manually."
wsl --shutdown
```

7. Verify GPU in Docker
```bash
docker run --gpus all nvidia/cuda:12.2.0-base-ubuntu20.04 nvidia-smi
```

---

### Linux  
[Ubuntu tutorial: How to Run Docker with GPU?](https://docs.docker.com/engine/install/)  
Official Docker install docs: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

---

## 4. How to Log in to Docker with GitHub Token (One-time setup)

```bash
docker login ghcr.io -u YOUR_GITHUB_USERNAME -p YOUR_GITHUB_TOKEN
```

Replace YOUR_GITHUB_USERNAME and YOUR_GITHUB_TOKEN with your GitHub credentials.

**First Time Setup Ends Here**

---

## 5. How to Run the ArtOfficial Studio Docker Image

```bash
docker run \
  --gpus all \
  -it --rm \
  -p 5000:5000 \
  -p 6000:6000 \
  -p 7000:7000 \
  -p 6006:6006 \
  -p 8188:8188 \
  -p 8888:8888 \
  -v C:/PathOnYourPCToStoreFiles:/workspace \
  ghcr.io/theartofficial/artofficialstudio:latest
```

Replace the path with your actual folder location.

### Port Reference
- 5000 → ArtOfficial Studio Splash Page
- 6000 → Flux Gym
- 7000 → Diffusion-Pipe UI
- 8188 → ComfyUI
- 8888 → JupyterLab
- 6006 → TensorBoard (for LoRA training)

Access via browser:  
http://0.0.0.0:PORT

---

## 6. Mounting a Volume Drive to Persist Data

Use the same run command (above), but make sure your path is correct:
```bash
-v C:/PathOnYourPCToStoreFiles:/workspace
```

This saves everything to your local drive.

---

## 7. How to Restart the Docker Image Without Losing Data

Clean up:
```bash
docker rm -f $(docker ps -aq)
```

Then rerun the same Docker command as before.

You're all set! Dive into ArtOfficial Studio and explore the frontier of AI creation.

---

Sure! Here's the revised "Runpod Installation" section based on your request:

---

## Runpod Installation

If your pod's driver does not support cu128, there is a cu126 version available. Simply swap `ghcr.io/theartofficial/artofficialstudio:latest` for `ghcr.io/theartofficial/artofficialstudio:cu126latest`. For Nvidia 50xx series, cu128 is required, which is why this is the official release. Since drivers are backward compatible, it's generally a good idea to update to the latest version that supports the newest CUDA version.

---

### 8. How to Install the Container on a Cloud GPU with RunPod (Process for other cloud services should be similar)

A note before we get started: **4090 GPUs on RunPod** have been unreliable recently, with some lacking Nvidia drivers or having connection issues when pulling Docker images. I recommend avoiding these for now until issues are resolved. On the other hand, **5090 GPUs** have worked flawlessly with this setup!

**Steps:**

1. **Go to RunPod:**
   - Sign in to your account at [RunPod.io](https://runpod.io).

2. **Create a New Template:**
   - Navigate to **My Templates** and click **+ New Template**.

3. **Create the Template:**
   - In the template settings, select **"Docker Image"** and paste the following image URL (replace with cu126 version if necessary):
     ```bash
     ghcr.io/theartofficial/artofficialstudio:latest
     ```
   - **Registry Credentials:** Ensure you enter your GitHub username and token to authenticate the container.
   - Select your credentials from the dropdown list after creating them.

4. **Save the Template:**
   - Click **Save Template** once everything is correct.

5. **Optional - Create a Network Volume:**
   - This step is not necessary but is highly recommended to avoid redownloading files every time.
   - Navigate to **Storage** in the left menu.
   - Choose the options that best suit you. The **Europe datacenter** tends to have the best performance, but select what works best for you.

6. **Deploy the Pod:**
   - Go to **Pods** and click **+ Deploy** or, if using a network volume, deploy from it.
   - Ensure you have the correct filter settings for the pod:
     - Select the GPU (For this example, we use a 5090).
     - For most workflows, **16GB of VRAM** is sufficient. Some might require **24GB**, especially for 720p video generation.
     - Choose **Change Template** and select the template created earlier.

7. **Deploy On-Demand:**
   - Click **Deploy On-Demand**. You should see the logs start to run.
   - If you encounter an error such as "No container found," this may indicate a network or setup issue with the pod.

8. **Verify Logs:**
   - Once successful, your system logs should indicate that everything is running, and you'll see messages like “downloading ------” if it’s your first time using the template.
   - If you see an "unauthorized" error, this means the credentials are incorrect or access hasn't been granted yet.

9. **Connect:**
   - Once everything is working, the **Connect** button will become active. Click it to access your container.

---

### 9. Using ArtOfficial Studio

After deployment, you can access ArtOfficial Studio via the following ports on your local instance:

1. **Home Page:**  
   Navigate to `http://localhost:5000/` for the main dashboard.

2. **Model Downloader:**  
   The **Model Downloader** tab allows you to select and download models straight into the correct folder for **ComfyUI**. Once downloaded, open port **8188** (or navigate to `0.0.0.0:8188`) to access **ComfyUI**. Models should be automatically placed in the correct directories.

3. **Training Tools:**  
   This tab provides tools to train LoRAs. Select a tool and hit install. The installation logs will appear in the **Installation Log** box. If any errors occur, you can send the logs for troubleshooting.

4. **CivitAI Downloader:**  
   This feature allows you to download files from CivitAI. Simply provide the URL, model type, desired filename, and your CivitAI token, and it will automatically place the file in the right ComfyUI folder.

5. **HuggingFace Downloader:**  
   Similar to the CivitAI downloader, this tool allows you to download models from HuggingFace by providing the URL, download path, and optionally a HuggingFace token.

6. **Jupyter Lab (Port 8888):**  
   JupyterLab offers access to the entire container's filesystem. If you need more control over file management or need to edit Python scripts, this is the tool for you.

---

By following these steps, you’ll have a fully working setup with the ArtOfficial Studio container running on your RunPod cloud GPU. Let me know if you need further assistance!
