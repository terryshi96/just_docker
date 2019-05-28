Rails = docker-compose run --rm app rails

restart:
	@make stop && make start
start:
	@docker-compose up -d
rebuild:
	@docker-compose up -d --build
status:
	@docker-compose ps
stop:
	@docker-compose stop app
stop-all:
	@docker-compose down
console:
	@$(Rails) console
migrate:
	@$(Rails) db:migrate
clean:
	@echo "Clean Docker containers and images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi
rm:
	@echo "Clean Docker  containers..."
	@docker ps -aqf status=exited | xargs docker rm
rmi:
	@echo "Clean Docker images..."
	@docker images -qf dangling=true | xargs docker rmi
build:
	@docker-compose build
