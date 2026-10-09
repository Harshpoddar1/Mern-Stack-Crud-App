# ---- Stage 1: Builder ----
FROM node:16-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build

# ---- Stage 2: FINAL ----

FROM nginx:alpine

RUN apk update && apk upgrade --no-cache

COPY --from=builder /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
