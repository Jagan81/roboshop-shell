component=shipping
source common.sh

  maven_app_setup

  print_head Install MySQL Client
  dnf install mysql -y &>> $log_file

 for file in schema app-user master-data;do
 print_head Load $file
 mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/$file.sql &>> $log_file


