#!/bin/bash

# Update system
sudo apt update
sudo apt upgrade -y

# Install .NET SDK 6.0
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-6.0

# Install .NET Entity Framework (v6.4)
dotnet tool install --global dotnet-ef --version 6.4

# Install curl
sudo apt install curl

# Install SQL Server 2022
curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup accept-eula
# Choose version 3
# Password: <your password>
systemctl status mssql-server --no-pager

# Install Git
sudo apt install -y git

# Clone the repository
git clone https://github.com/looking4ward/Bing-Maps-Fleet-Tracker.git

# Build Backend of FTS using dotnet CLI
cd Bing-Maps-Fleet-Tracker/Backend
dotnet build

# Run Backend
dotnet run --project Backend/src/Trackable.Web/Trackable.Web.csproj

# Output a message indicating successful execution
echo "The Backend of Fleet Tracker System is running at http://localhost/api on port 80."
