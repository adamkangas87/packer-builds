echo " ==> Installing yum-cron"
yum install yum-cron -y
cp  /etc/yum/yum-cron.conf

systemctl enable yum-cron
systemctl start yum-cron
