FROM node:18-slim

WORKDIR /api_mock

RUN apt update && apt install -y nginx

COPY package.json yarn.lock ./
RUN yarn global add @stoplight/prism-cli@5

COPY start.sh index.html ./
COPY docs ./docs
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4010

CMD ./start.sh
