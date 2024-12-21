#!/bin/bash

set -e

echo "Starting verification of containers..."

check_service() {
  local service_name=$1
  local port=$2

  echo "Checking ${service_name} on port ${port}..."
  if nc -zv localhost "$port" 2>/dev/null; then
    echo "${service_name} is running on port ${port} ✅"
  else
    echo "❌ ${service_name} is NOT running on port ${port}"
    exit 1
  fi
}

check_backend() {
  echo "Verifying Backend on port 3000..."
  if nc -zv localhost 3000 2>/dev/null; then
    echo "Backend is running on port 3000 ✅"
  else
    echo "❌ Backend is NOT running on port 3000"
    exit 1
  fi
}

check_frontend() {
  echo "Verifying Frontend on port 80..."
  if nc -zv localhost 80 2>/dev/null; then
    echo "Frontend is running on port 80 ✅"
  else
    echo "❌ Frontend is NOT running on port 80"
    exit 1
  fi
}

check_database() {
  DB_CONTAINER_NAME="mongo_db_container"
  echo "Verifying MongoDB container on port 27017..."

  if docker exec "$DB_CONTAINER_NAME" mongo --eval "db.stats()" >/dev/null 2>&1; then
    echo "Database is accessible ✅"
  else
    echo "❌ Database is NOT accessible"
    exit 1
  fi
}

check_service "Backend" 3000
check_service "Frontend" 80
check_service "MongoDB" 27017
check_database

echo "All services are running and accessible ✅"
