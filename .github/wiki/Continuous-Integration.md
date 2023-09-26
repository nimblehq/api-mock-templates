The `api-mock-templates` relies entirely on [Github Actions](https://github.com/nimblehq/api-mock-templates/actions) for all continuous integration (CI).

## Continuous Integration

### Linting the OpenAPI specification file

```yaml
name: Lint

on: pull_request

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  docs_lint:
    name: Run lint for API docs
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Set up node and restore cached dependencies
        uses: actions/setup-node@v3
        with:
          node-version: "18.x"
          cache: yarn
          cache-dependency-path: yarn.lock

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Run API docs linters
        run: yarn lint:docs:public
```
