# EU AI Act Compliance Checker - Frontend

Eine einfache, benutzerfreundliche Web-Oberfläche für den EU AI Act Compliance Checker.

## Features

- 🔐 **Benutzer-Authentifizierung**: Registrierung und Login
- 🔍 **Flexible Eingabe**: URL oder Textbeschreibung
- 📊 **Echtzeit-Analyse**: Live-Feedback während der Analyse
- 📄 **PDF-Download**: Professionelle Compliance-Reports
- 🌐 **Mehrsprachig**: Deutsche Benutzeroberfläche
- 📱 **Responsiv**: Funktioniert auf Desktop und Mobile

## Schnellstart

### Option 1: Einfacher HTTP-Server (Empfohlen)

```bash
cd frontend
node server.js
```

Öffnen Sie dann: http://localhost:3000

### Option 2: Python HTTP-Server

```bash
cd frontend
python -m http.server 3000
```

### Option 3: Mit npx (keine Installation nötig)

```bash
cd frontend
npx http-server -p 3000
```

## Mit ngrok öffentlich machen

Wenn Sie das Frontend öffentlich verfügbar machen möchten:

```bash
# Frontend starten (in einem Terminal)
cd frontend
node server.js

# ngrok starten (in einem anderen Terminal)
ngrok http 3000
```

ngrok gibt Ihnen dann eine öffentliche URL wie:
```
https://abc123.ngrok.io
```

## Konfiguration

### n8n Webhook URL anpassen

1. Öffnen Sie das Frontend im Browser
2. Oben in der gelben Box finden Sie das Feld "n8n Webhook URL"
3. Ändern Sie die URL entsprechend:
   - **Lokal**: `http://localhost:5678/webhook`
   - **Mit ngrok**: `https://ihre-ngrok-url.ngrok.io/webhook`
   - **Produktiv**: `https://ihre-domain.com/webhook`

Die URL wird automatisch im Browser gespeichert.

## Verwendung

### 1. Registrierung

1. Klicken Sie auf den Tab "Registrieren"
2. Geben Sie Ihre Daten ein:
   - Vollständiger Name
   - Firma
   - E-Mail
   - Passwort (mindestens 6 Zeichen)
3. Klicken Sie auf "Registrieren"

### 2. Login

1. Klicken Sie auf den Tab "Login"
2. Geben Sie E-Mail und Passwort ein
3. Klicken Sie auf "Anmelden"

### 3. KI-System analysieren

Nach dem Login:

1. Wechseln Sie zum Tab "Analyse"
2. Wählen Sie die Eingabeart:
   - **Website URL**: Geben Sie die URL Ihrer Website/App ein
   - **Beschreibung**: Beschreiben Sie Ihr KI-System im Detail
3. Klicken Sie auf "Analyse starten"
4. Warten Sie 30-60 Sekunden auf das Ergebnis
5. Laden Sie den PDF-Report herunter

## Beispiel-Beschreibungen

### Hochrisiko-System

```
Unser KI-System nutzt Gesichtserkennung zur automatischen
Zugangsgewährung in Bürogebäuden. Es verarbeitet biometrische
Daten in Echtzeit und trifft Zugriffsentscheidungen ohne
menschliche Aufsicht. Das System wird auch zur Überwachung
der Mitarbeiterleistung eingesetzt.
```

### Begrenztes Risiko

```
Unser KI-Chatbot beantwortet Kundenanfragen automatisch.
Er nutzt Natural Language Processing, um Anfragen zu verstehen
und passende Antworten aus unserer Wissensdatenbank zu geben.
Bei komplexen Fragen wird an einen menschlichen Mitarbeiter
weitergeleitet.
```

### Minimales Risiko

```
Unser KI-System optimiert die Lagerverwaltung durch
Vorhersage des Bedarfs basierend auf historischen Verkaufsdaten.
Es gibt Empfehlungen für Bestellmengen, die finale Entscheidung
trifft immer ein Mitarbeiter.
```

## Fehlerbehebung

### "Verbindungsfehler" beim Absenden

**Problem**: Frontend kann n8n nicht erreichen

**Lösungen**:
1. Überprüfen Sie, ob n8n läuft: http://localhost:5678
2. Überprüfen Sie die Webhook URL in der Konfiguration
3. Stellen Sie sicher, dass der Workflow aktiviert ist
4. Überprüfen Sie CORS-Einstellungen in n8n

### "Port 3000 already in use"

**Problem**: Port 3000 wird bereits verwendet

**Lösung**:
```bash
# Anderen Port verwenden
PORT=3001 node server.js

# Oder den Prozess auf Port 3000 beenden (Windows)
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Oder den Prozess auf Port 3000 beenden (Linux/Mac)
lsof -ti:3000 | xargs kill -9
```

### Authentication Token ungültig

**Problem**: Token ist abgelaufen oder ungültig

**Lösung**:
1. Löschen Sie den Local Storage:
   - Öffnen Sie Browser DevTools (F12)
   - Gehen Sie zu "Application" > "Local Storage"
   - Löschen Sie alle Einträge
2. Melden Sie sich erneut an

## Entwicklung

### Struktur

```
frontend/
├── index.html      # Haupt-HTML-Datei mit CSS und JavaScript
├── server.js       # Node.js HTTP-Server
├── package.json    # Node.js Konfiguration
└── README.md       # Diese Datei
```

### Anpassungen

**Farben ändern**:
Bearbeiten Sie die CSS-Variablen in `index.html`:
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

**Texte anpassen**:
Alle Texte befinden sich direkt im HTML und können einfach geändert werden.

**API-Endpunkte**:
Die API-Aufrufe befinden sich im `<script>`-Teil am Ende der `index.html`.

## Deployment

### Statisches Hosting

Das Frontend ist eine einfache HTML-Datei und kann überall gehostet werden:

- **Netlify**: Ziehen Sie die `index.html` in Netlify Drop
- **Vercel**: `vercel --prod`
- **GitHub Pages**: Pushen Sie zur gh-pages Branch
- **AWS S3**: Upload zu S3 Bucket mit Static Website Hosting

### Mit Backend zusammen

Verwenden Sie die nginx-Konfiguration aus dem Hauptprojekt:

```nginx
location / {
    root /var/www/frontend;
    try_files $uri $uri/ /index.html;
}
```

## Sicherheit

⚠️ **Wichtige Hinweise**:

1. **HTTPS verwenden**: In Produktion immer HTTPS nutzen
2. **CORS richtig konfigurieren**: Nur vertrauenswürdige Domains erlauben
3. **Tokens sicher speichern**: LocalStorage ist für Demos OK, für Produktion HttpOnly Cookies verwenden
4. **Input validieren**: Alle Eingaben werden bereits validiert
5. **Rate Limiting**: In Produktion Rate Limiting aktivieren

## Browser-Kompatibilität

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

## Performance

- Keine externen Dependencies
- Minimale Bundle-Größe (~15 KB)
- Schnelle Ladezeit
- Optimiert für Mobile

## Support

Bei Problemen:
1. Überprüfen Sie die Browser-Konsole (F12)
2. Überprüfen Sie die n8n-Logs
3. Testen Sie mit cURL, ob die API funktioniert

## Lizenz

MIT License - Frei verwendbar für kommerzielle und private Projekte
