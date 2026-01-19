# Homework 1: Docker, SQL and Terraform

## Question 1: 
What's the version of pip in the python:3.13 image?

Answer: 25.3

Script: 
```shell 
docker run -i -t python:3.13
pip --version
```

## Question 2: 
Given the docker-compose.yaml, what is the hostname and port that pgadmin should use to connect to the postgres database?

Answer: postgres:5432

Why: containername -> hostname = postgres, port = 5432

## Question 3:
run the created docker image:
docker run -it \
  --network=01-docker-terraform_default \
  taxi_ingest:v001 \
    --pg-user=root \
    --pg-pass=root \
    --pg-host=pgdatabase \
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --year=2025 \
    --month=11 \
    --target-table=yellow_taxi_trips