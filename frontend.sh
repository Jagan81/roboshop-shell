Print_head() {
  echo -e "\e[35m$*\e[0m"
  echo "#########################################" >> $log_file
  echo -e "\e[35m$*\e[0m" >> $log_file
    echo "#########################################" >> $log_file
}

log_file=/tmp/roboshop.log
rm -f $log_file

print_head disable default nginx
dnf module disable nginx -y >> $log_file

print_head Enable nginx 24
dnf module enable nginx:1.24 -y >> $log_file

print_head Install nginx
dnf install nginx -y >> $log_file

print_head Copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf >> $log_file

print_head Clean old content
rm -rf /usr/share/nginx/html/* >> $log_file

print_head Download app content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip >> $log_file
cd /usr/share/nginx/html

print_head Extract app content
unzip /tmp/frontend.zip >> $log_file

print_head Start nginx service
systemctl enable nginx >> $log_file
systemctl restart nginx >> $log_file