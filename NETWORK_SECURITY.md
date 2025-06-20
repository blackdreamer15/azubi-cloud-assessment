# Network and Security Configurations

This document explains how our containerized Todo List application is set up from a networking and security perspective. Think of it as a guide to understanding what's happening "under the hood" when you run the application.

## How the Application Components Talk to Each Other

Our application uses Docker's networking features to create a safe, isolated environment where all three parts can communicate with each other while staying secure from the outside world.

### The Big Picture

```yaml
You (Browser) → Frontend Container → Backend Container → Database Container
   ↓               ↓                   ↓                   ↓
localhost:5173   nginx:80           express:3000       mongodb:27017
```

When you open the app in your browser, here's what happens:

1. Your browser talks to the **Frontend** (React app served by nginx)
2. The Frontend makes API calls to the **Backend** (Node.js/Express server)
3. The Backend stores and retrieves data from the **Database** (MongoDB)

## Port Configuration Explained

### Frontend Service

- **What it runs**: React application served by nginx web server
- **Inside the container**: nginx listens on port 80 (standard web port)
- **On your computer**: You access it via [http://localhost:5173](http://localhost:5173)
- **Why this setup**: Docker maps your computer's port 5173 to the container's port 80

### Backend Service

- **What it runs**: Node.js API server with Express framework
- **Inside the container**: Express server runs on port 3000
- **On your computer**: You can test it at [http://localhost:3000](http://localhost:3000)
- **Why this setup**: Simple 1-to-1 port mapping (3000 → 3000)

### Database Service

- **What it runs**: MongoDB database for storing todo items
- **Inside the container**: MongoDB runs on port 27017 (standard MongoDB port)
- **On your computer**: Available at [mongodb://localhost:27017](mongodb://localhost:27017)
- **Why this setup**: Direct port mapping allows you to connect with database tools if needed

## Security Features Built-In

### Network Isolation - Keeping Things Safe

Think of our `app-network` as a private neighborhood where only our three containers live. Here's what this means:

- **Containers talk to each other by name**: Instead of using IP addresses (which can change), our Backend can simply call `http://database:27017` to reach MongoDB
- **External protection**: The outside world can only access what we explicitly allow through port mappings
- **No accidental exposure**: Services not meant for public access stay hidden

### Container Security - Running Safely

We've designed each container with security in mind:

- **Frontend container**: Runs nginx web server, which naturally runs with limited privileges
- **Backend container**: Uses the standard Node.js user (not the dangerous "root" user)
- **Database container**: Uses MongoDB's official Docker image with built-in security practices

### Data Protection

Your todo data is stored securely:

- **Persistent storage**: Uses Docker's managed volume system (`mydata` volume)
- **Data survives restarts**: Even if you stop and restart containers, your todos remain
- **Isolated from your computer**: Database files are managed by Docker, not mixed with your personal files

## Current Setup vs. Production Ready

### What We Have Now (Development Mode)

This setup is perfect for learning and development:

```yaml
# Current configuration - great for development
ports:
  - "5173:80"   # Frontend accessible from outside
  - "3000:3000" # Backend accessible for testing
  - "27017:27017" # Database accessible for debugging
```

### What You'd Want in Production

For a real-world deployment, you'd make these changes:

- **Remove database exposure**: Don't map port 27017 to the outside world
- **Add authentication**: Require usernames/passwords for database access
- **Use HTTPS**: Encrypt communication with SSL certificates
- **Add environment variables**: Store sensitive settings outside the code
- **Implement monitoring**: Track performance and security

## Quick Security Tips

### For Development (What You're Doing Now)

- ✅ This setup is fine for learning and local development
- ✅ All services are properly isolated in their own network
- ✅ No sensitive data is exposed (we're not using real user passwords)

### If You Deploy This Somewhere

- 🔒 Change database port mapping to internal-only
- 🔒 Add MongoDB authentication
- 🔒 Use environment variables for any secrets
- 🔒 Set up proper logging and monitoring

Remember: The goal of this setup is to learn containerization concepts safely. The security measures we've implemented are appropriate for development and learning purposes!
