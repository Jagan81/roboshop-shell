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

app_prereq() {
  useradd roboshop
    cp $component.service /etc/systemd/system/$component.service
}

nodejs_app_seetup() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y
  app_prereq
  artifact_download
  cd /app
  npm install
  systemd_setup
}

maven_app_setup() {
  dnf install maven -y
  app_prereq
  artifact_download
  cd /app
  mvn clean package
  mv target/$component-1.0.jar $component.jar
  systemd_setup
}

python_app_setup() {
  dnf install python3 gcc python3-devel -y
  app_prereq
  artifact_download
  cd /app
  pip3 install -r requirements.txt
  systemd_setup
}
