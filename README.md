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
8. [Create a New Template](#create-a-new-template)
9. [Optional - Create a Network Volume](#optional-create-a-network-volume)
10. [Deploy the Pod](#deploy-the-pod)
    
## Paperspace Cloud GPU Installation
11. [Connect Paperspace to GitHubRegistry](#connect-paperspace-to-githubregistry)
12. [Deploy Container on GPU of Choice](#deploy-container-on-gpu-of-choice)
13. [Connect to Application Link](#connect-to-application-lin)

## Using ArtOfficial Studio
14. [Using the Home Page](#app-links)
15. [Model Downloader](#model-downloader-tab)
16. [Training Tools](#training-tools-tab)
17. [CivitAI Downloader](#civitai-downloader)
18. [HuggingFace Downloader](#huggingface-downloader)

---

## How to Create a GitHub Classic Token for Container Access (One-time setup for all connection methods)

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

# Local Installation

## First Time Setup starts here

If your Nvidia Driver does not support cu128, there is a cu126 and cuda125 version as well, if you need a different cuda version, please let me know! Not too difficult to create a new image.
`ghcr.io/theartofficial/artofficialstudio:latest`  
`ghcr.io/theartofficial/artofficialstudio:cu126latest`
`ghcr.io/theartofficial/artofficialstudio:cu125latest`

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

5. Install NVIDIA Container Toolkit in WSL2
```bash
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker || echo "If this fails, restart Docker Desktop manually."
wsl --shutdown
```

6. Verify GPU in Docker
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

## First Time Setup Ends Here

---

## 5. How to Run the ArtOfficial Studio Docker Image

```bash
docker run \
  --gpus all \
  -it --rm \
  -p 80:80 \
  -v C:/PathOnYourPCToStoreFiles:/workspace \
  ghcr.io/theartofficial/artofficialstudio:latest
```

Replace the path with your actual folder location.

Access via browser:  
http://localhost:80

---

## Mounting a Volume Drive to Persist Data

Use the same run command (above), but make sure your path is correct:
```bash
-v C:/PathOnYourPCToStoreFiles:/workspace
```

This saves everything to your local drive.

---

## How to Restart the Docker Image Without Losing Data

Clean up:
```bash
docker rm -f $(docker ps -aq)
```

Then rerun the same Docker command as before.

You're all set! Dive into ArtOfficial Studio and explore the frontier of AI creation.

---

### Runpod Installation

If your pod's driver does not support cu128, there is a cu126 version available. Simply swap `ghcr.io/theartofficial/artofficialstudio:latest` for `ghcr.io/theartofficial/artofficialstudio:cu126latest` or `ghcr.io/theartofficial/artofficialstudio:cu125latest`. For Nvidia 50xx series, cu128 is required, which is why this is the official release. Since drivers are backward compatible, it's generally a good idea to update to the latest version that supports the newest CUDA version.

---

## How to Install the Container on a Cloud GPU with RunPod (Process for other cloud services should be similar)

A note before we get started: **4090 GPUs on RunPod** have been unreliable recently, with some lacking Nvidia drivers or having connection issues when pulling Docker images. I recommend avoiding these for now until issues are resolved. On the other hand, **5090 GPUs** have worked flawlessly with this setup!


## 1. Go to RunPod:
   - Sign in to your account at [RunPod.io](https://runpod.io).

## 2. **Create a New Template:**
   - Navigate to **My Templates** and click **+ New Template**.
![Screenshot from 2025-04-23 18-04-15](https://github.com/user-attachments/assets/684e9fee-0852-4072-a37a-5a5783ab6467)

## 3. **Create the Template:**
   - In the template settings, select **"Docker Image"** and paste the following image URL (replace with cu126 version if necessary):
     ```bash
     ghcr.io/theartofficial/artofficialstudio:latest
     ```
   - **Registry Credentials:** Ensure you enter your GitHub username and token to authenticate the container.
   - Select your credentials from the dropdown list after creating them.
   - Only port necessary to expose is 80, the rest of the applications can be launched from the main control panel!
![Screenshot from 2025-04-25 09-59-27](https://github.com/user-attachments/assets/1bbdb065-bf9b-4862-ae88-803146e03884)


## 5. **Save the Template:**
   - Click **Save Template** once everything is correct.

## 6. **Optional - Create a Network Volume:**
   - This step is not necessary but is highly recommended to avoid redownloading files every time.
   - Navigate to **Storage** in the left menu.
   - Choose the options that best suit you. The **Europe datacenter** tends to have the best performance, but select what works best for you.
![Screenshot from 2025-04-24 07-01-50](https://github.com/user-attachments/assets/41e459fb-486a-4b66-89f0-177a0d2e0b2f)

## 7. **Deploy the Pod:**
   - Go to **Pods** and click **+ Deploy** or, if using a network volume, deploy from it.
   - Ensure you have the correct filter settings for the pod:
![Screenshot from 2025-04-24 07-06-59](https://github.com/user-attachments/assets/050780c1-af6a-4703-a553-59ba68ab1a99)

   - Select the GPU (For this example, we use a 5090).
     - For most workflows, **16GB of VRAM** is sufficient. Some might require **24GB**, especially for 720p video generation.
   - Choose **Change Template** and select the template created earlier.
![Screenshot from 2025-04-24 07-09-20](https://github.com/user-attachments/assets/823c81fe-6596-44fa-8525-33b372bd7f44)


## 8. **Deploy On-Demand:**
   - Click **Deploy On-Demand**. You should see the logs start to run.
   - If you encounter an error such as "No container found," this may indicate a network or setup issue with the pod.

## 9. **Verify Logs:**
   - Once successful, your system logs should indicate that everything is running, and you'll see messages like “downloading ------” if it’s your first time using the template.
   - If you see an "unauthorized" error, this means the credentials are incorrect or access hasn't been granted yet.
![Screenshot from 2025-04-24 07-14-34](https://github.com/user-attachments/assets/e87e1d8f-ba3c-4508-871b-576617aa2d32)

## 10. **Connect:**
    - Once everything is working, the **Connect** button will become active. Click it to access your container.
![Screenshot from 2025-04-24 07-18-33](https://github.com/user-attachments/assets/06c41b13-38c5-4fc3-8ecb-106f740bd15a)

## 11. **Connect to port 80:**
    - The app runs on port 80, so click that and the front-end UI will open.

By following these steps, you’ll have a fully working setup with the ArtOfficial Studio container running on your RunPod cloud GPU!

---

### Paperspace Installation

## 1. **Connect Paperspace to GitHubRegistry**
## 2. **Deploy Container on GPU of Choice**
## 3. **Connect to Application Link**

---

### Using ArtOfficial Studio
   **To launch ArtOfficial Studio:**
   
   Local: Navigate to `http://localhost:80/`
   
   Runpod: Connect to port 80
   
   Paperspace: just navigate to the url provided by the by Paperspace.

  **App Links:**  

   App links provides all of the connections to other services maintained by the app
![image](https://github.com/user-attachments/assets/b4ba566a-99e2-4496-8dea-0f30cbff842b)


  **Model Downloader Tab:**  
   The **Model Downloader** tab allows you to select and download models straight into the correct folder for **ComfyUI**. Once downloaded, Head to the "App Links" tab to access **ComfyUI**. Models should be automatically placed in the   correct directories.
![Screenshot from 2025-04-25 11-02-51](https://github.com/user-attachments/assets/1f25722f-6ca8-4e84-a691-c11b5034574a)


  **Training Tools Tab:**  
   This tab provides tools to train LoRAs. Select a tool and hit install. The installation logs will appear in the **Installation Log** box. If any errors occur, you can send the logs for troubleshooting.
![Screenshot from 2025-04-25 11-03-05](https://github.com/user-attachments/assets/df25ce90-4e43-48a7-b402-87fe279edd24)

  **CivitAI Downloader Tab:**  
   This feature allows you to download files from CivitAI. Simply provide the URL, model type, desired filename, and your CivitAI token, and it will automatically place the file in the right ComfyUI folder.
![Screenshot from 2025-04-25 11-03-23](https://github.com/user-attachments/assets/80851482-7170-4b8b-9ac5-e949acd15730)

  **HuggingFace Downloader Tab:**  
   Similar to the CivitAI downloader, this tool allows you to download models from HuggingFace by providing the URL, download path, and optionally a HuggingFace token.
![Screenshot from 2025-04-25 11-03-36](https://github.com/user-attachments/assets/530dd127-e771-4840-99d4-ce9285999249)

---
