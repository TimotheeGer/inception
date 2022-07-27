NAME =	INCEPTION

all:	clean start

re:		prune start

start:
		mkdir /home/tigerber/data/wordpress \
		&& mkdir /home/tigerber/data/mariadb \
		&& docker-compose -f srcs/docker-compose.yml up --build

run:	
		docker-compose -f srcs/docker-compose.yml up

stop:
		docker-compose -f srcs/docker-compose.yml down

clean:	stop
		rm -rf /home/tigerber/data/wordpress
		rm -rf /home/tigerber/data/mariadb

prune:	clean
		docker-compose -f srcs/docker-compose.yml down -v --rmi all -y \
		&& docker system prune -a -f \
		&& docker volume rm srcs_mariadb_data \
		&& docker volume rm srcs_wordpress_data


.PHONY:	conf start stop clean prune run all create re 