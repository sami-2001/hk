@echo off
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9000') do (
    taskkill /PID %%a /F
)
cd "C:\wamp\www\houseKeeping\cleanDetection"
python dddflask_1.py
pause
