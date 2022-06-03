#!/bin/bash
echo "`date`"

# khai bao mat khau cho user root
ROOTPASSWD='1234'
echo "Root password is ${MYSQL_ROOT_PASSWORD}"

# khởi động service
service mysql start

# sử dụng expect để tự động config cho mariadb
echo "Configiring mariadb.."
SECURE_MYSQL=$(expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"$MYSQL\r\"
    expect \"Set root password?\"
    send \"y\r\"
    expect \"New password:\"
    send \"$ROOTPASSWD\r\"
    expect \"Re-enter new password:\"
    send \"$ROOTPASSWD\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"n\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
    ")

echo "$SECURE_MYSQL"

#Create user and password
# tạo thêm tài khoản root
mysql -uroot -p${ROOTPASSWD} -e "CREATE USER 'root'@'%' IDENTIFIED BY '$ROOTPASSWD' "
# tao db
mysql -uroot -p${ROOTPASSWD} -e "CREATE DATABASE wordpress"
mysql -uroot -p${ROOTPASSWD} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
mysql -uroot -p${ROOTPASSWD} -e "FLUSH PRIVILEGES"

echo "Init db done"
echo "--------------------------------"
# chạy lệnh tail để giữ cho container không bị tắt
tail -f /var/log/mysql/*