source common.sh

echo -e " ${color} Copy MongoDB Repo file  ${nocolor} "
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file
stat_check $?

echo -e " ${color} Installing MongoDB Server ${nocolor} "
yum install mongodb-org -y  &>>$log_file
stat_check $?

echo -e " ${color} Update MongoDB Listen Address ${nocolor} "
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e " ${color} Start MongoDB Service ${nocolor} "
systemctl enable mongod  &>>$log_file
systemctl restart mongod  &>>$log_file
stat_check $?