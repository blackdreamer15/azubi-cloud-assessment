# Setup Instructions

This guide will walk you through the process of containerizing and running the Full-Stack Todo List application using Docker and Docker Compose.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- Docker
- Docker Compose
- Git

## Build and Run the Containers

### 1. Clone the repository

```bash
  git clone https://github.com/icnoka/fullstack-todo-list.git
  cd fullstack-todo-list
```

If the repository has a different Git origin (from cloning the original repo), update it:

```bash
  git remote remove origin
  git remote add origin <your-github-repository-url>
  git push -u origin main
```

### 2: Directory Structure Overview

The project is divided into the following components:

- Frontend: React-based application (Vite).
Backend: Node.js application (Express).
Database: MongoDB.

### 3. Dockerfile & Docker compose configurations

Make sure you have the following files:

- **docker-compose.yml** at the root of the project
- **Dockerfile** at the root of `Frontend` directory.
- **Dockerfile** at the root of `Backend` directory.

### 4. Run the Containers

Build and start the containers using Docker Compose:

```bash
  docker-compose up --build
```

### 5. Access the Application

- Frontend: [http://localhost](http://localhost)
- Backend API: [http://localhost:3000](http://localhost:3000)
- MongoDB: Accessible internally at [mongodb://database:27017/todos](mongodb://database:27017/todos)

### 6. Stop the Containers

To stop the application and remove the containers, run:

```bash
  docker-compose down
```

## Network and Security Configurations

- **Frontend:** Exposes port 80 to the host.
- **Backend:** Exposes port 3000 to the host.
- **Database:** Exposes port 27017 to the host (use caution in production).
- Use **environment variables** for sensitive data like database credentials.
- Do not expose unnecessary ports in production.

## Troubleshooting

### Common Issues

- Port Already in Use:

> Stop the process using the port, or change the host port in the docker-compose.yml file.

- Database Connection Error:

> Ensure MongoDB is running and accessible at mongodb://database:27017/todos.

- Permission Denied:

> Run Docker commands with sudo, or add your user to the docker group.

- Frontend Not Loading:

> Verify that the frontend container is running and accessible on port 80.

### Useful Commands

- List running containers:

```bash
  docker ps
```

- View container logs:

```bash
  docker logs <container_name>
```

## Container Testing Script

Use the following commands to test the components:

1. **Frontend:**

Open a browser and navigate to [http://localhost](http://localhost).

2. **Backend:**

Use curl or Postman to test the backend:

```bash
  curl http://localhost:3000/api/todos
```

3. **Database:**

Enter the MongoDB shell:

```bash
  docker exec -it mongo-db mongosh
```

Check the database:

```bash
  show dbs
```
