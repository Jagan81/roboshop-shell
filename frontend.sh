Print_head() {
  echo -e "\e[35m$*\e[0m"
}

print_head disable default nginx
dnf module disable nginx -y >/tmp/roboshop.log

print_head Enable nginx 24
dnf module enable nginx:1.24 -y >/tmp/roboshop.log

print_head Install nginx
dnf install nginx -y >/tmp/roboshop.log

print_head Copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf >/tmp/roboshop.log

print_head Clean old content
rm -rf /usr/share/nginx/html/* >/tmp/roboshop.log

print_head Download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip >/tmp/roboshop.log
cd /usr/share/nginx/html

print_head Extract app content
unzip /tmp/frontend.zip >/tmp/roboshop.log

print_head Start nginx service
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log