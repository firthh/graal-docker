
run-java:
	docker-compose down
	docker-compose up -d java-service

run-graal:
	docker-compose down
	docker-compose up -d graal-service

bench:
	ab -n500 -c1 localhost:3000/work/1000
