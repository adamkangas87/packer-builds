echo " ==> Configuring Proxy"
    cat  >>/etc/environment <<EOF
http_proxy=""
https_proxy=""
ftp_proxy=""
HTTP_PROXY=""
HTTPS_PROXY=""
FTP_PROXY=""
no_proxy=""
EOF
    . /etc/environment
    cat /etc/environment