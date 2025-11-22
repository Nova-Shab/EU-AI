# Quick Start Guide

Get the EU AI Act Compliance Checker up and running in 5 minutes.

## Prerequisites

- Docker and Docker Compose installed
- OpenAI API key (get one at https://platform.openai.com)
- (Optional) Airtable account for database

## Option 1: Quick Start with Docker (Recommended)

### Step 1: Clone and Configure

```bash
# Clone the repository (or download the files)
cd EU-AI

# Copy the environment template
cp .env.example .env

# Edit .env and add your OpenAI API key
nano .env  # or use your favorite editor
```

### Step 2: Update Environment Variables

Edit `.env` and set at minimum:

```env
# Required
OPENAI_API_KEY=sk-your-openai-api-key-here

# Recommended to change
N8N_BASIC_AUTH_PASSWORD=your-secure-password
DB_POSTGRESDB_PASSWORD=your-db-password
N8N_ENCRYPTION_KEY=your-random-encryption-key
N8N_JWT_SECRET=your-random-jwt-secret

# For production
WEBHOOK_URL=https://your-domain.com
N8N_PROTOCOL=https
```

### Step 3: Start the Services

```bash
# Start all services
docker-compose up -d

# Check if everything is running
docker-compose ps

# View logs
docker-compose logs -f n8n
```

### Step 4: Import the Workflow

1. Open n8n: http://localhost:5678
2. Login with credentials from `.env` (default: admin/changeme)
3. Go to **Workflows** → **Import from File**
4. Select `n8n-workflow-eu-ai-act-compliance.json`
5. Click **Import**

### Step 5: Configure Credentials

#### OpenAI

1. Go to **Credentials** → **Create New**
2. Select **OpenAI API**
3. Name: "OpenAI Account"
4. API Key: Your OpenAI API key
5. Click **Save**

#### Database (Using PostgreSQL)

The workflow comes pre-configured with PostgreSQL. Update the Airtable nodes to PostgreSQL:

1. Click on any "Airtable" node
2. Change node type to "PostgreSQL"
3. Configure connection:
   - Host: `postgres`
   - Port: `5432`
   - Database: `n8n`
   - User: `n8n_user`
   - Password: (from your .env)

Alternatively, keep Airtable:

1. Sign up at https://airtable.com
2. Create tables as described in README.md
3. Add Airtable credentials in n8n

### Step 6: Activate the Workflow

1. Open the imported workflow
2. Click **Activate** (toggle in top-right)
3. Copy the webhook URLs

### Step 7: Test the API

```bash
# Test registration
curl -X POST http://localhost:5678/webhook/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "Test123!",
    "fullName": "Test User",
    "company": "Test Corp"
  }'

# Save the token from the response

# Test analysis
curl -X POST http://localhost:5678/webhook/analyze \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "inputType": "description",
    "description": "Our AI system uses facial recognition to automatically grant building access to employees. It processes biometric data in real-time and makes access decisions without human oversight."
  }'
```

## Option 2: Local n8n Installation

### Step 1: Install n8n

```bash
npm install -g n8n
# or
npx n8n
```

### Step 2: Start n8n

```bash
n8n start
```

### Step 3: Follow Steps 4-7 from Option 1

## Testing the Integration

### Using the Vanilla JavaScript Frontend

Create a simple HTML file:

```html
<!DOCTYPE html>
<html>
<head>
    <title>EU AI Act Checker</title>
</head>
<body>
    <h1>Test the API</h1>
    <script>
        const API_BASE = 'http://localhost:5678/webhook';

        async function test() {
            // 1. Register
            const regResponse = await fetch(`${API_BASE}/auth/register`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    email: 'test@example.com',
                    password: 'Test123!',
                    fullName: 'Test User',
                    company: 'Test Corp'
                })
            });
            const regData = await regResponse.json();
            console.log('Registration:', regData);

            const token = regData.token;

            // 2. Analyze
            const analyzeResponse = await fetch(`${API_BASE}/analyze`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    inputType: 'description',
                    description: 'AI system for facial recognition in public spaces'
                })
            });
            const analyzeData = await analyzeResponse.json();
            console.log('Analysis:', analyzeData);
        }

        test();
    </script>
</body>
</html>
```

Open in browser and check console.

## Troubleshooting

### Workflow not activating
- Check if all credentials are configured
- Review node configurations
- Check n8n logs: `docker-compose logs n8n`

### Database connection errors
- Verify PostgreSQL is running: `docker-compose ps postgres`
- Check database credentials in .env
- Restart services: `docker-compose restart`

### OpenAI API errors
- Verify API key is correct
- Check API quota/limits
- Review OpenAI node configuration

### Webhook not responding
- Ensure workflow is activated (green toggle)
- Check webhook URLs are correct
- Verify CORS settings if calling from browser

## Next Steps

1. **Read the full documentation**: [README.md](README.md)
2. **Integrate with frontend**: [FRONTEND-INTEGRATION.md](FRONTEND-INTEGRATION.md)
3. **Review EU AI Act requirements**: [EU-AI-ACT-REQUIREMENTS.md](EU-AI-ACT-REQUIREMENTS.md)
4. **Customize the analysis**: Edit the AI prompt in the workflow
5. **Deploy to production**: Follow the production deployment guide in README.md

## Production Deployment

For production deployment:

1. **Use HTTPS**: Set up SSL certificates (Let's Encrypt recommended)
2. **Secure credentials**: Use strong passwords and rotate keys
3. **Enable monitoring**: Set up logging and alerts
4. **Configure backups**: Regular database backups
5. **Update CORS**: Restrict to your frontend domain
6. **Enable rate limiting**: Use nginx configuration provided

```bash
# Deploy with nginx (production)
docker-compose --profile production up -d
```

## Stopping the Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: deletes all data)
docker-compose down -v
```

## Support

If you encounter issues:

1. Check the logs: `docker-compose logs -f`
2. Review the [README.md](README.md) for detailed documentation
3. Consult n8n documentation: https://docs.n8n.io
4. Check OpenAI API status: https://status.openai.com

## Cost Estimation

- **OpenAI API**: ~$0.01-0.03 per analysis (GPT-4 Turbo)
- **Infrastructure**: Free for local development
- **Production hosting**: $10-30/month (DigitalOcean, AWS, etc.)

---

**Ready to go!** 🚀

Your EU AI Act Compliance Checker is now running. Visit http://localhost:5678 to access n8n and start analyzing AI systems.
