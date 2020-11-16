docker-build:
	docker-compose up -d --build
docker-up:
	docker-compose up -d
docker-down:
	docker-compose down
docker-api:
	docker exec -it grape-api rackup