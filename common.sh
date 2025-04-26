systemd_setup() {
  print_head Copy SystemD Service file
  cp $component.service /etc/systemd/system/$component.service &>> $log_file
  echo $?

 print_head Start Service
  systemctl daemon-reload &>> $log_file
  systemctl enable $component &>> $log_file
  systemctl restart $component &>> $log_file
  echo $?

}

artifact_download() {
  print_head Add Application user
  useradd roboshop &>> $log_file
  echo $?


  print_head Remove existing application code
  rm -rf /App &>> $log_file
  echo $?

  print_head create Application directory
  mkdir /App &>> $log_file
  echo $?

  print_head Download Application Content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/component-v3.zip &>> $log_file
  echo $?
  cd /app

  print_head Extract Application Content
  unzip /tmp/$component.zip &>> $log_file
  echo $?
}


nodejs_app_seetup() {
  print_head Disable NodeJS default version
  dnf module disable nodejs -y &>> $log_file

  print_head Enable NodeJS 20
  dnf module enable nodejs:20 -y &>> $log_file

  print_head Install NodeJS
  dnf install nodejs -y &>> $log_file

  artifact_download
  cd /app

  print_head Install NodeJS Dependencies
  npm install &>> $log_file

  systemd_setup
}

maven_app_setup() {
  print_head Install Maven
  dnf install maven -y &>> $log_file

  artifact_download
  cd /app

  print_head Install Maven Dependencies
  mvn clean package &>> $log_file
  mv target/$component-1.0.jar $component.jar &>> $log_file

  systemd_setup
}

python_app_setup() {
  print_head Install Python Packages
  dnf install python3 gcc python3-devel -y &>> $log_file


  artifact_download

  cd /app

  print_head Install Python Packages
  pip3 install -r requirements.txt &>> $log_file
  systemd_setup
}


Print_head() {
  echo -e "\e[35m$*\e[0m"
  echo "#########################################" &>> $log_file
  echo -e "\e[35m$*\e[0m" >> $log_file
    echo "#########################################" &>> $log_file
}

log_file=/tmp/roboshop.log
rm -f $log_file