#!/usr/bin/env bash

# Download weights if not already present
if [ ! -f backend/yolov4.weights ]; then
  echo "Downloading yolov4.weights from Google Drive..."
  gdown --id 1cyveqbqjkI5XDhiN3nN4WGa4kTbPFnRt -O backend/yolov4.weights
fi

# Start FastAPI app
echo "Starting FastAPI server..."
uvicorn backend.main:app --host 0.0.0.0 --port 10000
