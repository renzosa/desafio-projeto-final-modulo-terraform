#!/bin/bash
dnf update -y
dnf install nginx -y

# Enable EPEL repository
dnf install epel-release -y

# Install Remi repository for PHP 8.3
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm -y

# Enable PHP 8.3 repository
dnf module reset php -y
dnf module enable php:remi-8.3 -y

# Install PHP and required extensions
dnf install php php-fpm php-cli php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json -y

# Configure PHP-FPM
systemctl start php-fpm
systemctl enable php-fpm

# Configure Nginx
cat > /etc/nginx/conf.d/default.conf <<'END'
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.php index.html;
    
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }
    
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
END

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create test PHP file
echo "<h1>Renzo APP</h1><hr /><?php phpinfo(); ?>" > /var/www/html/index.php

# Set proper permissions
chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html