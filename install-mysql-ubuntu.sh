
sudo apt update

sudo apt install mysql-server

mysql_secure_installation


mysql -uroot -p
CREATE USER 'u_zuling'@'%' IDENTIFIED BY '123';

GRANT ALL PRIVILEGES ON *.* TO 'u_zuling'@'%' WITH GRANT OPTION;

-----------------------------
vim /etc/mysql/mysql.conf.d/mysqld.cnf
mysqlx-bind-address     = 192.168.1.1
