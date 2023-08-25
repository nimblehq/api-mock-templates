With [fly.io](http://fly.io), developers can host an API Mock Server for testing purposes.

## Prerequisites

- [OpenAPI](https://www.openapis.org/) to create API documentation.
- A [fly.io](http://fly.io) account and its [CLI tool](https://fly.io/docs/hands-on/install-flyctl/) to deploy the API mock server.

## Instructions

### Creating an API Mock Server with Prism

After having the OpenAPI specification for API documentation, developers can set up a mock server with Prism using Docker Compose.

1. Create `docker-compose.dev.yml`

    ```yaml
    version: '3.2'

    services:
      prism:
        image: stoplight/prism:4
        container_name: nimble_survey_web_prism
        command: 'mock -h 0.0.0.0 /docs/openapi/openapi.yml'
        volumes:
          - ./docs:/docs
        ports:
          - "4010:4010"
    ```

2. Build and run with `docker compose`

    ```bash
    docker compose -f docker-compose.dev.yml up
    ```

### Deploying the Mock Server to fly.io

[Fly.io](http://Fly.io) supports deploying the Mock Server via Dockerfile. Developers can deploy it by following these steps:

1. Create `Dockerfile`

    ```docker
    FROM stoplight/prism:latest

    COPY /docs /usr/src/prism/packages/cli/docs/

    EXPOSE 80
    CMD ["mock", "-h", "0.0.0.0", "-p", "80", "docs/openapi/openapi.yml"]
    ```

2. Launch a new app with [fly.io](http://fly.io).

    ```bash
    fly launch --dockerfile Dockerfile
    ```

3. After launching a new app, the project will have the app configuration file from [fly.io](http://fly.io) (`fly.toml`). For instance:

    ```toml
    app = "api-mock-server"
    primary_region = "sin"

    [build]
      dockerfile = "Dockerfile"

    [http_service]
      internal_port = 80
      force_https = true
      auto_stop_machines = true
      auto_start_machines = true
      min_machines_running = 0
      processes = ["app"]
    ```

4. After having the configuration file, developers can deploy the app (mock server) to [fly.io](http://fly.io) with:

    ```bash
    fly deploy
    ```

{% include link-bookmark.html slug="https://fly.io/docs/languages-and-frameworks/dockerfile/" text="Details about deploying to fly.io via Dockerfile" %}
