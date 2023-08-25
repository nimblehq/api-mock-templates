In the `api-mock-templates` project, we use `Dockerfile` for deployment and `Docker Compose` for development.

## Creating an API Mock Server with Prism

To create an API Mock Server, the team is using [Prism](https://github.com/stoplightio/prism) to mock API responses based on the OpenAPI specification file.

## Development with Docker Compose

After having the OpenAPI specification for [[API Documentation]], developers can set up a mock server with Prism using Docker Compose.

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

## Deployment with Dockerfile

To support deploying the Mock Server via Dockerfile. Developers can create a `Dockerfile`:

    ```docker
    FROM stoplight/prism:latest

    COPY /docs /usr/src/prism/packages/cli/docs/

    EXPOSE 80
    CMD ["mock", "-h", "0.0.0.0", "-p", "80", "docs/openapi/openapi.yml"]
    ```
