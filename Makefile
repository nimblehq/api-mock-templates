.PHONY: install-dependencies doc/generate dev

install-dependencies:
	yarn install

doc/generate:
	yarn run build:docs

dev:
	docker compose -f docker-compose.dev.yml up
