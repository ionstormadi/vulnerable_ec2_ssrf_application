#!/bin/bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server
systemctl start httpd
systemctl enable httpd
systemctl is-enabled httpd
yum install -y mod_ssl
cd /etc/pki/tls/certs
./make-dummy-cert localhost.crt
cd /etc/httpd/conf.d
sed '/^SSLCertificateKeyFile/ s/./#&/' ssl.conf >output.conf
mv output.conf ssl.conf -f
systemctl restart httpd
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
cat << EOF > /var/www/html/index.php
<?php

\$whitelist = array(
  "127.0.0.1"
);

\$url = \$_GET["url"];
\$parsed_url  = parse_url(\$url);
//echo \$parsed_url['scheme'];

//echo \$parsed_url['host'];

if (! (in_array(\$parsed_url['host'], \$whitelist))) {
        echo file_get_contents(\$url);
}

?>
EOF