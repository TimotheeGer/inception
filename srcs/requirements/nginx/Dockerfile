FROM	alpine:3.15

RUN 	apk update && apk upgrade && apk add --no-cache \
		nginx \
		sudo \
		vim \
		openssl

RUN 	mkdir /etc/nginx/ssl
RUN 	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75017/L=Paris/O=42/CN=tigerber' \
 			-keyout /etc/nginx/ssl/tigerber.key -out /etc/nginx/ssl/tigerber.pem

RUN 	chown -R nginx:nginx /var/www;

RUN 	mkdir -p /run/nginx
COPY 	./conf/nginx.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]