$#!/bin/bash

# Setting varibles and colors 
domain=$1
RED="\033[1;31m"
RESET="\033[0m"

info_path=$domain/info
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots

# Making sure the right directories are in place to store our outputs
if [ ! -d "$domain" ];then
	mkdir $domain
fi

if [ ! -d "$info_path" ];then
	mkdir $info_path
fi

if [ ! -d "$subdomain_path" ];then
	mkdir $subdomain_path
fi

if [ ! -d "$screenshot_path" ];then
	mkdir $screenshot_path
fi

# Running the whois command and storing the output
echo -e "${RED} [+] Checkin' who it is ... ${RESET}"
whois $1 > $info_path/whois.txt

# Running Subfinder and storing the output
echo -e "${RED} [+] Launching subfinder ... ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

# Running assetfinder and storing the output
echo -e "${RED} [+] Running assetfinder ... ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

# Running Amass and storing the output
echo -e "${RED} [+] Running Amass.  This could take a while ... ${RESET}"
amass enum -d $domain >> $subdomain_path/found.txt

# Running httprobe and other things to see what domains are live and storing the output
echo -e "${RED} [+] Checkin' what's alive ... ${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

# Taking screenshots of the live sites and storing them in a folder
echo -e "${RED} [+] Taking dem screenshotz ... ${RESET}"
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http$#!/bin/bash

# Setting varibles and colors 
domain=$1
RED="\033[1;31m"
RESET="\033[0m"

info_path=$domain/info
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots

# Making sure the right directories are in place to store our outputs
if [ ! -d "$domain" ];then
	mkdir $domain
fi

if [ ! -d "$info_path" ];then
	mkdir $info_path
fi

if [ ! -d "$subdomain_path" ];then
	mkdir $subdomain_path
fi

if [ ! -d "$screenshot_path" ];then
	mkdir $screenshot_path
fi

# Running the whois command and storing the output
echo -e "${RED} [+] Checkin' who it is ... ${RESET}"
whois $1 > $info_path/whois.txt

# Running Subfinder and storing the output
echo -e "${RED} [+] Launching subfinder ... ${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

# Running assetfinder and storing the output
echo -e "${RED} [+] Running assetfinder ... ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

# Running Amass and storing the output
echo -e "${RED} [+] Running Amass.  This could take a while ... ${RESET}"
amass enum -d $domain >> $subdomain_path/found.txt

# Running httprobe and other things to see what domains are live and storing the output
echo -e "${RED} [+] Checkin' what's alive ... ${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

# Taking screenshots of the live sites and storing them in a folder
echo -e "${RED} [+] Taking dem screenshotz ... ${RESET}"
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http
