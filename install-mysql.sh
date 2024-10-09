#!/bin/bash

MYSQL="mysql-5.7.38-el7-x86_64"

test -f ./${MYSQL}.tar.gz || 
wget https://downloads.mysql.com/archives/get/p/23/file/${MYSQL}.tar.gz

#1 install dependence
echo "======= Checking dependence libaio========"
depen=`rpm -qa| grep libaio`
if [ -z $depen ]; then
	yum install libaio
else
	echo
	echo $depen
	echo
fi

#2 create the mysql user
groupadd mysql
useradd -r -g mysql mysql
#useradd -g mysql -d /usr/local/mysql -s /sbin/nologin -M mysql

#3 create the mysql base folder
tar xvf ./${MYSQL}.tar.gz -C /usr/local/
cd /usr/local
mv $MYSQL mysql
cd -

mkdir /usr/local/mysql/{data,log,tmp} -p
touch /usr/local/mysql/log/mysql.log
chown -R mysql:mysql /usr/local/mysql

#4 initialize mysql and start it
cp -f ./my.cnf /etc/
echo -e "\n ======== initialize mysql ========"
cd /usr/local/mysql
./bin/mysqld --initialize 

#5 start mysqld
echo -e "\n ======== starting mysql ========"
cp ./support-files/mysql.server /etc/init.d/mysql
/etc/init.d/mysql start

#6 set environment variable
cat <<EOF >> ~/.bash_profile
export PATH=$PATH:/usr/local/mysql/bin
EOF

source ~/.bash_profile

cat <<EOF

 ======== use this to login ========
mysql -u root -p

 ======== use this sql to change password ========
ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';
EOF
