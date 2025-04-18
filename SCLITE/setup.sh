#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.2s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
	echo -e "[ \e[32;1mINFO\e[0m ] CHECK PERMISSION FOR VALIDITY SCRIPT . . ."
	sleep 2
    echo ""
    echo ""
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
	sleep 1
    else
	clear
	echo ""
	echo ""
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    echo -e "\e[31mContact Admin for buy/register your ipvps\e[0m"
    echo -e "\e[31mTelegram @EzcodeShop\e[0m"
	sleep 5
    exit 5
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[ \e[32;1mINFO\e[0m ] CHECK PERMISSION FOR INSTALLATION SCRIPT. . ."
sleep 2
fun_start () {
valid=$( curl https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/EZ-Code00/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
echo -e "\e[32mPERMISSION ACCEPTED...\e[0m"
sleep 1
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPERMISSION DANIED!\e[0m";
echo -e "\e[31mContact Admin for buy/register your ipvps\e[0m"
echo -e "\e[31mTelegram @EzcodeShop\e[0m"
sleep 5
exit 5
fi

#COLOUR
white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'

mkdir /var/lib/premium-script;
default_email=$( curl https://raw.githubusercontent.com/EZ-Code00/email/main/default.conf )
clear
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo -e "${blue}                  WELCOME TO PREMIUM SCRIPT                 ${NC}"
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "         This script will do the installation"
echo -e "                    By EZ-Code"
echo -e ""
echo -e "             ${cyan}Script made by @EzcodeShop ${red}❤️${NC}"
echo -e "${blue}════════════════════════════════════════════════════════════${NC}"
echo ""

#Nama penyedia script
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ${blue}PLEASE ENTER THE NAME OF PROVIDER SCRIPT."
read -p "   NAME : " nm
echo $nm > /home/provided
echo ""

#Email domain
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo -e ""
echo -e "   ${blue}PLEASE ENTER YOUR EMAIL DOMAIN CLOUFLARE."
echo -e "   \e[1;31m(Press ENTER for default email)\e[0m"
read -p "   Email : " email
default=${default_email}
new_email=$email
if [[ $email == "" ]]; then
sts=$default_email
else
sts=$new_email
fi
# email
mkdir -p /usr/local/etc/xray/
touch /usr/local/etc/xray/email
echo $sts > /usr/local/etc/xray/email

#SUBDOMAIN ENTER
echo ""
echo -e "${blue}════════════════════════════════════════════════════════════\e[0m"
echo ""
echo -e "   ENTER YOUR SUBDOMAIN (Example: sg.ezcode.shop)" 
echo ""
echo -e "   ${blue}Please enter your subdomain "
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/premium-script/ipvps.conf
echo $host1 > /root/domain
echo ""

#INSTALL SCRIPT
clear
echo ""
echo -e "${blue}READY FOR INSTALLATION SCRIPT...\e[0m"
sleep 1
echo ""
echo -e "DOWLOADING SSH & OPENVPN..."
echo ""
apt install ncurses-utils -y
#INSTALL SSH OVPN
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

#INSTALL WIREGUARD
echo -e "DOWLOADING WIREGUARD..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh

#INSTALL XRAY
echo -e "DOWLOADING XRAY..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/ins-xray.sh && chmod +x ins-xray.sh && screen -S ins-xray ./ins-xray.sh

#INSTALL SET-BR
echo -e "DOWLOADING SET-BR..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/set-br.sh && chmod +x set-br.sh && ./set-br.sh

#INSTALL OHP-SERVER
echo -e "DOWLOADING OHP SERVER..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/ohp.sh && chmod +x ohp.sh && ./ohp.sh
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/ohp-ssh.sh && chmod +x ohp-ssh.sh && ./ohp-ssh.sh

#INSTALL WEBSOCKET
echo -e "DOWLOADING WEBSOCKET SERVER..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/WEBSOCKET-PYTHON/websocket.sh && chmod +x websocket.sh && screen -S websocket.sh ./websocket.sh

clear
#INSTALL SLOW DNS SERVER
echo -e "DOWLOADING SLOW DNS SERVER..."
echo ""
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/INSTALL/slow-dns.sh && chmod +x slow-dns.sh && ./slow-dns.sh
echo ""
echo -e "\033[1;31m ATTENTION IN THIS STAGE! \033[1;33m"
echo ""
echo -ne "\033[1;32m ENTER YOUR NS FOR SLOW DNS (NAMESERVER)\033[1;37m: "; read nameserver
cd /etc/slowdns
touch infons
echo $nameserver > infons
sleep 1
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/SSH/startdns.sh
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/SSH/restartdns.sh
chmod +x startdns.sh
chmod +x restartdns.sh
sed -i "s;1234;$nameserver;g" /etc/slowdns/startdns.sh > /dev/null 2>&1
sed -i "s;1234;$nameserver;g" /etc/slowdns/restartdns.sh > /dev/null 2>&1
cp startdns.sh /bin/
cp restartdns.sh /bin/
echo ""
echo "Checking for existence of key"
sleep 1
echo ""
echo "      Please wait...   "
sleep 1
echo -e "There is no key in the logs"
echo ""
echo "How do you want to get your key?"
echo ""
echo "[ 1 ] | Generate on installation"
echo "[ 2 ] | Use the default key"
echo ""
read -p "Enter an options : " opc
if [[ $opc == "1" ]]; then
echo "Generating your key..."
cd /etc/slowdns/
./dns-server -gen-key -privkey-file /root/server.key -pubkey-file /root/server.pub
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
elif [[ $opc == "2" ]]; then
echo -e "Downloading default key pair..."
cd
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/server.key
wget https://raw.githubusercontent.com/Y16ZR/SCLITE/main/server.pub
sleep 1
echo -e "Download Completed"
sleep 1
cd /etc/slowdns/
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
./startdns.sh
else
clear
exit
fi

echo "1;37m" > /etc/box
echo "1;34m" > /etc/line
echo "46m" > /etc/back

#remove .sh
rm -f /root/ssh-vpn.sh
rm -f /root/wg.sh
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
rm -f /root/ohp-ssh.sh
rm -f /root/websocket.sh
rm -f /root/slow-dns.sh

cd
#VERSION
ver=$( curl https://raw.githubusercontent.com/EZ-Code00/version-sclite/main/version.conf )
history -c
echo "$ver" > /home/ver

#INSTALL INFORMATION PORT
wget -O /root/log-install.txt "https://raw.githubusercontent.com/Y16ZR/SCLITE/main/log-install.txt"
echo "Installation has been completed!!"
sleep 1
clear
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
echo -e "${blue}      SUCCESSFULLY INSTALLED PREMIUM SCRIPT         \033[0m"
echo -e "${blue}════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "Script created by Ez-Code"
echo ""
echo -e "For private concerns/report/donations: https://t.me/EzcodeShop"
echo ""
echo ""
echo -e "[Note] DO NOT RESELL THIS SCRIPT"
echo -e "THANKS FOR BUY & SUPPORT OUR BUSINESS"
echo ""
echo -e "             \033[1;33mINSTALLATION COMPLETED!\033[0m          "
echo ""
echo ""
echo ""
echo -e "${red}Auto reboot in 5 seconds...${NC}"
echo ""
rm -r choose.sh
rm -r setup.sh
sleep 5
reboot
