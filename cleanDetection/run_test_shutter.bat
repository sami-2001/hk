@echo off
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9002') do (
    taskkill /PID %%a /F
)
cd "C:\wamp\www\houseKeeping\cleanDetection"
python shutter_down.py
pause