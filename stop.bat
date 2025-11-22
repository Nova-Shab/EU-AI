@echo off
color 0C
title EU AI Act Compliance Checker - Stopper

echo ╔═══════════════════════════════════════════════════════════╗
echo ║     EU AI Act Compliance Checker - System Stopper        ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo [1/3] Stoppe Frontend...
taskkill /FI "WINDOWTITLE eq Frontend Server*" /F >nul 2>&1
if errorlevel 1 (
    echo [INFO] Kein Frontend-Prozess gefunden
) else (
    echo [OK] Frontend gestoppt
)

echo.
echo [2/3] Stoppe ngrok...
taskkill /IM ngrok.exe /F >nul 2>&1
if errorlevel 1 (
    echo [INFO] Kein ngrok-Prozess gefunden
) else (
    echo [OK] ngrok gestoppt
)

echo.
echo [3/3] Stoppe n8n und Datenbank...
cd n8n
docker-compose down
if errorlevel 1 (
    echo [WARNUNG] Fehler beim Stoppen von Docker
) else (
    echo [OK] n8n und Datenbank gestoppt
)
cd ..

echo.
echo ═══════════════════════════════════════════════════════════
echo.
echo [OK] Alle Services wurden gestoppt
echo.
echo  Zum erneuten Starten: start.bat ausfuehren
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
