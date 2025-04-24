echo -e "\e[35mdisable default nginx\e[0m"
dnf module disable nginx -y

echo -e "\e[35mEnable nginx 24\e[0m"
dnf module enable nginx:1.24 -y

echo -e "\e[35mInstall nginx\e[0m"
dnf install nginx -y

echo -e "\e[35mCopy nginx config file\e[0m"
cp nginx.conf /etc/nginx/nginx.conf

echo -e "\e[35mClean old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35mDownload app content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html

echo -e "\e[35mExtract app content\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[35mStart nginx service\e[0m"
systemctl enable nginx
systemctl restart nginx