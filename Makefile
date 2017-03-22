Rake = docker-compose run --rm app bundle exec rake
Rails = docker-compose run --rm app rails

restart:
	@make stop && make start
start:
	@docker-compose up -d
status:
	@docker-compose ps
stop:
	@docker-compose stop web app worker
stop-all:
	@docker-compose down
console:
	@$(Rails) console
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi
build:
	@docker-compose build
