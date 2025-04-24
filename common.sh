systemd_setup() {
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}

artifact_download() {
  rm -rf /App
  mkdir /App
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/component-v3.zip
  cd /app
  unzip /tmp/$component.zip
}

nodejs() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  useradd roboshop
  cp $component.service /etc/systemd/system/$component.service
  artifact_download
  cd /app
  npm install
  systemd_setup
}