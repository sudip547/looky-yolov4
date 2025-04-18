#!/bin/bash
# This script is used to start the FastAPI app

# Install dependencies
pip install -r requirements.txt

# Start the app
uvicorn main:app --host 0.0.0.0 --port $PORT

