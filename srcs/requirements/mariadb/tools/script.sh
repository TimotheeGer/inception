#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	touch /var/lib/mysql/mysql.sock
	chown -R mysql:mysql /var/lib/mysql
	
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	config=`mktemp`

cat << EOF > $config

	USE mysql;
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
	CREATE DATABASE $MARIADB_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
	CREATE USER '$MARIADB_USER_NAME'@'%' IDENTIFIED by '$MARIADB_USER_PASSWORD';
	GRANT ALL PRIVILEGES ON $MARIADB_DB_NAME.* TO '$MARIADB_USER_NAME'@'%';
	FLUSH PRIVILEGES;
EOF

	/usr/bin/mysqld --user=mysql --bootstrap < $config
	unset config
fi

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console
