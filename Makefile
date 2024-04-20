setup: install db-prepare copy-env

install:
	bin/setup

db-prepare:
	bin/rails db:reset

copy-env:
	cp -n .env.example .env
	$(info !!! Please fill the .env variables !!!)

start:
	bin/dev

console:
	bin/rails console

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop app -A

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test

.PHONY: test
