# Step 1: Build stage for the frontend application
FROM  node:latest AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


# Step 2: Serve stage for the frontend application
FROM nginx:1.25.2-alpine-slim

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
