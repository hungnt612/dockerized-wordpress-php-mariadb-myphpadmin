#!/bin/bash
echo "`date`"

# khoi chay service php
service php7.2-fpm start
service nginx start

# chạy lệnh tail để giữ cho container không bị tắt
tail -f /var/log/nginx/*