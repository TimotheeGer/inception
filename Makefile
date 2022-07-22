NAME =	INCEPTION

all:	clean start

re:		prune start

# conf:
# 		echo "127.0.0.1 tigerber.42.fr" >> /etc/hosts

start:
		mkdir -p /Users/timotheegerberon/data/wordpress \
		&& mkdir /Users/timotheegerberon/data/mariadb \
		&& docker-compose -f srcs/docker-compose.yml up --build

run:	
		docker-compose -f srcs/docker-compose.yml up

stop:
		docker-compose -f srcs/docker-compose.yml down

clean:	stop
		rm -rf /Users/timotheegerberon/data/wordpress
		rm -rf /Users/timotheegerberon/data/mariadb

prune:	clean
		docker-compose -f srcs/docker-compose.yml down --rmi all -y \
		&& docker system prune -f

.PHONY:	conf start stop clean prune run all create re 