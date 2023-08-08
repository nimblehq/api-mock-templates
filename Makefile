.PHONY: dev

doc/generate:
	yarn run build:docs

dev:
	make doc/generate
	docker compose -f docker-compose.dev.yml up
