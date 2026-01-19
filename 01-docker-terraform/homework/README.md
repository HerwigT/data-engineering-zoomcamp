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
For the trips in November 2025, how many trips had a trip_distance of less than or equal to 1 mile?
run the created docker image:
docker run -it \
  --network=homework_default \
  taxi_ingest_hw:v001 \
    --pg-user=root \
    --pg-pass=root \
    --pg-host=pgdatabase \
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --year=2025 \
    --month=11 \
    --target-table=yellow_taxi_trips

Answer: 8007

Query:
```sql
SELECT COUNT(*) FROM yellow_taxi_trips
WHERE trip_distance <= 1
```

## Question 4:
Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles. 

Answer: 2025-11-20

Query:
```sql
SELECT sum(trip_distance), date(lpep_pickup_datetime) FROM yellow_taxi_trips
WHERE trip_distance < 100
GROUP BY date(lpep_pickup_datetime)
ORDER BY 1 desc
```

## Question 5:
Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?

Answer: East Harlem North

Query:
```sql
SELECT zone from taxi_zone_lookup tz
where locationid = (SELECT pulocationid FROM(
SELECT COUNT(*) as cnt, pulocationid FROM yellow_taxi_trips
WHERE date(lpep_pickup_datetime) = '2025-11-18'
GROUP BY pulocationid
ORDER BY 1 desc
LIMIT 1)
```

## Question 6:
For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?

Answer: Yorkville West

Query:
```sql
SELECT zone from taxi_zone_lookup tz
where locationid = (SELECT dolocationid FROM(
SELECT max(tip_amount), dolocationid FROM yellow_taxi_trips yt
inner join taxi_zone_lookup tz on yt.pulocationid = tz.locationid
WHERE tz.zone = 'East Harlem North'
GROUP BY dolocationid
ORDER BY 1 desc
LIMIT 1))
```

## Question 7:
Which of the following sequences describes the Terraform workflow for: 1) Downloading plugins and setting up backend, 2) Generating and executing changes, 3) Removing all resources?

Answer: terraform init, terraform apply -auto-approve, terraform destroy