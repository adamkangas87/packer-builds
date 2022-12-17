echo "==> Installing Updates"
    subscription-manager register --username $SUBSCRIPTION_MANAGER_USERNAME --password $SUBSCRIPTION_MANAGER_PASSWORD --auto-attach
    yum update -y
    subscription-manager unregister