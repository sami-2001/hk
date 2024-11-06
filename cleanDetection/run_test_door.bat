@echo off
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9001') do (
    taskkill /PID %%a /F
)
cd "C:\wamp\www\houseKeeping\cleanDetection"
python chest_doors.py
pause
