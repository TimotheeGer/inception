FROM alpine:3.15

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb                                         \
        mariadb-common                                  \
        mariadb-client                                  \
        vim

COPY    ./tools/script.sh          /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]