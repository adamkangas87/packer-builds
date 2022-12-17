echo " ==> Installing Additional Applications"
subscription-manager register --username $SUBSCRIPTION_MANAGER_USERNAME --password $SUBSCRIPTION_MANAGER_PASSWORD --auto-attach
yum install open-vm-tools -y
yum install perl -y
subscription-manager unregister