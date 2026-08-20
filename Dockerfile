# syntax=docker/dockerfile:1

# ---- build stage: Node is used here and nowhere else ----
FROM node:22-alpine AS build

WORKDIR /app

# Copy manifests first so dependency installation caches independently of source.
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# ---- runtime stage: static files only, no Node, no source ----
FROM nginxinc/nginx-unprivileged:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8080
