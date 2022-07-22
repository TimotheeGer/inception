#!/bin/sh

# wait for mysql
echo "Let's go!"
echo "wait mariadb!"

while ! mariadb -h$MARIADB_MYSQL_HOST -u$MARIADB_USER_NAME -p$MARIADB_USER_PASSWORD $MARIADB_DB_NAME &>/dev/null; do
    sleep 3
done

# if [ ! -f "/var/www/html/index.html" ]; then

	#use default index.html
    # mv /tmp/index.html /var/www/html/index.html

	#wordpress config available at /tigerber.42.fr/wordpress
	#or /tigerber.42.fr/wordpress/wp-login.php
    wp core download --allow-root
    wp config create --dbname=$MARIADB_DB_NAME --dbuser=$MARIADB_USER_NAME --dbpass=$MARIADB_USER_PASSWORD --dbhost=$MARIADB_MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=tigerber.42.fr --title=$WORDPRESS_WEBSITE_TITLE --admin_user=$WORDPRESS_ADMIN_NAME --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER_NAME $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
    # wp theme install inspiro --activate --allow-root

    # wp plugin update --all --allow-root

# fi

#wp redis enable --allow-root

echo "Done!" 
/usr/sbin/php-fpm7 -F -R
exec '@'