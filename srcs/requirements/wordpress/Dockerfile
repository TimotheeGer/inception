FROM 		alpine:3.15

RUN 		apk update && apk upgrade && apk add --no-cache \
			wget 											\
			tar 											\
			mariadb-client									\
			php7											\
			php7-bcmath 									\
			php7-bz2 										\
			php7-ctype 										\
			php7-curl 										\
			php7-dom 										\
			php7-enchant 									\
			php7-exif 										\
			php7-fpm 										\
			php7-gd 										\
			php7-gettext 									\	
			php7-gmp 										\
			php7-iconv										\
			php7-imap 										\
			php7-intl 										\
			php7-json 										\
			php7-mbstring 									\
			php7-mysqli										\
			php7-mysqlnd									\
			php7-opcache 									\
			php7-openssl 									\
			php7-phar 										\
			php7-posix 										\
			php7-pspell 									\
			php7-session 									\
			php7-simplexml 									\	
			php7-sockets 									\
			php7-sysvmsg 									\
			php7-sysvsem 									\
			php7-sysvshm 									\
			php7-tidy 										\
			php7-xml 										\
			php7-xmlreader 									\
			php7-xmlrpc 									\
			php7-xmlwriter 									\
			php7-xsl 										\
			php7-zip 										\
			php7-sqlite3									\
			php7-zlib	

RUN			adduser -S nginx &&	addgroup -S nginx
COPY 		conf/php-fpm.conf		/etc/php7/php-fpm.conf
COPY 		conf/www.conf 			/etc/php7/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

WORKDIR 	/var/www/html/wordpress/
	
COPY		/tools/script-start.sh /tmp/
ENTRYPOINT ["sh", "/tmp/script-start.sh"]