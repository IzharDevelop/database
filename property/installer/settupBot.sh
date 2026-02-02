#!/bin/bash

# --- Palette Warna Modern ---
B_CYAN='\033[1;36m'
B_GREEN='\033[1;32m'
B_PURPLE='\033[1;35m'
B_YELLOW='\033[1;33m'
B_RED='\033[1;31m'
WHITE='\033[1;37m'
NC='\033[0m' 

# --- Fungsi Garis Pembatas ---
draw_line() {
    echo -e "${B_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

clear
# --- Header ASCII Art ---
echo -e "${B_PURPLE}"
echo "  ███████╗██╗  ██╗ █████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗ █████╗ "
echo "  ╚══███╔╝██║  ██║██╔══██╗██╔══██╗██║   ██║██╔══██╗████╗  ██║██╔══██╗"
echo "    ███╔╝ ███████║███████║██████╔╝██║   ██║███████║██╔██╗ ██║███████║"
echo "   ███╔╝  ██╔══██║██╔══██║██╔══██╗╚██╗ ██╔╝██╔══██║██║╚██╗██║██╔══██║"
echo "  ███████╗██║  ██║██║  ██║██║  ██║ ╚████╔╝ ██║  ██║██║ ╚████║██║  ██║"
echo "  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝"
echo -e "                 ${WHITE}PREMIUM AUTO INSTALLER v2.0${NC}"
draw_line

# 1. Update & Upgrade
echo -e " ${B_YELLOW}${NC} ${WHITE}Step 1:${NC} Refreshing System Repositories..."
sudo apt update && sudo apt upgrade -y 
# 2. Install Git & FFmpeg
echo -e " ${B_YELLOW}${NC} ${WHITE}Step 2:${NC} Installing Core Media (Git & FFmpeg)..."
sudo apt install -y git ffmpeg
# 3. Install NVM & Node.js 24
echo -e " ${B_YELLOW}${NC} ${WHITE}Step 3:${NC} Deploying NVM & Node.js v24..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash 

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 24 
nvm use 24 
# 4. Update NPM & PM2
echo -e " ${B_YELLOW}${NC} ${WHITE}Step 4:${NC} Boosting NPM & Global Process Manager (PM2)..."
npm install -g npm@latest
npm install -g pm2
clear
# --- Ringkasan Akhir ---
echo -e "${B_GREEN}"
echo "  ✅ DEPLOYMENT COMPLETED SUCCESSFULLY!"
echo -e "${NC}"
draw_line
echo -e "${B_CYAN} 📦 INSTALLED PACKAGES:${NC}"
printf "  ${WHITE}%-12s${NC} : %s\n" "Node.js" "$(node -v)"
printf "  ${WHITE}%-12s${NC} : v$(npm -v) ${B_GREEN}(LATEST)${NC}\n" "NPM"
printf "  ${WHITE}%-12s${NC} : v$(pm2 -v)" "PM2"
printf "  ${WHITE}%-12s${NC} : %s\n" "Git" "$(git --version | awk '{print $3}')"
printf "  ${WHITE}%-12s${NC} : %s\n" "FFmpeg" "$(ffmpeg -version | head -n1 | awk '{print $3}')"

draw_line
echo -e "${B_CYAN} 🖥️  SERVER ANALYTICS:${NC}"
printf "  ${WHITE}%-12s${NC} : %s\n" "OS" "$(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '"')"
printf "  ${WHITE}%-12s${NC} : %s\n" "Kernel" "$(uname -r)"
printf "  ${WHITE}%-12s${NC} : %s\n" "Uptime" "$(uptime -p | sed 's/up //')"
printf "  ${WHITE}%-12s${NC} : ${B_YELLOW}%s Core(s)${NC}\n" "CPU Cores" "$(nproc)"
printf "  ${WHITE}%-12s${NC} : %s\n" "CPU Model" "$(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
printf "  ${WHITE}%-12s${NC} : %s / %s\n" "RAM/Disk" "$(free -h | awk '/^Mem:/ {print $2}') / $(df -h / | awk 'NR==2 {print $2}')"
draw_line

# --- Final Prompt ---
echo -e "\n${B_PURPLE} ➜ ${NC}${WHITE}Would you like to install ${B_CYAN}'Sky'${NC}${WHITE} repository? (y/n)${NC}"
read -p "   Selection: " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo -e "\n${B_YELLOW} 📥 Cloning izhardevelop/sky...${NC}"
    if [ -d "sky" ]; then
        echo -e " ${B_RED}✖ Error:${NC} Folder 'sky' already exists."
    else
        git clone https://github.com/izhardevelop/sky
        echo -e " ${B_GREEN}✔ Success:${NC} Repository cloned to $(pwd)/sky"
    fi
else
    echo -e "\n ${B_RED}✖ Installation skipped.${NC}"
fi

echo -e "\n${B_YELLOW} [!] Please run: ${WHITE}source ~/.bashrc${B_YELLOW} to refresh shell.${NC}"
draw_line
