#!/bin/bash

# Exit on fail
set -e

if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

nginx -c /etc/nginx/conf.d/default.conf

prism mock docs/openapi/openapi.yml -p 4011
