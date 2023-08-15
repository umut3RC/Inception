DC := docker-compose -f ./srcs/docker-compose.yml

all:
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mysql
	@mkdir -p $(HOME)/data/mariadb
	@$(DC) up -d --build

down:
	@$(DC) down

re: clean all

clean:
	@$(DC) down --rmi all --volumes
	@docker image prune -f
	@docker network prune -f
	@docker system prune -af

fclean: clean
	docker system prune -af
# @$(DC) down -v --remove-orphansd
# @docker rmi -f $$(docker images -q)

.PHONY: all down re clean fclean