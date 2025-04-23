#!/usr/bin/env bash

# Download weights if not present
if [ ! -f backend/yolov4-tiny.weights ]; then
  echo "Downloading yolov4-tiny.weights from Google Drive..."
  gdown --id 18YmokC8RyTIKA_FXDU_lY3zMC8dSWaKv -O backend/yolov4-tiny.weights
fi

# Start FastAPI server
uvicorn backend.main:app --host 0.0.0.0 --port 10000

