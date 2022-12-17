echo " ==> Installing dnf-automatic"
subscription-manager register --username $SUBSCRIPTION_MANAGER_USERNAME --password $SUBSCRIPTION_MANAGER_PASSWORD --auto-attach
yum install dnf-automatic -y
subscription-manager unregister


systemctl enable dnf-automatic-download.timer 
systemctl enable dnf-automatic-install.timer   
systemctl enable dnf-automatic-notifyonly.timer
systemctl start dnf-automatic-download.timer
systemctl start dnf-automatic-install.timer  
systemctl start dnf-automatic-notifyonly.timer
