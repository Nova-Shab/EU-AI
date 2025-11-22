@echo off
color 0E
title Projekt-Verzeichnisse erstellen

echo ╔═══════════════════════════════════════════════════════════╗
echo ║       EU AI Act - Projekt-Verzeichnisse erstellen        ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo Erstelle Projekt-Struktur...
echo.

REM Hauptverzeichnisse erstellen
if not exist "n8n" mkdir n8n
echo [OK] Verzeichnis 'n8n' erstellt

if not exist "n8n\workflows" mkdir n8n\workflows
echo [OK] Verzeichnis 'n8n\workflows' erstellt

if not exist "frontend" mkdir frontend
echo [OK] Verzeichnis 'frontend' erstellt

echo.
echo ═══════════════════════════════════════════════════════════
echo.
echo [OK] Projekt-Struktur wurde erstellt:
echo.
echo   EU-AI-Compliance\
echo   ├── n8n\
echo   │   └── workflows\
echo   └── frontend\
echo.
echo  Naechste Schritte:
echo.
echo  1. Kopieren Sie die JSON-Datei nach:
echo     n8n\workflows\eu-ai-compliance.json
echo.
echo  2. Kopieren Sie die Frontend-Dateien nach:
echo     frontend\index.html
echo     frontend\server.js
echo     frontend\package.json
echo.
echo  3. Erstellen Sie die docker-compose.yml in:
echo     n8n\docker-compose.yml
echo.
echo  4. Erstellen Sie die .env Datei mit Ihrem OpenAI Key
echo.
echo  5. Fuehren Sie start.bat aus
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
