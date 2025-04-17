@echo off
title Looky - Live Object Detection Web App

echo 🔧 Starting YOLOv4 FastAPI backend...
cd backend
start cmd /k "uvicorn main:app --host 127.0.0.1 --port 8000"
cd ..

timeout /t 2 >nul

echo 🌐 Starting frontend (web interface)...
cd frontend
start http://localhost:5500
start cmd /k "python -m http.server 5500"
cd ..

echo.
echo ✅ App 'Looky' is now running!
echo 👉 Open http://localhost:5500 in your browser if it didn't open automatically.
pause
