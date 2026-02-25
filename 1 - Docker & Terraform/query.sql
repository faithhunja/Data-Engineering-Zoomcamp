-- Implicit INNER JOIN

SELECT
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu.borough, ' | ', zpu.zone) AS "pickup_loc",
	CONCAT(zdo.borough, ' | ', zdo.zone) AS "dropoff_loc"
FROM 
	yellow_taxi_trips t,
	zones zpu,
	zones zdo
WHERE
	t."PULocationID" = zpu.locationid
	AND t."PULocationID" = zdo.locationid
LIMIT 100;

-- Explicit INNER JOIN

SELECT
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	CONCAT(zpu.borough, ' | ', zpu.zone) AS "pickup_loc",
	CONCAT(zdo.borough, ' | ', zdo.zone) AS "dropoff_loc"
FROM 
	yellow_taxi_trips t
JOIN zones zpu ON t."PULocationID" = zpu.locationid
JOIN zones zdo ON t."PULocationID" = zdo.locationid
LIMIT 100;

-- Check for NULL Location IDs

SELECT
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID"
FROM 
	yellow_taxi_trips
WHERE "PULocationID" IS NULL OR "DOLocationID" IS NULL;

-- Check for Location IDs not in the zones table

SELECT
	tpep_pickup_datetime,
	tpep_dropoff_datetime,
	total_amount,
	"PULocationID",
	"DOLocationID"
FROM 
	yellow_taxi_trips
WHERE "PULocationID" NOT IN (SELECT locationid FROM zones)
OR "DOLocationID" NOT IN (SELECT locationid FROM zones);

-- Using JOINS when some Location IDs are not in either Tables:

DELETE FROM zones WHERE locationid = 142;

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
	CONCAT(zpu.borough, ' | ', zpu.zone) AS "pickup_loc",
	CONCAT(zdo.borough, ' | ', zdo.zone) AS "dropoff_loc"
FROM
    yellow_taxi_trips t
LEFT JOIN
    zones zpu ON t."PULocationID" = zpu.locationid
JOIN
    zones zdo ON t."DOLocationID" = zdo.locationid
LIMIT 100;


SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
	CONCAT(zpu.borough, ' | ', zpu.zone) AS "pickup_loc",
	CONCAT(zdo.borough, ' | ', zdo.zone) AS "dropoff_loc"
FROM
    yellow_taxi_trips t
RIGHT JOIN
    zones zpu ON t."PULocationID" = zpu.locationid
JOIN
    zones zdo ON t."DOLocationID" = zdo.locationid
LIMIT 100;

-- Calculate the number of trips per day
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1)
FROM yellow_taxi_trips
GROUP BY "day";

-- Number of trips per day ordered by day
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) AS "trips"
FROM yellow_taxi_trips
GROUP BY "day"
ORDER BY "day" ASC;

-- Number of trips per day ordered by trips
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) AS "trips"
FROM yellow_taxi_trips
GROUP BY "day"
ORDER BY "trips" DESC;

-- Other aggregations
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) AS "trips",
    MAX(total_amount) AS "total_amount",
    MAX(passenger_count) AS "passenger_count"
FROM
    yellow_taxi_trips
GROUP BY
    "day"
ORDER BY
    "trips" DESC;

-- Grouping by multiple fields
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    "DOLocationID",
    COUNT(1) AS "trips",
    MAX(total_amount) AS "total_amount",
    MAX(passenger_count) AS "passenger_count"
FROM
    yellow_taxi_trips
GROUP BY
    1, 2
ORDER BY
    "day" ASC,
    "DOLocationID" ASC;
