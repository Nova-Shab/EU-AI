@echo off
color 0A
title EU AI Act Compliance Checker - Starter

echo ╔═══════════════════════════════════════════════════════════╗
echo ║     EU AI Act Compliance Checker - System Starter        ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo [1/5] Pruefe Docker...
docker info >nul 2>&1
if errorlevel 1 (
    echo X Docker laeuft nicht! Bitte Docker Desktop starten.
    pause
    exit /b 1
)
echo [OK] Docker laeuft

echo.
echo [2/5] Starte n8n Backend...
cd n8n
docker-compose up -d
if errorlevel 1 (
    echo X Fehler beim Starten von n8n
    pause
    exit /b 1
)
echo [OK] n8n gestartet auf http://localhost:5678
cd ..

echo.
echo [3/5] Warte auf n8n Initialisierung...
timeout /t 10 /nobreak >nul
echo [OK] n8n bereit

echo.
echo [4/5] Starte Frontend...
cd frontend
start "Frontend Server" cmd /k "node server.js"
echo [OK] Frontend gestartet auf http://localhost:3000
cd ..

echo.
echo [5/5] System-Uebersicht
echo ═══════════════════════════════════════════════════════════
echo.
echo  n8n Admin Panel:    http://localhost:5678
echo    Login: admin / admin123
echo.
echo  Frontend:           http://localhost:3000
echo.
echo  Naechste Schritte:
echo    1. Oeffnen Sie http://localhost:5678
echo    2. Importieren Sie den Workflow
echo    3. Konfigurieren Sie OpenAI API Key
echo    4. Aktivieren Sie den Workflow
echo    5. Oeffnen Sie http://localhost:3000
echo.
echo  Zum Stoppen: stop.bat ausfuehren
echo  Fuer oeffentlichen Zugriff: start-ngrok.bat
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
