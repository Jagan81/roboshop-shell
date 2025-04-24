echo disable default nginx
dnf module disable nginx -y

echo enable nginx 24
dnf module enable nginx:1.24 -y

echo install nginx
dnf install nginx -y

echo copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf

echo clean old content
rm -rf /usr/share/nginx/html/*

echo download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html

echo extract app content
unzip /tmp/frontend.zip

echo start nginx service
systemctl enable nginx
systemctl restart nginx