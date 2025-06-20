# Setup Instructions

This guide will help you get the Full-Stack Todo List application up and running on your computer using Docker. Don't worry if you're new to Docker - we'll walk through everything step by step!

## What You'll Need First

Before we start, make sure you have these tools installed on your macOS machine:

- **Docker Desktop**: Download from [docker.com](https://docker.com) - this includes both Docker and Docker Compose
- **Git**: Usually pre-installed on macOS, or get it from [git-scm.com](https://git-scm.com)
- **A terminal**: We'll use the built-in Terminal app with zsh (your default shell)

### Quick Check

Make sure you have the latest versions of Docker and Docker Compose. Open your Terminal and run:

```zsh
docker --version
docker-compose --version
git --version
```

If any command fails, you'll need to install that tool first.

## Getting the Code

### 1. Get the Project Files

```zsh
git clone git@github.com:blackdreamer15/azubi-cloud-assessment.git
cd fullstack-todo-list
```

*Note: If you're working on your own fork, replace the URL with your repository URL.*

### 2. Understanding What You Have

Take a look at the project structure. You should see:

- **Frontend/**: React application (the user interface)
- **Backend/**: Node.js API server (handles data and logic)  
- **docker-compose.yml**: The recipe that tells Docker how to run everything
- **Dockerfiles**: Instructions for building each part of the app

## Running the Application

### 3. Start Everything Up

This is the magic command that builds and starts all three parts of your application:

```zsh
docker-compose up --build
```

**What's happening behind the scenes:**

- Docker builds the Frontend (React + nginx web server)
- Docker builds the Backend (Node.js + Express API)
- Docker starts MongoDB database
- All three containers start talking to each other

You'll see lots of output - that's normal! Look for messages like "Frontend is ready" or "Backend listening on port 3000".

### 4. Check If Everything Worked

Open your web browser and visit these URLs:

- **Your Todo App**: [http://localhost:5173](http://localhost:5173) - This is where you'll use the app
- **API Server**: [http://localhost:3000](http://localhost:3000) - Technical endpoint (you might see a simple message)
- **Database**: Running on port 27017 (not visible in browser, but working behind the scenes)

If you see the Todo app interface, congratulations! Everything is working.

## When You're Done - Stopping the Application

### 5. Stop Everything Cleanly

When you're finished using the app, stop all containers:

```zsh
docker-compose down
```

This stops all containers but keeps your todo data safe.

### 6. Complete Reset (If Needed)

If you want to start completely fresh (warning: this deletes all your todos):

```zsh
docker-compose down -v
```

The `-v` flag removes the database volume, so you'll start with an empty todo list next time.

## Testing Your Setup

### 7. Verify Everything Works

We've included a simple test script to check all parts of your application:

```zsh
# Make the script executable
chmod +x run.sh

# Run the tests
./run.sh
```

This script will check:

- ✅ Frontend is accessible on port 5173
- ✅ Backend API is responding on port 3000
- ✅ Database is connected and working
- ✅ All containers are communicating properly

If all tests pass, you're ready to start adding todos!

## Development Tips

### Running in Background

If you want to use your terminal for other things while the app runs:

```zsh
# Start in background (detached mode)
docker-compose up -d

# Check status anytime
docker-compose ps

# View logs when needed
docker-compose logs -f
```

### Rebuilding After Changes

If you make changes to the code and want to see them:

```zsh
# Rebuild and restart
docker-compose up --build

# Or rebuild specific service
docker-compose build frontend
docker-compose up frontend
```

## What's Next?

- Try adding some todos to test the full workflow
- Check out `NETWORK_SECURITY.md` to understand how the containers communicate
- Look at `TROUBLESHOOTING.md` if you run into any issues
- Explore the code in `Frontend/` and `Backend/` directories

Ready to start building your todo list? Your containerized application is now running and ready to use!
