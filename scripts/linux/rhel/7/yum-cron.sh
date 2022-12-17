echo " ==> Installing yum-cron"
subscription-manager register --username $SUBSCRIPTION_MANAGER_USERNAME --password $SUBSCRIPTION_MANAGER_PASSWORD --auto-attach
yum install yum-cron -y
subscription-manager unregister
cp  /etc/yum/yum-cron.conf

systemctl enable yum-cron
systemctl start yum-cron
