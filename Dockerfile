# create build folder
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# run phase with nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html