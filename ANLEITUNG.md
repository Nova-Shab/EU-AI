# 🚀 Schnellstart-Anleitung - EU AI Act Compliance Checker

Diese Anleitung zeigt Ihnen, wie Sie das komplette System in wenigen Minuten zum Laufen bringen.

## 📋 Was Sie benötigen

1. **Node.js** installiert (für das Frontend)
2. **Docker & Docker Compose** (für n8n und Datenbank)
3. **OpenAI API Key** (von https://platform.openai.com)
4. Optional: **ngrok** (um das Frontend öffentlich zugänglich zu machen)

## ⚡ Schnellstart in 3 Schritten

### Schritt 1: n8n Backend starten

```bash
# Umgebungsvariablen konfigurieren
cp .env.example .env
nano .env  # OpenAI API Key eintragen

# Docker Container starten
docker-compose up -d

# Überprüfen ob alles läuft
docker-compose ps
```

n8n läuft jetzt auf: **http://localhost:5678**

### Schritt 2: Workflow importieren und aktivieren

1. Öffnen Sie http://localhost:5678 im Browser
2. Login mit (Standard: `admin` / `changeme`)
3. Gehen Sie zu **Workflows** → **Import from File**
4. Wählen Sie `n8n-workflow-eu-ai-act-compliance.json`
5. Konfigurieren Sie die **OpenAI Credentials**:
   - Gehen Sie zu **Credentials** → **Create New**
   - Wählen Sie **OpenAI API**
   - Name: "OpenAI Account"
   - API Key: Ihr OpenAI API Key
   - Speichern
6. Öffnen Sie den Workflow und klicken Sie auf **Activate** (oben rechts)

### Schritt 3: Frontend starten

```bash
# Windows
start-frontend.bat

# Linux/Mac
./start-frontend.sh

# Oder manuell
cd frontend
node server.js
```

Frontend läuft jetzt auf: **http://localhost:3000**

## 🎉 Fertig! Jetzt können Sie loslegen

1. Öffnen Sie http://localhost:3000
2. Registrieren Sie sich
3. Analysieren Sie Ihr erstes KI-System!

---

## 🌐 Mit ngrok öffentlich machen (Optional)

Falls Sie das Frontend über das Internet zugänglich machen möchten:

### 1. ngrok installieren

Download von: https://ngrok.com/download

### 2. Frontend mit ngrok starten

```bash
# In Terminal 1: Frontend starten
cd frontend
node server.js

# In Terminal 2: ngrok starten
ngrok http 3000
```

Sie erhalten dann eine URL wie: `https://abc123.ngrok.io`

### 3. n8n auch öffentlich machen (für API-Zugriff)

```bash
# In Terminal 3: ngrok für n8n
ngrok http 5678
```

Sie erhalten dann eine URL wie: `https://xyz789.ngrok.io`

### 4. Frontend-Konfiguration anpassen

1. Öffnen Sie Ihre ngrok-Frontend-URL im Browser
2. In der gelben Box "API Konfiguration" tragen Sie ein:
   ```
   https://xyz789.ngrok.io/webhook
   ```
3. Die Einstellung wird automatisch gespeichert

---

## 🔧 Fehlerbehebung

### Problem: "Port 3000 already in use"

**Windows:**
```cmd
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**Linux/Mac:**
```bash
lsof -ti:3000 | xargs kill -9
```

### Problem: "Connection refused" beim Frontend

**Lösung:**
1. Überprüfen Sie, ob n8n läuft: http://localhost:5678
2. Überprüfen Sie, ob der Workflow **aktiviert** ist
3. Testen Sie die API direkt:
   ```bash
   curl http://localhost:5678/webhook/auth/login
   ```

### Problem: "Authentication failed"

**Lösung:**
1. Löschen Sie den Browser-Cache (F12 → Application → Local Storage → Clear)
2. Registrieren Sie sich erneut

### Problem: "OpenAI API Error"

**Lösung:**
1. Überprüfen Sie Ihren API Key in n8n
2. Stellen Sie sicher, dass Sie Guthaben haben
3. Überprüfen Sie die Rate Limits

---

## 📖 Ausführliche Dokumentation

- **README.md** - Komplette technische Dokumentation
- **QUICKSTART.md** - Detaillierte Installationsanleitung
- **FRONTEND-INTEGRATION.md** - API-Dokumentation
- **EU-AI-ACT-REQUIREMENTS.md** - EU AI Act Anforderungen
- **frontend/README.md** - Frontend-spezifische Dokumentation

---

## 🎯 Beispiel-Workflow

### 1. Registrierung
- Name: Max Mustermann
- Firma: Acme GmbH
- E-Mail: max@acme.de
- Passwort: Sicher123!

### 2. Analyse eines Hochrisiko-Systems

**Beschreibung:**
```
Unser KI-System nutzt Gesichtserkennung zur automatischen
Zugangsgewährung in Bürogebäuden. Es verarbeitet biometrische
Daten in Echtzeit und trifft Zugriffsentscheidungen ohne
menschliche Aufsicht. Das System wird auch zur Überwachung
der Mitarbeiterleistung eingesetzt.
```

**Erwartetes Ergebnis:**
- Risikostufe: **High Risk**
- Mehrere Non-Konformitäten
- Detaillierter Maßnahmenkatalog
- PDF-Report zum Download

### 3. Analyse eines Minimal-Risiko-Systems

**Beschreibung:**
```
Unser KI-System optimiert die Lagerverwaltung durch
Vorhersage des Bedarfs basierend auf historischen
Verkaufsdaten. Es gibt Empfehlungen für Bestellmengen,
die finale Entscheidung trifft immer ein Mitarbeiter.
```

**Erwartetes Ergebnis:**
- Risikostufe: **Minimal Risk**
- Wenige oder keine Non-Konformitäten
- Grundlegende Empfehlungen

---

## 💡 Tipps & Tricks

### Bessere Analyse-Ergebnisse

1. **Detaillierte Beschreibungen**: Je mehr Details, desto genauer die Analyse
2. **Kontext angeben**: Erwähnen Sie Einsatzbereich und Zielgruppe
3. **Datenverarbeitung beschreiben**: Welche Daten werden wie verarbeitet?
4. **Automatisierungsgrad**: Gibt es menschliche Aufsicht?

### Performance optimieren

1. **GPT-3.5 nutzen**: Schneller und günstiger (in n8n Workflow ändern)
2. **Caching aktivieren**: Wiederholte Analysen beschleunigen
3. **Rate Limiting**: Vermeiden Sie zu viele gleichzeitige Anfragen

### Kosten sparen

- GPT-4 Turbo: ~0.01-0.03 € pro Analyse
- GPT-3.5 Turbo: ~0.001-0.003 € pro Analyse
- Erste 5$ bei OpenAI sind kostenlos

---

## 🔒 Sicherheitshinweise

⚠️ **Wichtig für Produktiv-Einsatz:**

1. **Passwörter ändern**: In `.env` alle Standard-Passwörter ändern
2. **HTTPS verwenden**: Niemals ohne SSL in Produktion
3. **API Keys schützen**: Niemals in Git committen
4. **Backups erstellen**: Regelmäßige Datenbank-Backups
5. **Updates einspielen**: n8n und Dependencies aktuell halten

---

## 📊 Systemanforderungen

**Minimum:**
- 2 GB RAM
- 10 GB Festplatte
- Internet-Verbindung

**Empfohlen:**
- 4 GB RAM
- 20 GB Festplatte
- Schnelle Internet-Verbindung

---

## 🆘 Support

**Bei Problemen:**

1. **Logs prüfen:**
   ```bash
   docker-compose logs -f n8n
   ```

2. **Browser-Console öffnen:** F12 → Console

3. **API direkt testen:**
   ```bash
   curl -X POST http://localhost:5678/webhook/auth/register \
     -H "Content-Type: application/json" \
     -d '{"email":"test@test.de","password":"test123","fullName":"Test","company":"Test"}'
   ```

4. **Neustart versuchen:**
   ```bash
   docker-compose restart
   ```

5. **Komplett neu starten:**
   ```bash
   docker-compose down
   docker-compose up -d
   ```

---

## 📅 Nächste Schritte

Nach dem erfolgreichen Start:

1. ✅ **Produktiv-Deployment**: Siehe README.md für Deployment-Guide
2. ✅ **Anpassungen**: Workflow nach Ihren Bedürfnissen anpassen
3. ✅ **Integration**: Frontend in Ihre Website einbinden
4. ✅ **Schulung**: Team mit dem System vertraut machen

---

**Viel Erfolg mit dem EU AI Act Compliance Checker! 🎉**

Bei Fragen oder Problemen schauen Sie in die ausführliche Dokumentation oder erstellen Sie ein GitHub Issue.
