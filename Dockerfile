FROM --platform=$BUILDPLATFORM node:20.14-alpine3.20 AS build

WORKDIR /app

COPY . .

RUN yarn && yarn build

FROM --platform=$BUILDPLATFORM nginx:1.27.0-alpine-slim

COPY --from=build /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
