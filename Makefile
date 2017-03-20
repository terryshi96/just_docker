RAKE = docker-compose run --rm app bundle exec rake
RUN = docker-compose run --rm app

install:
	@make secret
	@$(RUN) bundle install --retry=3 --jobs=2
	@$(RUN) bundle exec rails db:create
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails db:seed
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
update:
	@make secret
	@touch app.local.env
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
	@make stop && make start
	@make clean
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
secret:
	@test -f app.secret.env || echo "secret_key_base=`openssl rand -hex 32`" > app.secret.env
	@cat app.secret.env
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi