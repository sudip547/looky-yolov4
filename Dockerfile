# Use a base image
FROM python:3.12-slim

# Install OpenCV and dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxext6 libxrender-dev libgl1-mesa-glx ffmpeg \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose the port Railway provides
ENV PORT 8000
EXPOSE $PORT

# Run FastAPI using the env PORT
CMD ["sh", "-c", "uvicorn backend.main:app --host 0.0.0.0 --port $PORT"]

