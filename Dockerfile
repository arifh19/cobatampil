# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY . .
RUN npm run build