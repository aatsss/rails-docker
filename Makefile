.PHONY: build runAPP runDB restart stop

COMPOSE := docker-compose


build:
	${COMPOSE} build

runAPP:
	${COMPOSE} run --no-deps web rails new . --force --database=postgresql

runDB:
	${COMPOSE} run web rake db:create

up: 
	${COMPOSE} up 

restart: 
	${COMPOSE} up --build

stop:
	${COMPOSE} down

