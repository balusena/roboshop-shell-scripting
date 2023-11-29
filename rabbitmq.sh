source common.sh

echo -e " ${color}  Configure Erlang repos  ${nocolor} "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
stat_check $?

echo -e " ${color}  Configure RabbitMQ Repos  ${nocolor} "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
stat_check $?

echo -e " ${color}  Install RabbitMQ Server  ${nocolor} "
yum install rabbitmq-server -y &>>$log_file
stat_check $?

echo -e " ${color}  Start RabbitMQ Service  ${nocolor} "
systemctl enable rabbitmq-server &>>$log_file
systemctl restart rabbitmq-server &>>$log_file
stat_check $?

echo -e " ${color}  Add RabbitMQ Application User ${nocolor} "
rabbitmqctl add_user roboshop $1 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
stat_check $?