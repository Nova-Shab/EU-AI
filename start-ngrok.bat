@echo off
color 0B
title ngrok - Oeffentlicher Zugriff

echo ╔═══════════════════════════════════════════════════════════╗
echo ║              ngrok - Oeffentlicher Zugriff                ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo Starte ngrok fuer Frontend (Port 3000)...
start "ngrok - Frontend" cmd /k "ngrok http 3000"

timeout /t 3 /nobreak >nul

echo.
echo Starte ngrok fuer n8n API (Port 5678)...
start "ngrok - n8n API" cmd /k "ngrok http 5678"

echo.
echo ═══════════════════════════════════════════════════════════
echo.
echo [OK] Zwei ngrok Fenster wurden geoeffnet:
echo.
echo   1. Frontend ngrok (Port 3000)
echo      - Kopieren Sie die https://... URL
echo.
echo   2. n8n API ngrok (Port 5678)
echo      - Kopieren Sie die https://... URL
echo.
echo  Wichtig:
echo    - Oeffnen Sie die Frontend-URL im Browser
echo    - Tragen Sie die API-URL in der Konfiguration ein
echo      (Gelbe Box im Frontend)
echo.
echo  Beispiel:
echo    Frontend: https://abc123.ngrok.io
echo    API URL:  https://xyz789.ngrok.io/webhook
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
