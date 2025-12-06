#!/bin/bash

export CURRENT_UID=$(id -u)
export CURRENT_GID=$(id -g)

PROFILE=${2:-dev}

case "$1" in
  "build")
    echo "☕️ Building application..."
    docker compose --profile build up;
    docker compose --profile build down;
    ;;
  "install")
    echo "🔨 Installing application..."
    docker compose --profile install up;
    docker compose --profile install down;
    ;;
  "up")
    echo "🚀 Starting application in $PROFILE mode..."
    docker compose --profile $PROFILE up -d;
    ;;
  "restart")
    echo "🌟 Restarting application in $PROFILE mode..."
    docker compose --profile $PROFILE restart;
    ;;
  "stop")
    echo "🛑 Stopping application in $PROFILE mode..."
    docker compose --profile $PROFILE stop;
    ;;
  "down")
    echo "❌ Stopping and removing application (all profiles)..."
    docker compose --profile build --profile run --profile dev down;
    ;;
  "logs")
    echo "👁️ Showing application logs in $PROFILE mode..."
    docker compose --profile $PROFILE logs -f;
    ;;
  "reset")
    echo "🔄 Resetting application in $PROFILE mode..."
    docker compose --profile build --profile run --profile dev down;
    docker compose --profile $PROFILE up -d;
    docker compose --profile $PROFILE logs -f;
    ;;
  "clean")
    echo "🧹 Cleaning application..."
    docker compose --profile install --profile build --profile run --profile dev down;
    rm -rf app/node_modules
    ;;
  *)
    cat README.MD
    exit 1
    ;;
esac
