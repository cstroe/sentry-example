# Sentry Example

Run a local Sentry instance, and then test it with a simple Spring Boot app.

## Setup

### Postgres Volume

Create the directory to persist our Postgres databases:

```
mkdir -p tmp/postgres-data
```

It's expensive to create the database, so it's easier to pesist it between runs.

### Error Producing App

Build the error producing Spring Boot app:

```
./mvnw package
```

You need to do this before running `docker-compose`.

### Docker Compose

When running for the first time, we must migrate the database:

```
docker-compose up -d redis
docker-compose up -d postgres
docker run -it --rm -e SENTRY_SECRET_KEY="9g(+qd2_vp4ro-y8+2o+w==bvh^(@0w3v_-++7tjq1ylt+l)eb" --link sentryexample_postgres_1:postgres --link sentryexample_redis_1:redis --network sentryexample_default -e 'SENTRY_REDIS_HOST=redis' -e 'SENTRY_POSTGRES_HOST=postgres' -e 'SENTRY_DB_NAME=sentry' -e 'SENTRY_DB_USER=sentry' -e 'SENTRY_DB_PASSWORD=secret' sentry upgrade
```

You will be asked to create a user and to give it admin privileges.  Subsequent runs can skip this step, because the database files will be saved in our volume.

Then to run Sentry, execute `docker-compose up -d`.  

### Sentry UI

The Sentry UI will be accessile at [http://localhost:8080](http://localhost:8080).

## Usage

### Create a project

You first need to create a project for which Exceptions will be tracked.
Then, get your Client Key for that project and configure it in the `bootapp` environment variables.

### Publish exception

Navigate to [http://localhost:8081](http://localhost:8081) to trigger an exception.  A few seconds later, refresh the UI and see the exception on the screen.
