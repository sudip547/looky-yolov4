FROM python:3.12-slim

# Install OpenCV and other required system packages
RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxext6 libxrender-dev libgl1-mesa-glx ffmpeg \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy everything to the container
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Railway uses this env var for port
ENV PORT=8000

# Expose the port to Railway
EXPOSE $PORT

# Use entrypoint to ensure $PORT is parsed correctly
ENTRYPOINT ["sh", "-c", "uvicorn backend.main:app --host 0.0.0.0 --port $PORT"]


