# Frontend Integration Guide

## Overview

This guide explains how to integrate your web frontend with the n8n EU AI Act Compliance Checker workflow.

## Architecture

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   Frontend  │─────▶│ n8n Webhook │─────▶│  AI Analysis│─────▶│ PDF Report  │
│   (React)   │◀─────│  Endpoints  │◀─────│   Engine    │◀─────│  Generator  │
└─────────────┘      └─────────────┘      └─────────────┘      └─────────────┘
```

## API Endpoints

Once the n8n workflow is activated, it exposes the following webhook endpoints:

### Base URL
```
https://your-n8n-instance.com/webhook/
```

### 1. User Registration

**Endpoint:** `POST /webhook/auth/register`

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "fullName": "John Doe",
  "company": "Acme Corp"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Registration successful",
  "userId": "1700000000000-a1b2c3d4",
  "token": "user-token-here"
}
```

### 2. User Login

**Endpoint:** `POST /webhook/auth/login`

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "userId": "1700000000000-a1b2c3d4",
  "token": "user-token-here"
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Invalid email or password"
}
```

### 3. Submit AI System for Analysis

**Endpoint:** `POST /webhook/analyze`

**Headers:**
```
Authorization: Bearer {token}
Content-Type: application/json
```

**Request (URL Input):**
```json
{
  "inputType": "url",
  "url": "https://example.com/ai-product"
}
```

**Request (Description Input):**
```json
{
  "inputType": "description",
  "description": "Our AI system uses machine learning to predict customer behavior and automatically approve loan applications based on credit scores and social media analysis."
}
```

**Response:**
```json
{
  "success": true,
  "message": "Analysis completed successfully",
  "sessionId": "1700000000000-x8y9z0a1",
  "reportId": "1700000000000-x8y9z0a1",
  "riskLevel": "High Risk",
  "nonConformitiesCount": 5,
  "downloadUrl": "/api/download/1700000000000-x8y9z0a1"
}
```

### 4. Check Analysis Status

**Endpoint:** `GET /webhook/status/{sessionId}`

**Response:**
```json
{
  "success": true,
  "sessionId": "1700000000000-x8y9z0a1",
  "status": "completed",
  "riskLevel": "High Risk",
  "nonConformitiesCount": 5,
  "reportReady": true
}
```

### 5. Download PDF Report

**Endpoint:** `GET /webhook/download/{reportId}`

**Response:** Binary PDF file

**Headers:**
```
Content-Type: application/pdf
Content-Disposition: attachment; filename="eu-ai-act-report.pdf"
```

## Frontend Implementation Examples

### React with Axios

```javascript
import axios from 'axios';

const API_BASE_URL = 'https://your-n8n-instance.com/webhook';

// Configure axios instance
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json'
  }
});

// Add token to requests
api.interceptors.request.use(config => {
  const token = localStorage.getItem('authToken');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// 1. Register User
export const registerUser = async (userData) => {
  try {
    const response = await api.post('/auth/register', userData);
    if (response.data.success) {
      localStorage.setItem('authToken', response.data.token);
      localStorage.setItem('userId', response.data.userId);
    }
    return response.data;
  } catch (error) {
    throw error.response?.data || error.message;
  }
};

// 2. Login User
export const loginUser = async (credentials) => {
  try {
    const response = await api.post('/auth/login', credentials);
    if (response.data.success) {
      localStorage.setItem('authToken', response.data.token);
      localStorage.setItem('userId', response.data.userId);
    }
    return response.data;
  } catch (error) {
    throw error.response?.data || error.message;
  }
};

// 3. Submit for Analysis
export const analyzeAISystem = async (data) => {
  try {
    const response = await api.post('/analyze', data);
    return response.data;
  } catch (error) {
    throw error.response?.data || error.message;
  }
};

// 4. Check Status
export const checkAnalysisStatus = async (sessionId) => {
  try {
    const response = await api.get(`/status/${sessionId}`);
    return response.data;
  } catch (error) {
    throw error.response?.data || error.message;
  }
};

// 5. Download Report
export const downloadReport = async (reportId) => {
  try {
    const response = await api.get(`/download/${reportId}`, {
      responseType: 'blob'
    });

    // Create download link
    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', `eu-ai-act-report-${reportId}.pdf`);
    document.body.appendChild(link);
    link.click();
    link.remove();
  } catch (error) {
    throw error.response?.data || error.message;
  }
};
```

### React Component Example

```jsx
import React, { useState } from 'react';
import { analyzeAISystem, checkAnalysisStatus, downloadReport } from './api';

function AnalysisForm() {
  const [inputType, setInputType] = useState('url');
  const [url, setUrl] = useState('');
  const [description, setDescription] = useState('');
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const data = inputType === 'url'
        ? { inputType: 'url', url }
        : { inputType: 'description', description };

      const response = await analyzeAISystem(data);
      setResult(response);

      // Optionally poll for status updates
      pollStatus(response.sessionId);
    } catch (err) {
      setError(err.message || 'Analysis failed');
    } finally {
      setLoading(false);
    }
  };

  const pollStatus = async (sessionId) => {
    const interval = setInterval(async () => {
      try {
        const status = await checkAnalysisStatus(sessionId);
        if (status.reportReady) {
          clearInterval(interval);
          setResult(prev => ({ ...prev, ...status }));
        }
      } catch (err) {
        clearInterval(interval);
      }
    }, 3000); // Poll every 3 seconds
  };

  const handleDownload = () => {
    if (result?.reportId) {
      downloadReport(result.reportId);
    }
  };

  return (
    <div className="analysis-form">
      <h2>EU AI Act Compliance Analysis</h2>

      <form onSubmit={handleSubmit}>
        <div className="input-type-selector">
          <label>
            <input
              type="radio"
              value="url"
              checked={inputType === 'url'}
              onChange={(e) => setInputType(e.target.value)}
            />
            Website URL
          </label>
          <label>
            <input
              type="radio"
              value="description"
              checked={inputType === 'description'}
              onChange={(e) => setInputType(e.target.value)}
            />
            Description
          </label>
        </div>

        {inputType === 'url' ? (
          <div className="form-group">
            <label>Website URL:</label>
            <input
              type="url"
              value={url}
              onChange={(e) => setUrl(e.target.value)}
              placeholder="https://example.com/ai-product"
              required
            />
          </div>
        ) : (
          <div className="form-group">
            <label>AI System Description:</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="Describe your AI system..."
              rows={6}
              required
            />
          </div>
        )}

        <button type="submit" disabled={loading}>
          {loading ? 'Analyzing...' : 'Analyze AI System'}
        </button>
      </form>

      {error && (
        <div className="error-message">
          {error}
        </div>
      )}

      {result && (
        <div className="analysis-result">
          <h3>Analysis Complete!</h3>
          <div className="result-summary">
            <p><strong>Risk Level:</strong> {result.riskLevel}</p>
            <p><strong>Non-conformities Found:</strong> {result.nonConformitiesCount}</p>
          </div>
          <button onClick={handleDownload} className="download-btn">
            Download PDF Report
          </button>
        </div>
      )}
    </div>
  );
}

export default AnalysisForm;
```

### Vue.js Example

```javascript
<template>
  <div class="analysis-form">
    <h2>EU AI Act Compliance Analysis</h2>

    <form @submit.prevent="handleSubmit">
      <div class="input-type-selector">
        <label>
          <input type="radio" value="url" v-model="inputType" />
          Website URL
        </label>
        <label>
          <input type="radio" value="description" v-model="inputType" />
          Description
        </label>
      </div>

      <div v-if="inputType === 'url'" class="form-group">
        <label>Website URL:</label>
        <input
          type="url"
          v-model="url"
          placeholder="https://example.com/ai-product"
          required
        />
      </div>

      <div v-else class="form-group">
        <label>AI System Description:</label>
        <textarea
          v-model="description"
          placeholder="Describe your AI system..."
          rows="6"
          required
        />
      </div>

      <button type="submit" :disabled="loading">
        {{ loading ? 'Analyzing...' : 'Analyze AI System' }}
      </button>
    </form>

    <div v-if="error" class="error-message">
      {{ error }}
    </div>

    <div v-if="result" class="analysis-result">
      <h3>Analysis Complete!</h3>
      <div class="result-summary">
        <p><strong>Risk Level:</strong> {{ result.riskLevel }}</p>
        <p><strong>Non-conformities Found:</strong> {{ result.nonConformitiesCount }}</p>
      </div>
      <button @click="downloadReport" class="download-btn">
        Download PDF Report
      </button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'AnalysisForm',
  data() {
    return {
      inputType: 'url',
      url: '',
      description: '',
      loading: false,
      result: null,
      error: null,
      api: axios.create({
        baseURL: 'https://your-n8n-instance.com/webhook',
        headers: {
          'Content-Type': 'application/json'
        }
      })
    };
  },
  methods: {
    async handleSubmit() {
      this.loading = true;
      this.error = null;

      try {
        const token = localStorage.getItem('authToken');
        const data = this.inputType === 'url'
          ? { inputType: 'url', url: this.url }
          : { inputType: 'description', description: this.description };

        const response = await this.api.post('/analyze', data, {
          headers: { Authorization: `Bearer ${token}` }
        });

        this.result = response.data;
      } catch (err) {
        this.error = err.response?.data?.message || 'Analysis failed';
      } finally {
        this.loading = false;
      }
    },
    async downloadReport() {
      try {
        const token = localStorage.getItem('authToken');
        const response = await this.api.get(`/download/${this.result.reportId}`, {
          responseType: 'blob',
          headers: { Authorization: `Bearer ${token}` }
        });

        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', `eu-ai-act-report-${this.result.reportId}.pdf`);
        document.body.appendChild(link);
        link.click();
        link.remove();
      } catch (err) {
        this.error = 'Download failed';
      }
    }
  }
};
</script>
```

## Vanilla JavaScript Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EU AI Act Compliance Checker</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
    }
    .form-group {
      margin: 20px 0;
    }
    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    input[type="url"],
    textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    button {
      background: #0066cc;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
    button:hover {
      background: #0052a3;
    }
    button:disabled {
      background: #ccc;
      cursor: not-allowed;
    }
    .result {
      margin-top: 30px;
      padding: 20px;
      background: #f0f8ff;
      border-radius: 4px;
    }
    .error {
      color: red;
      padding: 10px;
      background: #ffe6e6;
      border-radius: 4px;
    }
  </style>
</head>
<body>
  <h1>EU AI Act Compliance Checker</h1>

  <div id="auth-section">
    <h2>Login</h2>
    <div class="form-group">
      <label>Email:</label>
      <input type="email" id="login-email" required>
    </div>
    <div class="form-group">
      <label>Password:</label>
      <input type="password" id="login-password" required>
    </div>
    <button onclick="login()">Login</button>
  </div>

  <div id="analysis-section" style="display: none;">
    <h2>Analyze AI System</h2>

    <div class="form-group">
      <label>
        <input type="radio" name="inputType" value="url" checked onchange="toggleInput()">
        Website URL
      </label>
      <label>
        <input type="radio" name="inputType" value="description" onchange="toggleInput()">
        Description
      </label>
    </div>

    <div id="url-input" class="form-group">
      <label>Website URL:</label>
      <input type="url" id="ai-url" placeholder="https://example.com/ai-product">
    </div>

    <div id="description-input" class="form-group" style="display: none;">
      <label>AI System Description:</label>
      <textarea id="ai-description" rows="6" placeholder="Describe your AI system..."></textarea>
    </div>

    <button onclick="analyzeSystem()" id="analyze-btn">Analyze AI System</button>

    <div id="error" class="error" style="display: none;"></div>
    <div id="result" class="result" style="display: none;"></div>
  </div>

  <script>
    const API_BASE = 'https://your-n8n-instance.com/webhook';
    let authToken = localStorage.getItem('authToken');

    if (authToken) {
      showAnalysisSection();
    }

    async function login() {
      const email = document.getElementById('login-email').value;
      const password = document.getElementById('login-password').value;

      try {
        const response = await fetch(`${API_BASE}/auth/login`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email, password })
        });

        const data = await response.json();

        if (data.success) {
          authToken = data.token;
          localStorage.setItem('authToken', data.token);
          localStorage.setItem('userId', data.userId);
          showAnalysisSection();
        } else {
          showError(data.message);
        }
      } catch (error) {
        showError('Login failed: ' + error.message);
      }
    }

    function showAnalysisSection() {
      document.getElementById('auth-section').style.display = 'none';
      document.getElementById('analysis-section').style.display = 'block';
    }

    function toggleInput() {
      const inputType = document.querySelector('input[name="inputType"]:checked').value;
      document.getElementById('url-input').style.display =
        inputType === 'url' ? 'block' : 'none';
      document.getElementById('description-input').style.display =
        inputType === 'description' ? 'block' : 'none';
    }

    async function analyzeSystem() {
      const btn = document.getElementById('analyze-btn');
      btn.disabled = true;
      btn.textContent = 'Analyzing...';
      hideError();
      hideResult();

      const inputType = document.querySelector('input[name="inputType"]:checked').value;
      const data = inputType === 'url'
        ? { inputType: 'url', url: document.getElementById('ai-url').value }
        : { inputType: 'description', description: document.getElementById('ai-description').value };

      try {
        const response = await fetch(`${API_BASE}/analyze`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${authToken}`
          },
          body: JSON.stringify(data)
        });

        const result = await response.json();

        if (result.success) {
          showResult(result);
        } else {
          showError(result.message);
        }
      } catch (error) {
        showError('Analysis failed: ' + error.message);
      } finally {
        btn.disabled = false;
        btn.textContent = 'Analyze AI System';
      }
    }

    function showResult(result) {
      const resultDiv = document.getElementById('result');
      resultDiv.innerHTML = `
        <h3>Analysis Complete!</h3>
        <p><strong>Risk Level:</strong> ${result.riskLevel}</p>
        <p><strong>Non-conformities Found:</strong> ${result.nonConformitiesCount}</p>
        <button onclick="downloadReport('${result.reportId}')">Download PDF Report</button>
      `;
      resultDiv.style.display = 'block';
    }

    async function downloadReport(reportId) {
      try {
        const response = await fetch(`${API_BASE}/download/${reportId}`, {
          headers: { 'Authorization': `Bearer ${authToken}` }
        });

        const blob = await response.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `eu-ai-act-report-${reportId}.pdf`;
        document.body.appendChild(a);
        a.click();
        a.remove();
      } catch (error) {
        showError('Download failed: ' + error.message);
      }
    }

    function showError(message) {
      const errorDiv = document.getElementById('error');
      errorDiv.textContent = message;
      errorDiv.style.display = 'block';
    }

    function hideError() {
      document.getElementById('error').style.display = 'none';
    }

    function hideResult() {
      document.getElementById('result').style.display = 'none';
    }
  </script>
</body>
</html>
```

## Testing the Integration

### Using cURL

```bash
# 1. Register
curl -X POST https://your-n8n-instance.com/webhook/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "testPassword123",
    "fullName": "Test User",
    "company": "Test Corp"
  }'

# 2. Login
curl -X POST https://your-n8n-instance.com/webhook/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "testPassword123"
  }'

# Save the token from the response

# 3. Analyze (with URL)
curl -X POST https://your-n8n-instance.com/webhook/analyze \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "inputType": "url",
    "url": "https://example.com/ai-product"
  }'

# 4. Check status
curl https://your-n8n-instance.com/webhook/status/SESSION_ID_HERE \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# 5. Download report
curl https://your-n8n-instance.com/webhook/download/REPORT_ID_HERE \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  --output report.pdf
```

## Security Considerations

1. **HTTPS Only**: Always use HTTPS in production
2. **Token Storage**: Store auth tokens securely (HttpOnly cookies or secure local storage)
3. **CORS**: Configure n8n webhook CORS settings appropriately
4. **Rate Limiting**: Implement rate limiting on the frontend
5. **Input Validation**: Validate all user inputs before sending to the API
6. **Error Handling**: Never expose sensitive error details to users

## Deployment Notes

1. **n8n Instance**: Deploy n8n on a secure server (e.g., AWS, DigitalOcean, Heroku)
2. **Database**: Use a production database (PostgreSQL recommended over Airtable for production)
3. **API Keys**: Store OpenAI and other API keys securely in n8n credentials
4. **Monitoring**: Set up logging and monitoring for the workflow
5. **Backups**: Regular backups of the database and workflow configuration

## Support

For issues or questions:
- Check n8n documentation: https://docs.n8n.io
- Review the workflow configuration in n8n-workflow-eu-ai-act-compliance.json
- Ensure all required credentials are configured in n8n
