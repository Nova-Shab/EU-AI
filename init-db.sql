-- EU AI Act Compliance Checker Database Initialization
-- This script creates the necessary tables for the application

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    company VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

-- Create reports table
CREATE TABLE IF NOT EXISTS reports (
    id SERIAL PRIMARY KEY,
    report_id VARCHAR(255) UNIQUE NOT NULL,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE CASCADE,
    risk_level VARCHAR(50),
    non_conformities_count INTEGER DEFAULT 0,
    pdf_url TEXT,
    status VARCHAR(50) DEFAULT 'processing',
    input_type VARCHAR(50),
    input_data TEXT,
    analysis_result JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    error_message TEXT
);

-- Create analysis_sessions table for tracking
CREATE TABLE IF NOT EXISTS analysis_sessions (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) UNIQUE NOT NULL,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(50) DEFAULT 'pending',
    progress INTEGER DEFAULT 0,
    current_step VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create audit_logs table for compliance tracking
CREATE TABLE IF NOT EXISTS audit_logs (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE SET NULL,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(100),
    resource_id VARCHAR(255),
    details JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_user_id ON users(user_id);
CREATE INDEX IF NOT EXISTS idx_reports_user_id ON reports(user_id);
CREATE INDEX IF NOT EXISTS idx_reports_status ON reports(status);
CREATE INDEX IF NOT EXISTS idx_reports_created_at ON reports(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_analysis_sessions_user_id ON analysis_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_analysis_sessions_status ON analysis_sessions(status);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON audit_logs(created_at DESC);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_analysis_sessions_updated_at
    BEFORE UPDATE ON analysis_sessions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data (for testing only - remove in production)
-- INSERT INTO users (user_id, email, password_hash, full_name, company)
-- VALUES
--     ('test-user-001', 'demo@example.com', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', 'Demo User', 'Demo Corp');

-- Grant permissions (adjust as needed)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO n8n_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO n8n_user;

-- Create views for reporting
CREATE OR REPLACE VIEW user_report_summary AS
SELECT
    u.user_id,
    u.email,
    u.full_name,
    u.company,
    COUNT(r.id) as total_reports,
    COUNT(CASE WHEN r.status = 'completed' THEN 1 END) as completed_reports,
    COUNT(CASE WHEN r.risk_level = 'High Risk' THEN 1 END) as high_risk_reports,
    MAX(r.created_at) as last_report_date
FROM users u
LEFT JOIN reports r ON u.user_id = r.user_id
GROUP BY u.user_id, u.email, u.full_name, u.company;

-- Create view for recent activity
CREATE OR REPLACE VIEW recent_activity AS
SELECT
    r.report_id,
    r.user_id,
    u.email,
    u.full_name,
    r.risk_level,
    r.status,
    r.created_at,
    r.completed_at
FROM reports r
JOIN users u ON r.user_id = u.user_id
ORDER BY r.created_at DESC
LIMIT 100;

-- Comments for documentation
COMMENT ON TABLE users IS 'Stores user account information';
COMMENT ON TABLE reports IS 'Stores EU AI Act compliance analysis reports';
COMMENT ON TABLE analysis_sessions IS 'Tracks ongoing analysis sessions for status updates';
COMMENT ON TABLE audit_logs IS 'Records all user actions for compliance and security';

COMMENT ON COLUMN users.password_hash IS 'SHA-256 hash of user password (should be bcrypt in production)';
COMMENT ON COLUMN reports.analysis_result IS 'JSON containing full analysis results including non-conformities and recommendations';
COMMENT ON COLUMN reports.status IS 'Values: pending, processing, completed, failed';

-- Print success message
DO $$
BEGIN
    RAISE NOTICE 'EU AI Act Compliance Checker database initialized successfully';
END $$;
