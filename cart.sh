component=cart
source common.sh

dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

useradd roboshop

cp cart.service /etc/systemd/system/cart.service

rm -rf /App
mkdir /App

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

cd /app
npm install

systemd_setup