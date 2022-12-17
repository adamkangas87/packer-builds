echo " ==> Installing dnf-automatic"
yum install dnf-automatic -y


systemctl enable dnf-automatic-download.timer 
systemctl enable dnf-automatic-install.timer   
systemctl enable dnf-automatic-notifyonly.timer
systemctl start dnf-automatic-download.timer
systemctl start dnf-automatic-install.timer  
systemctl start dnf-automatic-notifyonly.timer
