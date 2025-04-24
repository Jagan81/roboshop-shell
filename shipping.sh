component=shipping
source common.sh

  maven_app_setup


  dnf install mysql -y
mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql-dev.jrdevops81.online -uroot -pRoboShop@1 < /app/db/master-data.sql


