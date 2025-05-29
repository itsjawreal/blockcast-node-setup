#!/bin/bash

set -e

echo "🚀 Starting Blockcast Node Installation..."

# Step 1: Update system & install dependencies
echo "🔧 Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install ca-certificates curl gnupg lsb-release ufw jq git -y

# Step 2: Configure firewall
echo "🔐 Configuring UFW firewall..."
sudo ufw allow 8080/tcp
sudo ufw allow 8089/tcp

# Step 3: Install Docker
echo "🐳 Installing Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Step 4: Enable Docker service
echo "🧩 Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Step 5: Check Docker versions
echo "✅ Docker Version:"
docker --version
docker compose version

# Step 6: Overwrite docker-compose.yml from source if needed
echo "📄 Downloading latest docker-compose.yml..."
curl -o ./docker-compose.yml https://raw.githubusercontent.com/molla202/Block-cast/refs/heads/main/docker-compose.yml

# Step 7: Start the Node
echo "🚦 Starting Blockcast node..."
docker compose up -d

# Step 8: Show running containers
echo "📦 Running containers:"
docker compose ps -a

# Step 9: Generate Hardware ID and Challenge Key
echo "🧬 Generating Hardware ID & Challenge Key..."
docker compose exec blockcastd blockcastd init || echo "Wait a few seconds then re-run: docker compose exec blockcastd blockcastd init"

# Step 10: Show location info
echo "🌐 Fetching location..."
curl -s https://ipinfo.io | jq '.city, .region, .country, .loc'

echo ""
echo "✅ INSTALLATION COMPLETE!"
echo "🎯 Next steps:"
echo "- Read the 🔑 Register Your Node on README.md"
echo "- Visit the Register URL shown above to register your node."
echo "- Then check logs: docker compose logs -fn 1000"
echo "- Manage node: cd ~/beacon-docker-compose && docker compose down && docker compose up -d"
echo ""
