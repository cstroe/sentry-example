# Sentry Spring Boot Example

Run a local Sentry instance.

## Postgres Volume

```
mkdir -p tmp/postgres-data
```

## Error Producing App

Build the error producing Spring Boot app:

```
./mvnw package
```

## Docker Compose

When running for the first time, we must migrate the database:
```
docker-compose up -d redis
docker-compose up -d postgres
docker run -it --rm -e SENTRY_SECRET_KEY="9g(+qd2_vp4ro-y8+2o+w==bvh^(@0w3v_-++7tjq1ylt+l)eb" --link sentryexample_postgres_1:postgres --link sentryexample_redis_1:redis --network sentryexample_default -e 'SENTRY_REDIS_HOST=redis' -e 'SENTRY_POSTGRES_HOST=postgres' -e 'SENTRY_DB_NAME=sentry' -e 'SENTRY_DB_USER=sentry' -e 'SENTRY_DB_PASSWORD=secret' sentry upgrade
```

Then run `docker-compose up -d`.  Subsequent runs can skip the database migration, because it will be saved in our volume.
