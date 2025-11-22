# 🎯 Komplette Setup-Anleitung für Ihren PC

Diese Anleitung führt Sie Schritt für Schritt durch die Installation und Einrichtung des EU AI Act Compliance Checkers.

## 📂 Projekt-Struktur erstellen

### Schritt 1: Projekt-Ordner anlegen

```cmd
# Wechseln Sie zu Ihrem gewünschten Verzeichnis (z.B. Desktop oder Dokumente)
cd C:\Users\IhrName\Desktop

# Erstellen Sie den Projekt-Ordner
mkdir EU-AI-Compliance
cd EU-AI-Compliance
```

Ihre Struktur wird so aussehen:
```
EU-AI-Compliance/
├── n8n/                    # n8n Workflow und Daten
│   ├── workflows/          # Workflow JSON Dateien
│   ├── .n8n/              # n8n Datenverzeichnis
│   └── docker-compose.yml  # Docker Konfiguration
├── frontend/              # Web-Frontend
│   ├── index.html         # Haupt-Anwendung
│   ├── server.js          # Node.js Server
│   └── package.json       # NPM Konfiguration
├── .env                   # Umgebungsvariablen (Ihre API Keys)
└── start.bat              # Alles-in-einem Startskript
```

---

## 🛠️ Schritt 2: Voraussetzungen installieren

### 2.1 Node.js installieren

1. Gehen Sie zu: https://nodejs.org/
2. Laden Sie **LTS Version** herunter (aktuell v20.x)
3. Installieren Sie mit Standard-Einstellungen
4. Testen Sie im Terminal:
   ```cmd
   node --version
   npm --version
   ```

### 2.2 Docker Desktop installieren

1. Gehen Sie zu: https://www.docker.com/products/docker-desktop
2. Laden Sie Docker Desktop für Windows herunter
3. Installieren Sie und starten Sie Docker Desktop
4. Testen Sie:
   ```cmd
   docker --version
   docker-compose --version
   ```

### 2.3 ngrok installieren

1. Gehen Sie zu: https://ngrok.com/download
2. Laden Sie ngrok für Windows herunter
3. Entpacken Sie ngrok.exe
4. Verschieben Sie ngrok.exe nach `C:\Windows\System32` oder fügen Sie den Pfad zu PATH hinzu
5. Erstellen Sie kostenloses Konto auf ngrok.com
6. Authentifizieren Sie ngrok:
   ```cmd
   ngrok config add-authtoken IHR_NGROK_TOKEN
   ```

---

## 📥 Schritt 3: Projekt-Dateien einrichten

### 3.1 Projekt-Dateien herunterladen/erstellen

Erstellen Sie folgende Ordner:

```cmd
mkdir n8n
mkdir n8n\workflows
mkdir frontend
```

### 3.2 n8n Docker Setup

Erstellen Sie `n8n\docker-compose.yml`:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    restart: unless-stopped
    environment:
      POSTGRES_DB: n8n
      POSTGRES_USER: n8n
      POSTGRES_PASSWORD: n8npassword
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  n8n:
    image: n8nio/n8n:latest
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=admin123
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=n8npassword
      - N8N_PROTOCOL=http
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - WEBHOOK_URL=http://localhost:5678
    volumes:
      - n8n_data:/home/node/.n8n
      - ./workflows:/home/node/.n8n/workflows
    depends_on:
      - postgres

volumes:
  postgres_data:
  n8n_data:
```

### 3.3 Workflow JSON vorbereiten

Kopieren Sie die Datei `n8n-workflow-eu-ai-act-compliance.json` nach:
```
n8n\workflows\eu-ai-compliance.json
```

### 3.4 Frontend-Dateien erstellen

**Datei: `frontend\package.json`**
```json
{
  "name": "eu-ai-frontend",
  "version": "1.0.0",
  "scripts": {
    "start": "node server.js"
  }
}
```

**Datei: `frontend\server.js`**
```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
    const filePath = path.join(__dirname, 'index.html');
    fs.readFile(filePath, (err, content) => {
        if (err) {
            res.writeHead(500);
            res.end('Server Error');
            return;
        }
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(content);
    });
});

server.listen(PORT, () => {
    console.log('╔════════════════════════════════════════════╗');
    console.log('║  EU AI Act Compliance Checker - Frontend  ║');
    console.log('╚════════════════════════════════════════════╝');
    console.log('');
    console.log('✓ Server läuft auf: http://localhost:' + PORT);
    console.log('');
    console.log('Öffnen Sie im Browser: http://localhost:' + PORT);
    console.log('');
    console.log('Drücken Sie Strg+C zum Beenden');
    console.log('');
});
```

**Datei: `frontend\index.html`**
- Kopieren Sie den kompletten Inhalt aus der bereits erstellten `frontend/index.html`

---

## 🔑 Schritt 4: API-Keys vorbereiten

### 4.1 OpenAI API Key erstellen

1. Gehen Sie zu: https://platform.openai.com/api-keys
2. Melden Sie sich an / registrieren Sie sich
3. Klicken Sie auf "Create new secret key"
4. Kopieren Sie den Key (beginnt mit `sk-...`)
5. **Speichern Sie ihn sicher!**

### 4.2 Umgebungsvariablen-Datei erstellen

Erstellen Sie `.env` im Hauptverzeichnis:

```env
# OpenAI Configuration
OPENAI_API_KEY=sk-ihr-api-key-hier

# n8n Configuration
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=admin123

# ngrok URLs (werden später ausgefüllt)
NGROK_FRONTEND_URL=
NGROK_N8N_URL=
```

---

## 🚀 Schritt 5: System starten

### 5.1 Haupt-Startskript erstellen

Erstellen Sie `start.bat` im Hauptverzeichnis:

```batch
@echo off
color 0A
title EU AI Act Compliance Checker - Starter

echo ╔═══════════════════════════════════════════════════════════╗
echo ║     EU AI Act Compliance Checker - System Starter        ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo [1/5] Prüfe Docker...
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker läuft nicht! Bitte Docker Desktop starten.
    pause
    exit /b 1
)
echo ✓ Docker läuft

echo.
echo [2/5] Starte n8n Backend...
cd n8n
docker-compose up -d
if errorlevel 1 (
    echo ❌ Fehler beim Starten von n8n
    pause
    exit /b 1
)
echo ✓ n8n gestartet auf http://localhost:5678
cd ..

echo.
echo [3/5] Warte auf n8n Initialisierung...
timeout /t 10 /nobreak >nul
echo ✓ n8n bereit

echo.
echo [4/5] Starte Frontend...
cd frontend
start "Frontend Server" cmd /k "node server.js"
echo ✓ Frontend gestartet auf http://localhost:3000
cd ..

echo.
echo [5/5] System-Übersicht
echo ═══════════════════════════════════════════════════════════
echo.
echo 📊 n8n Admin Panel:    http://localhost:5678
echo    Login: admin / admin123
echo.
echo 🌐 Frontend:           http://localhost:3000
echo.
echo 📝 Nächste Schritte:
echo    1. Öffnen Sie http://localhost:5678
echo    2. Importieren Sie den Workflow
echo    3. Konfigurieren Sie OpenAI API Key
echo    4. Aktivieren Sie den Workflow
echo    5. Öffnen Sie http://localhost:3000
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
```

### 5.2 ngrok Startskript erstellen

Erstellen Sie `start-ngrok.bat`:

```batch
@echo off
color 0B
title ngrok - Öffentlicher Zugriff

echo ╔═══════════════════════════════════════════════════════════╗
echo ║              ngrok - Öffentlicher Zugriff                 ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo Starte ngrok für Frontend (Port 3000)...
start "ngrok - Frontend" cmd /k "ngrok http 3000"

timeout /t 3 /nobreak >nul

echo.
echo Starte ngrok für n8n API (Port 5678)...
start "ngrok - n8n API" cmd /k "ngrok http 5678"

echo.
echo ═══════════════════════════════════════════════════════════
echo.
echo ✓ Zwei ngrok Fenster wurden geöffnet:
echo.
echo   1. Frontend ngrok (Port 3000)
echo      → Kopieren Sie die https://... URL
echo.
echo   2. n8n API ngrok (Port 5678)
echo      → Kopieren Sie die https://... URL
echo.
echo 📝 Wichtig:
echo    Öffnen Sie die Frontend-URL im Browser
echo    Tragen Sie die API-URL in der Konfiguration ein
echo.
echo ═══════════════════════════════════════════════════════════
echo.
pause
```

### 5.3 Stop-Script erstellen

Erstellen Sie `stop.bat`:

```batch
@echo off
echo Stoppe Frontend...
taskkill /FI "WINDOWTITLE eq Frontend Server*" /F >nul 2>&1

echo Stoppe n8n...
cd n8n
docker-compose down

echo.
echo ✓ Alle Services gestoppt
pause
```

---

## 📋 Schritt 6: Erste Inbetriebnahme

### 6.1 System starten

1. **Doppelklick auf `start.bat`**
2. Warten Sie, bis alle Services gestartet sind
3. Zwei Browser-Tabs öffnen:
   - Tab 1: http://localhost:5678 (n8n)
   - Tab 2: http://localhost:3000 (Frontend)

### 6.2 n8n konfigurieren

**Im Browser auf http://localhost:5678:**

1. Login: `admin` / `admin123`

2. **Workflow importieren:**
   - Klicken Sie oben rechts auf das **+** Symbol
   - Wählen Sie **Import from File**
   - Wählen Sie `n8n\workflows\eu-ai-compliance.json`
   - Klicken Sie **Import**

3. **OpenAI Credentials konfigurieren:**
   - Klicken Sie auf **Credentials** (links in der Sidebar)
   - Klicken Sie **Add Credential**
   - Wählen Sie **OpenAI API**
   - Name: `OpenAI Account`
   - API Key: Ihr OpenAI Key (aus Schritt 4.1)
   - Klicken Sie **Save**

4. **Workflow aktivieren:**
   - Öffnen Sie den importierten Workflow
   - Klicken Sie oben rechts auf **Activate**
   - Der Schalter wird grün ✓

### 6.3 Frontend testen

**Im Browser auf http://localhost:3000:**

1. **Registrieren:**
   - Klicken Sie auf Tab "Registrieren"
   - Füllen Sie alle Felder aus
   - Klicken Sie "Registrieren"
   - Sie sollten "Registrierung erfolgreich!" sehen

2. **Test-Analyse:**
   - Sie werden automatisch zum "Analyse" Tab weitergeleitet
   - Wählen Sie "Beschreibung"
   - Geben Sie ein:
     ```
     KI-System zur automatischen Gesichtserkennung
     in öffentlichen Gebäuden ohne menschliche Aufsicht.
     ```
   - Klicken Sie "Analyse starten"
   - Warten Sie 30-60 Sekunden
   - Ergebnis sollte erscheinen mit PDF-Download

✅ **Wenn das funktioniert, ist Ihr lokales System bereit!**

---

## 🌐 Schritt 7: Mit ngrok öffentlich machen

### 7.1 ngrok starten

1. **Doppelklick auf `start-ngrok.bat`**
2. Es öffnen sich 2 Command-Fenster

**Fenster 1 - Frontend:**
```
Session Status    online
Forwarding        https://abc123.ngrok.io -> http://localhost:3000
```
👉 **Kopieren Sie die https://... URL** (Frontend URL)

**Fenster 2 - n8n API:**
```
Session Status    online
Forwarding        https://xyz789.ngrok.io -> http://localhost:5678
```
👉 **Kopieren Sie die https://... URL** (API URL)

### 7.2 Frontend für ngrok konfigurieren

1. Öffnen Sie Ihre **Frontend ngrok URL** im Browser:
   ```
   https://abc123.ngrok.io
   ```

2. In der **gelben Konfigurations-Box** oben:
   - Feld "n8n Webhook URL"
   - Tragen Sie ein: `https://xyz789.ngrok.io/webhook`
   - Die Einstellung wird automatisch gespeichert

3. **Testen Sie:**
   - Registrieren Sie sich erneut (oder melden Sie sich an)
   - Starten Sie eine Analyse
   - Sollte funktionieren! ✓

### 7.3 URL teilen

Sie können jetzt die Frontend-URL teilen:
```
https://abc123.ngrok.io
```

**Wichtig:** ngrok URLs ändern sich bei jedem Neustart (kostenlose Version)!

---

## 📁 Finale Projekt-Struktur

```
C:\Users\IhrName\Desktop\EU-AI-Compliance\
│
├── n8n\
│   ├── workflows\
│   │   └── eu-ai-compliance.json        # Ihr Workflow
│   └── docker-compose.yml               # Docker Config
│
├── frontend\
│   ├── index.html                       # Web-App
│   ├── server.js                        # HTTP Server
│   └── package.json                     # NPM Config
│
├── .env                                 # API Keys (GEHEIM!)
├── start.bat                            # Alles starten
├── start-ngrok.bat                      # ngrok starten
├── stop.bat                             # Alles stoppen
│
└── SETUP-ANLEITUNG.md                   # Diese Datei
```

---

## 🔄 Täglicher Workflow

### Morgens starten:

```batch
1. Doppelklick: start.bat
2. Warten bis alles läuft
3. (Optional) start-ngrok.bat für öffentlichen Zugriff
```

### Abends beenden:

```batch
1. Doppelklick: stop.bat
2. Schließen Sie die ngrok-Fenster
```

---

## 🆘 Fehlerbehebung

### Problem: "Docker ist nicht verfügbar"

**Lösung:**
1. Starten Sie Docker Desktop
2. Warten Sie, bis Docker läuft (grünes Symbol im Tray)
3. Führen Sie `start.bat` erneut aus

### Problem: "Port 5678 is already in use"

**Lösung:**
```cmd
cd n8n
docker-compose down
docker-compose up -d
```

### Problem: "Port 3000 is already in use"

**Lösung:**
```cmd
# Finden Sie den Prozess
netstat -ano | findstr :3000

# Beenden Sie ihn (ersetzen Sie PID mit der Prozess-ID)
taskkill /PID <PID> /F
```

### Problem: "OpenAI API Error"

**Lösung:**
1. Überprüfen Sie Ihren API Key in n8n
2. Stellen Sie sicher, dass Sie Guthaben haben: https://platform.openai.com/usage
3. Überprüfen Sie Rate Limits

### Problem: "Workflow nicht aktiviert"

**Lösung:**
1. Öffnen Sie http://localhost:5678
2. Öffnen Sie den Workflow
3. Klicken Sie oben rechts auf **Activate**
4. Der Toggle sollte grün sein

### Problem: ngrok "ERR_NGROK_108"

**Lösung:**
```cmd
ngrok config add-authtoken IHR_NGROK_TOKEN
```
Token von: https://dashboard.ngrok.com/get-started/your-authtoken

---

## 📊 System-Status überprüfen

### Prüfen ob alles läuft:

```cmd
# Docker Container
docker ps

# Sollte zeigen:
# - postgres (Port 5432)
# - n8n (Port 5678)

# Frontend
# Öffnen Sie: http://localhost:3000
# Sollte die Web-App zeigen

# n8n
# Öffnen Sie: http://localhost:5678
# Sollte Login-Seite zeigen
```

---

## 💰 Kosten-Übersicht

- **Docker Desktop:** Kostenlos
- **Node.js:** Kostenlos
- **ngrok (Free):** Kostenlos (URLs ändern sich)
- **ngrok (Paid):** $8/Monat (feste URLs)
- **OpenAI API:** ~$0.01-0.03 pro Analyse (GPT-4)
- **OpenAI API:** ~$0.001 pro Analyse (GPT-3.5)

**Tipp:** Erste $5 bei OpenAI sind kostenlos!

---

## 🎯 Nächste Schritte

Nach erfolgreichem Setup:

1. ✅ **Testen Sie verschiedene KI-Systeme**
2. ✅ **Passen Sie den Workflow an** (in n8n)
3. ✅ **Teilen Sie die ngrok URL** mit Kollegen
4. ✅ **Erstellen Sie eine Dokumentation** Ihrer Ergebnisse
5. ✅ **Erweitern Sie das System** nach Ihren Bedürfnissen

---

## 📞 Support & Ressourcen

- **n8n Dokumentation:** https://docs.n8n.io
- **OpenAI API Docs:** https://platform.openai.com/docs
- **ngrok Dokumentation:** https://ngrok.com/docs
- **Docker Dokumentation:** https://docs.docker.com

---

**Viel Erfolg mit Ihrem EU AI Act Compliance Checker! 🎉**

Bei Fragen oder Problemen schauen Sie zuerst in die Fehlerbehebung oder die Logs:
```cmd
cd n8n
docker-compose logs -f
```
