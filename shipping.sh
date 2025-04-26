component=shipping
source common.sh

  maven_app_setup

  print_head Install MySQL Client
  dnf install mysql -y &>> $log_file

 print_head Load Schema
 mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/schema.sql &>> $log_file

 print_head Load user creation
 mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $log_file

 print_head Load Master Data
 mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $log_file


