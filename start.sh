#!/bin/bash
# This script is used to start the FastAPI app

# Check if PORT environment variable is set, otherwise default to 8000
PORT=${PORT:-8000}

# Run the app
uvicorn main:app --host 0.0.0.0 --port "$PORT"


