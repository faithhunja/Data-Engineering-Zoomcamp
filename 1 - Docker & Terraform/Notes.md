## To convert a notebook to a Python file

```
uv run jupyter nbconvert --to=script data_ingestion.ipynb
mv data_ingestion.py ingest_data.py  # rename the Python file created
```

## To run the Python file to ingest NYC taxi data

```
uv run python ingest_data.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=yellow_taxi_trips
```

## To use a virtual Docker network to allow containers to communicate with each other

```
docker network create pg-network # create a virtual Docker network
docker network rm pg-network # remove the network
docker network ls # view existing networks
```

- In the Docker run command, specify `--network=pg-network` to run the containers in the created network.
- You can also specify the container names in the Docker run command to differentiate and allow the containers to find each other within the network. For example: `--name pgdatabase` and `--name pgadmin`. In this case, pgdatabase is the host name for the Postgres database server.

## To stop or remove Docker containers
```
docker stop $(docker ps -q) # stop all running containers
docker rm -f $(docker ps -aq) # stop and remove all containers
```
