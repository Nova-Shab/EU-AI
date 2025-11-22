# 🚀 Quick Reference - EU AI Act Compliance Checker

Schnelle Übersicht für den täglichen Gebrauch.

---

## 📂 Datei-Übersicht

| Datei | Zweck |
|-------|-------|
| `start.bat` | Startet n8n + Frontend |
| `start-ngrok.bat` | Startet ngrok (öffentlich) |
| `stop.bat` | Stoppt alle Services |
| `setup-verzeichnisse.bat` | Erstellt Ordnerstruktur |
| `.env` | API Keys (GEHEIM!) |

---

## 🔗 URLs

| Service | URL | Credentials |
|---------|-----|-------------|
| **n8n Admin** | http://localhost:5678 | admin / admin123 |
| **Frontend** | http://localhost:3000 | - |
| **PostgreSQL** | localhost:5432 | n8n / n8npassword |

---

## ⚡ Schnellstart

### Lokal starten:
```cmd
start.bat
```

### Mit ngrok:
```cmd
start.bat
start-ngrok.bat
```

### Stoppen:
```cmd
stop.bat
```

---

## 🔧 Wichtige Befehle

### Docker
```cmd
# Status prüfen
docker ps

# Logs ansehen
cd n8n
docker-compose logs -f

# Neustart
docker-compose restart

# Komplett neu
docker-compose down
docker-compose up -d
```

### Frontend
```cmd
# Starten
cd frontend
node server.js

# Port freigeben (wenn belegt)
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### ngrok
```cmd
# Frontend öffentlich
ngrok http 3000

# n8n API öffentlich
ngrok http 5678

# Auth Token setzen
ngrok config add-authtoken YOUR_TOKEN
```

---

## 🐛 Troubleshooting

| Problem | Lösung |
|---------|--------|
| Docker läuft nicht | Docker Desktop starten |
| Port 5678 belegt | `docker-compose down` → `docker-compose up -d` |
| Port 3000 belegt | `taskkill /PID <PID> /F` |
| Workflow nicht aktiv | n8n öffnen → Toggle auf grün |
| OpenAI Fehler | API Key prüfen, Guthaben prüfen |
| Frontend lädt nicht | Browser-Cache leeren (Strg+Shift+R) |
| ngrok Fehler | Auth Token neu setzen |

---

## 📊 Workflow Status prüfen

1. Öffne http://localhost:5678
2. Login: admin / admin123
3. Workflow öffnen
4. Oben rechts: Toggle muss **grün** sein ✅

---

## 🔑 OpenAI API

### Credentials konfigurieren:
1. n8n öffnen (http://localhost:5678)
2. **Credentials** → **Add Credential**
3. **OpenAI API** wählen
4. Name: `OpenAI Account`
5. API Key: `sk-...`
6. **Save**

### Kosten:
- GPT-4 Turbo: ~€0.01-0.03 pro Analyse
- GPT-3.5 Turbo: ~€0.001 pro Analyse

### Guthaben prüfen:
https://platform.openai.com/usage

---

## 🌐 ngrok Konfiguration

### URLs kopieren:

**Nach Start von `start-ngrok.bat`:**

1. **Frontend-Fenster:**
   ```
   Forwarding: https://abc123.ngrok.io
   ```
   → Kopieren Sie diese URL

2. **API-Fenster:**
   ```
   Forwarding: https://xyz789.ngrok.io
   ```
   → Kopieren Sie diese URL

### Im Browser konfigurieren:

1. Öffne Frontend-URL: `https://abc123.ngrok.io`
2. Gelbe Box → "n8n Webhook URL"
3. Eintragen: `https://xyz789.ngrok.io/webhook`
4. Automatisch gespeichert ✓

---

## 📋 Test-Szenarien

### Hochrisiko-System:
```
Unser KI-System nutzt Gesichtserkennung zur
automatischen Zugangsgewährung in Bürogebäuden.
Es verarbeitet biometrische Daten in Echtzeit
ohne menschliche Aufsicht.
```
**Erwartung:** High Risk, viele Non-Konformitäten

### Geringes Risiko:
```
KI-basierter Spam-Filter für E-Mails.
```
**Erwartung:** Minimal Risk, wenige Non-Konformitäten

---

## 📁 Wichtige Dateipfade

```
EU-AI-Compliance\
├── n8n\
│   ├── workflows\
│   │   └── eu-ai-compliance.json    ← Workflow hier
│   └── docker-compose.yml           ← Docker Config
├── frontend\
│   ├── index.html                   ← Web-App
│   ├── server.js                    ← Server
│   └── package.json                 ← NPM Config
└── .env                             ← API Keys (GEHEIM!)
```

---

## 🔐 Sicherheit

### Wichtig:
- ❌ Niemals `.env` in Git committen
- ❌ Niemals API Keys teilen
- ✅ Admin-Passwort ändern (Produktion)
- ✅ HTTPS verwenden (Produktion)
- ✅ Regelmäßige Backups

### Admin-Passwort ändern:
1. Bearbeite `n8n\docker-compose.yml`
2. Ändere `N8N_BASIC_AUTH_PASSWORD`
3. Führe aus: `docker-compose down && docker-compose up -d`

---

## 📈 Performance-Tipps

### Schnellere Analysen:
1. In n8n: OpenAI Node öffnen
2. Model ändern zu: `gpt-3.5-turbo`
3. Save & Activate

### Kosten sparen:
- GPT-3.5 statt GPT-4 nutzen
- Batch-Analysen durchführen
- Cache aktivieren (fortgeschritten)

---

## 🆘 Support

### Logs prüfen:
```cmd
cd n8n
docker-compose logs -f n8n
```

### Browser Console:
`F12` → Console → Fehler kopieren

### API direkt testen:
```cmd
curl -X POST http://localhost:5678/webhook/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@test.de\",\"password\":\"test123\",\"fullName\":\"Test\",\"company\":\"Test\"}"
```

---

## 📞 Ressourcen

| Ressource | Link |
|-----------|------|
| n8n Docs | https://docs.n8n.io |
| OpenAI API | https://platform.openai.com/docs |
| ngrok Docs | https://ngrok.com/docs |
| Docker Docs | https://docs.docker.com |

---

## ⌨️ Tastenkürzel (Browser)

| Kürzel | Funktion |
|--------|----------|
| `F12` | DevTools öffnen |
| `Strg+Shift+R` | Hard Reload (Cache leeren) |
| `Strg+Shift+Delete` | Browser-Daten löschen |

---

## 🎯 Täglicher Workflow

### Morgens:
```
1. start.bat
2. (Optional) start-ngrok.bat
3. Analysieren!
```

### Abends:
```
1. stop.bat
2. ngrok-Fenster schließen
```

---

**Drucken Sie diese Seite aus und bewahren Sie sie als Referenz auf! 📄**
