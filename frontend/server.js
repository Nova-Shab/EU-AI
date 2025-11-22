const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
    // Serve index.html for all routes
    const filePath = path.join(__dirname, 'index.html');

    fs.readFile(filePath, (err, content) => {
        if (err) {
            res.writeHead(500, { 'Content-Type': 'text/plain' });
            res.end('Server Error');
            return;
        }

        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(content);
    });
});

server.listen(PORT, () => {
    console.log('=================================================');
    console.log('🚀 EU AI Act Compliance Checker Frontend');
    console.log('=================================================');
    console.log(`Server läuft auf: http://localhost:${PORT}`);
    console.log('');
    console.log('Öffnen Sie in Ihrem Browser:');
    console.log(`  http://localhost:${PORT}`);
    console.log('');
    console.log('Mit ngrok öffentlich machen:');
    console.log(`  ngrok http ${PORT}`);
    console.log('=================================================');
});
