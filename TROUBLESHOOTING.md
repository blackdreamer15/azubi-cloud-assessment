# Troubleshooting Guide

Common issues and solutions for the containerized Todo List application.

## Common Issues

### 1. Port Already in Use

**Error**: `bind: address already in use`

**Solution**:

```zsh
# Check what's using the port
lsof -i :5173
lsof -i :3000
lsof -i :27017

# Kill the process if needed
kill -9 <PID>

# Or use different ports in docker-compose.yml
```

### 2. Containers Won't Start

**Error**: Container exits immediately

**Diagnostic Commands**:

```zsh
# Check container status
docker-compose ps

# View logs
docker-compose logs frontend
docker-compose logs backend
docker-compose logs database

# Check Docker daemon
docker info
```

**Common Solutions**:

- Restart Docker Desktop
- Clean up old containers: `docker-compose down && docker system prune -f`
- Rebuild images: `docker-compose build --no-cache`

### 3. Frontend Shows "Cannot Connect to Backend"

**Symptoms**: Frontend loads but API calls fail

**Diagnostic Steps**:

```zsh
# Test backend directly
curl http://localhost:3000

# Check if backend container is running
docker-compose ps backend

# Check backend logs
docker-compose logs backend
```

**Solutions**:

- Ensure backend is running: `docker-compose up backend`
- Check API endpoints in browser dev tools
- Verify network connectivity between containers

### 4. Database Connection Issues

**Error**: `MongoNetworkError` or connection refused

**Diagnostic Commands**:

```zsh
# Check if MongoDB is running
docker-compose ps database

# Test database connection
docker-compose exec database mongo --eval "db.stats()"

# Check database logs
docker-compose logs database
```

**Solutions**:

- Wait longer for MongoDB to initialize (can take 30+ seconds)
- Check database volume: `docker volume ls`
- Restart database: `docker-compose restart database`

### 5. MongoDB Authentication Errors

**Error**: `MongoServerError: Authentication failed`

**Common Causes**:

- Backend connection string missing `authSource=admin`
- Mismatched credentials between docker-compose.yml and backend code
- Database container state corruption from previous runs

**Solutions**:

```zsh
# Check backend connection string includes authSource=admin
# Should be: mongodb://rootuser:rootpassword123@database:27017?authSource=admin

# Reset database completely
docker-compose down -v
docker-compose up --build

# Check credentials match in docker-compose.yml and Backend/index.js
```

### 6. Build Failures

**Error**: Docker build fails during npm install

**Solutions**:

```zsh
# Clear Docker cache
docker builder prune

# Rebuild without cache
docker-compose build --no-cache

# Check .dockerignore files exist
ls Frontend/.dockerignore Backend/.dockerignore
```

## Diagnostic Commands

### Check Container Health

```zsh
# All services status
docker-compose ps

# Individual service logs
docker-compose logs -f <service-name>

# Execute commands in containers
docker-compose exec backend sh
docker-compose exec database mongosh
```

### Network Debugging

```zsh
# Test connectivity between containers
docker-compose exec backend ping database
docker-compose exec frontend ping backend

# Inspect networks
docker network ls
docker network inspect azubi-cloud-assessment_app-network
```

### Volume Management

```zsh
# List volumes
docker volume ls

# Inspect volume
docker volume inspect azubi-cloud-assessment_mydata

# Backup database (if needed)
docker-compose exec database mongodump --out /data/backup
```

## Recovery Procedures

### Complete Reset

```zsh
# Stop everything
docker-compose down -v

# Remove all containers and images
docker system prune -a

# Rebuild from scratch
docker-compose up --build
```

### Database Reset (Preserves Code)

```zsh
# Stop and remove database volume
docker-compose down
docker volume rm azubi-cloud-assessment_mydata

# Restart
docker-compose up
```

### Quick Restart

```zsh
# Restart specific service
docker-compose restart <service-name>

# Restart all services
docker-compose restart
```

## Performance Issues

### Slow Builds

- Ensure `.dockerignore` files are present
- Use `docker-compose build --parallel`
- Check available disk space: `df -h`

### Container Resource Usage

```zsh
# Monitor resource usage
docker stats

# Check system resources
top
```

If problems persist, check Docker Desktop settings for resource allocation (CPU, Memory).
