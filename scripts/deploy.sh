#!/bin/bash
set -e

APP_DIR="/home/appuser/go-notes"

echo "Starting deployement..."

cd "$APP_DIR"

git pull origin main

echo "Building application..."
go build -o go-notes-app .

echo "Restarting service..."
sudo systemctl restart go-notes

echo "Deployement completed"
