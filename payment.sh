component=payment
source common.sh


dnf install python3 gcc python3-devel -y

useradd roboshop

cp payment.service /etc/systemd/system/payment.service

artifact_download

cd /app
pip3 install -r requirements.txt

systemd_setup