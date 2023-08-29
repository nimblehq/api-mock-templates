[Prism](https://github.com/stoplightio/prism) is used to easily spin up a mock server based on the OpenAPI specification file.

## Using Prism in Local Development

Developers can set up a mock server with Prism using Docker Compose.

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

## Deploying Prism

To support deploying the Mock Server via Dockerfile. Developers can create a `Dockerfile`:

    ```docker
    FROM stoplight/prism:latest

    COPY /docs /usr/src/prism/packages/cli/docs/

    EXPOSE 80
    CMD ["mock", "-h", "0.0.0.0", "-p", "80", "docs/openapi/openapi.yml"]
    ```
