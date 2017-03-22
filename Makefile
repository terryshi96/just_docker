Rake = docker-compose run --rm app bundle exec rake
Rails = docker-compose run --rm app rails

build:
    @docker-compose build
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
	@$(RUN) bundle exec rails console
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi

