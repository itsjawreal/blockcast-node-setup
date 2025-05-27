# Blockcast Node Setup Guide

`Note: This guide assumes you're running a Linux-based OS with basic terminal knowledge.`

## 📝 Quick Overview
This guide will help you set up a Blockcast node using Docker. You’ll also complete the necessary account setup on the Blockcast platform to link your node for rewards.

![image](https://github.com/user-attachments/assets/acd32f6f-dd5d-4396-99db-6016b743347b)


## 🛠️ System Requirements
✅ Ubuntu-based Linux (tested on 20.04+)

✅ Docker & Docker Compose

✅ Minimum 2 CPU cores & 4 GB RAM

✅ Open Ports / Port Forwarding (if behind NAT)

✅ Stable Internet Connection

## 🔐 Account Setup
1. Access the Platform: [Blockcast Website](https://app.blockcast.network?referral-code=uBheL8)
2. Sign Up: Use a valid email address.
3. Connect Wallet: Use a spare Solana wallet.
4. Bind Accounts: Link your Twitter and Discord.

Complete Quests: Navigate to your profile dashboard and finish any available quests.

## 🐳 Node Installation Steps
### Step 1: Update Your System
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ca-certificates curl gnupg lsb-release -y
```
```bash
ufw allow 8080
ufw allow 8080/tcp
ufw allow 8089
ufw allow 8089/tcp
```

If the ufw (Uncomplicated Firewall) command does require root privileges to run use this :
```bash
sudo ufw allow 8080
sudo ufw allow 8080/tcp
sudo ufw allow 8089
sudo ufw allow 8089/tcp
```

### Step 2: Install Docker
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
```

### Step 3: Enable Docker
```bash
sudo systemctl enable docker
sudo systemctl start docker
```

### Step 4: Verify Installation
```bash
docker --version
docker compose version
```

## 🔄 Run the Node
### Step 1: Clone the Repository
![image](https://github.com/user-attachments/assets/4e16ec46-96ef-4442-aaf0-2d3872780506)

```bash
git clone https://github.com/Blockcast/beacon-docker-compose.git
cd beacon-docker-compose
```

### Step 2: Start the Node
![image](https://github.com/user-attachments/assets/3c4e4283-dfe7-44d1-95e8-b28f703f0603)

```bash
docker compose up -d
```

### Step 3: Confirm it's Running
![image](https://github.com/user-attachments/assets/e6ae7fc3-1963-45b3-a417-4d9b0d7439d2)

```bash
docker ps
```

## 🔑 Register Your Node
### Step 1: Get Hardware ID and Challenge Key

```bash
docker compose exec blockcastd blockcastd init
```

You'll get something like:

![image](https://github.com/user-attachments/assets/8f8aa221-af92-464a-bc30-071c1fdc006e)

```yaml
Hardware ID: xxxxxxxxxxxx

Challenge Key: xxxxxxxxxxxx

Register URL : https://app.blockcast.network/register?xxxxx
```

### Step 2: Register on the Platform
Click `Register URL` link shown on Exec or follow tutorial below:

- Go to [Blockcast Website](https://app.blockcast.network?referral-code=uBheL8)
- Login with the same email you signed up with.
- Click "Manage Node" → "Register Node".
- Paste your Hardware ID and Challenge Key.
- Click Submit & Done

### Step 3: Check log 
It usually takes at least 10 minutes or more to be able to register your node into active/online mode.
![image](https://github.com/user-attachments/assets/307f6326-96af-45c9-a700-4bc356de341c)
```bash
docker compose logs
```

## ✅ Final Notes
Your node should run 24/7 to remain eligible for rewards.
Use a reliable VPS provider if needed:

1. Hetzner             : https://www.hetzner.com/cloud/?
2. Contabo             : https://contabo.com/en/vps/
3. Analyst VPS Seller  : https://t.me/miftaikyy

### Usefull Command
1. Project (stop or run)
```bash
cd beacon-docker-compose
git pull origin main
docker compose down
docker compose up -d
```
2. See your Device castID & challengeID
```bash
docker compose exec blockcastd blockcastd init
```

## 📬 Need Help?
Join the [AirdropAnalystChat](https://t.me/AirdropAnalystChat) or [Blockcast Discord](https://discord.com/invite/jAFhqqNSDj) open an issue in the repo for support.

