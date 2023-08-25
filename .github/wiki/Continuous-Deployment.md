The `api-mock-templates` relies entirely on [Github Actions](https://github.com/nimblehq/api-mock-templates/actions) for all continuous deployments (CD).

### Continuous Deployment with Fly.io and GitHub Actions

To configure CD with [fly.io](http://fly.io) and GitHub Actions. Developers can follow these steps:

1. After launching a new app, to be able to deploy the application via CI, developers need to create a `Deploy Token` for the project.

  ![Go to application dashboard > Tokens > Create Deploy Token](/assets/images/token-fly.png)

2. Add the created Deploy Token to the [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) to use for GitHub Actions with the key name: `FLY_API_TOKEN`

3. Add a new GitHub workflow for deploying mock server

  ```yaml
  name: Deploy The Mock Server

  on:
    push:
      branches:
        - develop

  jobs:
    deploy:
      name: Deploy the mock server
      runs-on: ubuntu-latest
      steps:
        - name: Checkout
          uses: actions/checkout@v3

        - name: Set up flyctl
          uses: superfly/flyctl-actions/setup-flyctl@master

        - name: Deploy to fly
          run: flyctl deploy --remote-only
          env:
            FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
  ```
