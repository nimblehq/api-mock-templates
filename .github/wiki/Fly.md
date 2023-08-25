With [fly.io](http://fly.io), developers can host an API Mock Server for testing purposes.

## Prerequisites

- [OpenAPI](https://www.openapis.org/) to create API documentation.
- A [fly.io](http://fly.io) account and its [CLI tool](https://fly.io/docs/hands-on/install-flyctl/) to deploy the API mock server.

## Instructions

### Deploying the Mock Server to fly.io

The `api-mock-templates` support [Dockerfile](./Docker.md#deployment-with-dockerfile) for deployment. Developers can deploy it to [fly.io](https://fly.io) by following these steps:

1. Launch a new app with [fly.io](http://fly.io).

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
