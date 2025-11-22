# EU AI Act Compliance Checker - n8n Workflow

An automated compliance checking system built with n8n that analyzes AI systems against the EU AI Act requirements and generates comprehensive PDF reports.

## Overview

This n8n workflow provides a complete solution for EU AI Act compliance analysis:

- **User Authentication**: Secure registration and login system
- **Flexible Input**: Accept website URLs or text descriptions of AI systems
- **AI-Powered Analysis**: Automated analysis using GPT-4 or similar LLMs
- **Risk Classification**: Classify AI systems into EU AI Act risk categories
- **Compliance Checking**: Identify non-conformities and deviations
- **Action Plans**: Generate recommended measures for each issue
- **PDF Reports**: Professional, downloadable compliance reports
- **API-First**: RESTful API design for easy frontend integration

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                        Frontend Layer                         │
│  (React / Vue / Vanilla JS - User Interface)                 │
└────────────────────┬─────────────────────────────────────────┘
                     │ HTTP/HTTPS
                     ▼
┌──────────────────────────────────────────────────────────────┐
│                     n8n Workflow Layer                        │
├──────────────────────────────────────────────────────────────┤
│  ┌────────────┐  ┌────────────┐  ┌──────────────┐           │
│  │   Auth     │  │   Input    │  │  Analysis    │           │
│  │  System    │──│  Handler   │──│   Engine     │           │
│  └────────────┘  └────────────┘  └──────────────┘           │
│                                           │                   │
│                                           ▼                   │
│                                  ┌──────────────┐            │
│                                  │ PDF Generator│            │
│                                  └──────────────┘            │
└────────────────────┬─────────────────────────────────────────┘
                     │
                     ▼
┌──────────────────────────────────────────────────────────────┐
│                    External Services                          │
├──────────────────────────────────────────────────────────────┤
│  • Database (Airtable/PostgreSQL)                            │
│  • OpenAI API (GPT-4)                                        │
│  • PDF Generation Service                                    │
│  • File Storage                                              │
└──────────────────────────────────────────────────────────────┘
```

## Features

### 1. Authentication System
- User registration with email and password
- Secure login with token-based authentication
- Password hashing (SHA-256, upgrade to bcrypt in production)
- Token generation and validation

### 2. Analysis Input
- **URL Mode**: Fetches and analyzes website content
- **Description Mode**: Analyzes text descriptions of AI systems
- Automatic content extraction from HTML
- Support for complex AI system descriptions

### 3. EU AI Act Analysis
- Risk classification (Unacceptable, High, Limited, Minimal)
- Comprehensive compliance checking
- Article-by-article reference
- Severity assessment (Critical, High, Medium, Low)

### 4. Report Generation
- Professional PDF reports with:
  - Executive summary
  - Risk classification with reasoning
  - Detailed non-conformities list
  - Prioritized action plan
  - Article references
  - Timeline recommendations

### 5. API Endpoints
- `POST /auth/register` - User registration
- `POST /auth/login` - User authentication
- `POST /analyze` - Submit AI system for analysis
- `GET /status/{sessionId}` - Check analysis status
- `GET /download/{reportId}` - Download PDF report

## Installation & Setup

### Prerequisites

1. **n8n Installation**
   ```bash
   npm install -g n8n
   # or
   docker pull n8nio/n8n
   ```

2. **Required Services**
   - OpenAI API key (for GPT-4 analysis)
   - Database (Airtable or PostgreSQL)
   - PDF generation service (HTML2PDF or similar)

### Step 1: Import Workflow

1. Start n8n:
   ```bash
   n8n start
   ```

2. Access n8n web interface (default: http://localhost:5678)

3. Import the workflow:
   - Go to **Workflows** → **Import from File**
   - Select `n8n-workflow-eu-ai-act-compliance.json`
   - Click **Import**

### Step 2: Configure Credentials

#### OpenAI API
1. Go to **Credentials** → **Create New**
2. Select **OpenAI API**
3. Enter your OpenAI API key
4. Save as "OpenAI Account"

#### Database (Airtable Example)
1. Create Airtable account at https://airtable.com
2. Create a new base with two tables:

**Users Table:**
| Field Name    | Type      |
|---------------|-----------|
| userId        | Text      |
| email         | Email     |
| passwordHash  | Text      |
| fullName      | Text      |
| company       | Text      |
| createdAt     | Date      |

**Reports Table:**
| Field Name           | Type      |
|----------------------|-----------|
| reportId             | Text      |
| userId               | Text      |
| riskLevel            | Text      |
| nonConformitiesCount | Number    |
| pdfUrl               | URL       |
| status               | Text      |
| createdAt            | Date      |

3. In n8n, go to **Credentials** → **Create New**
4. Select **Airtable API**
5. Enter your Airtable API token
6. Save as "Airtable Account"

#### Alternative: PostgreSQL
Replace Airtable nodes with PostgreSQL nodes:

```sql
-- Create users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_id VARCHAR(255) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  company VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create reports table
CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  report_id VARCHAR(255) UNIQUE NOT NULL,
  user_id VARCHAR(255) REFERENCES users(user_id),
  risk_level VARCHAR(50),
  non_conformities_count INTEGER,
  pdf_url TEXT,
  status VARCHAR(50) DEFAULT 'processing',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### PDF Generation Service
1. Sign up for HTML2PDF service or similar
2. Add credentials to n8n
3. Or use local Puppeteer/wkhtmltopdf solution

### Step 3: Configure Environment Variables

Create a `.env` file in your n8n directory:

```env
# n8n Configuration
N8N_PORT=5678
N8N_HOST=0.0.0.0
N8N_PROTOCOL=https
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your-secure-password

# Webhook Configuration
WEBHOOK_URL=https://your-domain.com

# Database Configuration
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=localhost
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n_user
DB_POSTGRESDB_PASSWORD=your-db-password

# Security
N8N_JWT_SECRET=your-jwt-secret-key
N8N_ENCRYPTION_KEY=your-encryption-key
```

### Step 4: Activate Workflow

1. Open the imported workflow in n8n
2. Review all nodes and ensure credentials are assigned
3. Click **Activate** button (toggle in top-right)
4. Copy webhook URLs from each webhook node

### Step 5: Test the Workflow

Use the provided cURL commands or Postman collection:

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
```

## Configuration

### Customizing the AI Analysis

Edit the "Prepare AI Analysis Prompt" node to customize:

- Risk classification criteria
- Compliance requirements
- Report format
- Severity levels

### Database Selection

The workflow uses Airtable by default. To switch to PostgreSQL:

1. Replace all Airtable nodes with PostgreSQL nodes
2. Update the table/field names in SQL queries
3. Configure PostgreSQL credentials

### AI Model Selection

Change the OpenAI node to use different models:

- **GPT-4 Turbo** (default): Most accurate, higher cost
- **GPT-3.5 Turbo**: Faster, lower cost, less detailed
- **Claude API**: Alternative (requires different node)
- **Local LLM**: Use HTTP Request to local Ollama instance

## Frontend Integration

See [FRONTEND-INTEGRATION.md](FRONTEND-INTEGRATION.md) for:
- Complete API documentation
- React, Vue, and vanilla JavaScript examples
- Authentication implementation
- File upload and download handling
- Status polling examples

## EU AI Act Knowledge Base

The workflow uses a comprehensive AI prompt based on:

- **EU AI Act Articles**: Risk classifications, requirements
- **Prohibited Practices**: Article 5
- **High-Risk Systems**: Annex III
- **Transparency Obligations**: Articles 52
- **Conformity Assessment**: Articles 43-44

For detailed requirements, see [EU-AI-ACT-REQUIREMENTS.md](EU-AI-ACT-REQUIREMENTS.md)

## Production Deployment

### Recommended Infrastructure

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   Nginx     │─────▶│    n8n      │─────▶│  PostgreSQL │
│  (Reverse   │      │  (Docker)   │      │  (Database) │
│   Proxy)    │      └─────────────┘      └─────────────┘
└─────────────┘              │
                             ▼
                    ┌─────────────┐
                    │   OpenAI    │
                    │     API     │
                    └─────────────┘
```

### Docker Deployment

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: n8n
      POSTGRES_USER: n8n
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres-data:/var/lib/postgresql/data

  n8n:
    image: n8nio/n8n
    ports:
      - "5678:5678"
    environment:
      - N8N_PROTOCOL=https
      - N8N_HOST=${N8N_HOST}
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=${DB_PASSWORD}
      - N8N_ENCRYPTION_KEY=${ENCRYPTION_KEY}
    volumes:
      - n8n-data:/home/node/.n8n
    depends_on:
      - postgres

volumes:
  postgres-data:
  n8n-data:
```

Deploy with:
```bash
docker-compose up -d
```

### Security Checklist

- [ ] Use HTTPS/TLS for all connections
- [ ] Enable n8n basic authentication
- [ ] Secure database with strong passwords
- [ ] Rotate API keys regularly
- [ ] Implement rate limiting
- [ ] Set up monitoring and logging
- [ ] Regular backups of database and workflows
- [ ] Use environment variables for secrets
- [ ] Configure CORS properly
- [ ] Implement input validation

## Monitoring & Logging

### n8n Execution Logs

View execution history:
1. Go to **Executions** in n8n
2. Filter by workflow
3. Review success/failure rates

### Custom Logging

Add logging nodes to track:
- User registrations
- Analysis requests
- API errors
- Performance metrics

### Monitoring Tools

Recommended:
- **Uptime monitoring**: UptimeRobot, Pingdom
- **Error tracking**: Sentry
- **Analytics**: Custom database queries
- **Performance**: n8n built-in metrics

## Troubleshooting

### Common Issues

**1. Workflow not receiving webhook calls**
- Check if workflow is activated
- Verify webhook URLs are correct
- Check firewall/network settings

**2. Authentication failures**
- Verify token is sent in Authorization header
- Check password hashing logic
- Review database credentials

**3. AI analysis fails**
- Verify OpenAI API key is valid
- Check API quota/limits
- Review prompt length (token limits)

**4. PDF generation fails**
- Verify PDF service credentials
- Check HTML content is valid
- Test PDF service independently

**5. Database errors**
- Verify credentials are correct
- Check table/field names match
- Review database permissions

## Cost Estimation

### OpenAI API Costs
- **GPT-4 Turbo**: ~$0.01-0.03 per analysis
- **GPT-3.5 Turbo**: ~$0.001-0.003 per analysis

### Infrastructure Costs (Monthly)
- **n8n Cloud**: $20-50 (or self-hosted: $10-30)
- **Database**: $0-25 (Airtable free tier or PostgreSQL)
- **PDF Service**: $0-10
- **Total**: $30-85/month (+ OpenAI usage)

## Roadmap

- [ ] Email notifications for completed analyses
- [ ] Multi-language support
- [ ] Batch analysis for multiple AI systems
- [ ] Historical analysis comparison
- [ ] Collaboration features (team access)
- [ ] Custom compliance frameworks
- [ ] Integration with compliance management systems
- [ ] Mobile app support
- [ ] Advanced analytics dashboard

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is provided as-is for educational and compliance purposes.

**Disclaimer**: This tool provides automated analysis based on AI interpretation of the EU AI Act. It is not a substitute for legal advice. Always consult with qualified legal professionals for compliance matters.

## Support & Resources

- **n8n Documentation**: https://docs.n8n.io
- **EU AI Act Official Text**: https://eur-lex.europa.eu/eli/reg/2024/1689
- **OpenAI API**: https://platform.openai.com/docs
- **Issues**: Report bugs and request features via GitHub Issues

## Authors

Created for EU AI Act compliance automation.

## Acknowledgments

- n8n community for the excellent workflow automation platform
- OpenAI for GPT-4 API
- EU Commission for the AI Act framework

---

**Version**: 1.0.0
**Last Updated**: 2025-11-22
