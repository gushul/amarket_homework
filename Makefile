.PHONY: setup server console test migrate down

setup: ## Set up the project for the first time
	docker-compose build
	docker-compose run --rm api bin/setup

server: ## Run the server
	docker-compose up

console: ## Open a Rails console
	docker-compose run --rm api rails c

test: ## Run the test suite
	docker-compose run --rm api rspec

migrate: ## Run database migrations
	docker-compose run --rm api rails db:migrate

down: ## Take down the Docker environment
	docker-compose down

