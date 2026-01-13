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