# Setup & Installation Guide

```yaml
meta:
  document_version: "1.0.0"
  setup_automation_level: "semi-automated"
  estimated_time:
    first_time: "30-45 minutes"
    repeat: "10-15 minutes"
  owner_agent: "ops"
```

---

## 📋 Prerequisites Checklist

### Hardware Requirements

**Development Environment**:
- CPU: 2+ cores (4+ recommended)
- RAM: 8GB minimum (16GB recommended)
- Storage: 10GB free space
- Network: Stable internet connection

**Production Environment**:
- CPU: 4+ cores
- RAM: 16GB minimum
- Storage: 50GB+ SSD
- Network: High-bandwidth, low-latency

### Operating Systems Supported

- ✅ macOS 12+ (Monterey or later)
- ✅ Ubuntu 20.04+ / Debian 11+
- ✅ Windows 11 with WSL2
- ❌ Windows native (use WSL2 instead)

---

## 🔍 Software Dependencies

### Required Software

| Software | Minimum Version | Installation |
|----------|----------------|-------------|
| Node.js | 18.0.0 | https://nodejs.org/ |
| npm | 9.0.0 | Included with Node.js |
| Docker | 24.0.0 | https://docs.docker.com/get-docker/ |
| Git | 2.30.0 | https://git-scm.com/ |

### Optional Software

| Software | Purpose | Installation |
|----------|---------|-------------|
| PostgreSQL | Local database | https://www.postgresql.org/download/ |
| Redis | Local caching | https://redis.io/download |
| kubectl | Kubernetes deployment | https://kubernetes.io/docs/tasks/tools/ |

### Verification Script

```bash
# Check all prerequisites
node --version     # Should show v18.0.0 or higher
npm --version      # Should show 9.0.0 or higher
docker --version   # Should show 24.0.0 or higher
git --version      # Should show 2.30.0 or higher
```

---

## 🛠️ Installation Steps

### Step 1: Clone Repository

```bash
# Using HTTPS
git clone https://github.com/yourusername/your-project.git
cd your-project

# Or using SSH
git clone git@github.com:yourusername/your-project.git
cd your-project

# Verify repository
git log --oneline -5
git branch --show-current  # Should be: main
```

---

### Step 2: Install Dependencies

```bash
# Install Node.js packages
npm install

# Expected duration: 2-5 minutes on first run
# Expected output:
# added 450 packages, and audited 451 packages
# 
# found 0 vulnerabilities

# Verify installation
npm list --depth=0
```

**Troubleshooting**:

| Error | Solution |
|-------|----------|
| `ERESOLVE` conflict | `npm install --legacy-peer-deps` |
| `Python not found` | Install Python 3.x |
| `node-gyp failed` | `npm install -g node-gyp` |
| `EACCES` | Fix npm permissions or use sudo |

---

### Step 3: Environment Configuration

#### 🔴 USER ACTION REQUIRED

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your values
nano .env  # or: code .env, vim .env
```

**Required Environment Variables**:

```bash
# Database
DATABASE_URL="postgresql://user:pass@localhost:5432/dbname"

# Authentication
JWT_SECRET="generate-with-openssl-rand-base64-32"
JWT_EXPIRES_IN="15m"
REFRESH_TOKEN_EXPIRES_IN="7d"

# External APIs (get from provider)
API_KEY="your-api-key-here"

# Email (optional)
SMTP_HOST="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="your-email@example.com"
SMTP_PASSWORD="your-password"

# Application
NODE_ENV="development"
PORT="3000"
FRONTEND_URL="http://localhost:3000"
```

**Security Checklist**:
- [ ] `.env` is in `.gitignore`
- [ ] `JWT_SECRET` is 32+ characters
- [ ] Database password is strong
- [ ] API keys are from test environment
- [ ] No hardcoded secrets in code

---

### Step 4: Database Setup

```bash
# Start PostgreSQL with Docker
docker-compose up -d postgres

# Wait for database to be ready
npm run db:wait

# Run migrations
npm run db:migrate

# Expected output:
# Applying migration: 001_create_users_table.sql ✅
# Applying migration: 002_create_posts_table.sql ✅
# All migrations applied successfully

# Load seed data (optional)
npm run db:seed

# Verify database
npm run db:verify
# ✅ Database connection successful
# ✅ All tables exist
# ✅ All indexes created
```

**Alternative: Using Existing PostgreSQL**

```bash
# Create database
createdb your_database_name

# Update DATABASE_URL in .env
# DATABASE_URL="postgresql://localhost:5432/your_database_name"

# Run migrations
npm run db:migrate
```

---

### Step 5: Cache Setup (Optional)

```bash
# Start Redis with Docker
docker-compose up -d redis

# Verify Redis
npm run redis:ping
# ✅ Redis connected successfully
```

---

### Step 6: Build Application

```bash
# Build frontend
npm run build:frontend

# Build backend
npm run build:backend

# Verify build
npm run verify:build
# ✅ Frontend build successful
# ✅ Backend build successful
# ✅ Bundle size within limits
```

---

### Step 7: Start Development Server

```bash
# Start all services
npm run dev

# Or start individually:
npm run dev:frontend  # Port 3000
npm run dev:backend   # Port 4000

# Application endpoints:
# - Frontend: http://localhost:3000
# - API: http://localhost:4000/api
# - API Docs: http://localhost:4000/docs
# - Health Check: http://localhost:4000/health
```

**Expected Health Check Response**:
```json
{
  "status": "ok",
  "database": "connected",
  "cache": "connected",
  "timestamp": "2025-11-12T15:00:00.000Z"
}
```

---

## ✅ Verification

### Run All Checks

```bash
# Complete verification suite
npm run verify:all

# Expected output:
# ✅ Structure: All required files present
# ✅ Dependencies: All installed correctly
# ✅ Environment: All variables configured
# ✅ Database: Connected and migrated
# ✅ Tests: All passing
# ✅ Build: Successful
# ✅ Lint: No errors
# ✅ Security: 0 vulnerabilities
# 
# 🎉 Setup complete! Ready for development.
```

---

## 🚀 Production Deployment

### Pre-deployment Checklist

- [ ] All tests passing
- [ ] Environment variables configured
- [ ] Database backup created
- [ ] SSL certificates configured
- [ ] Monitoring setup
- [ ] Rollback plan ready

### Deploy to Production

```bash
# Build for production
NODE_ENV=production npm run build

# Deploy (method depends on platform)
npm run deploy:production

# Verify deployment
npm run verify:production
```

---

## 🔧 Development Tools

### Useful Commands

```bash
# Run linter
npm run lint

# Fix linting issues
npm run lint:fix

# Run tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate coverage report
npm run test:coverage

# Database migrations
npm run db:migrate
npm run db:rollback
npm run db:seed

# Clean and rebuild
npm run clean
npm run build
```

---

## ⚠️ Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Port already in use | Kill process: `lsof -ti:3000 \| xargs kill` |
| Database connection failed | Check DATABASE_URL in .env |
| Redis connection failed | Start Redis: `docker-compose up -d redis` |
| npm install fails | Delete node_modules, run `npm install` again |
| Tests failing | Check DATABASE_URL_TEST is configured |

### Getting Help

- Check [documentation](../README.md)
- Review [troubleshooting guide](TROUBLESHOOTING.md)
- Open an [issue](https://github.com/yourusername/your-project/issues)

---

## 📚 Related Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) - System design
- [TESTING.md](TESTING.md) - Test strategy
- [GUARDRAILS.md](GUARDRAILS.md) - Quality gates
- [PROJECT_PLAN.md](PROJECT_PLAN.md) - Development phases

---

**Document Owner**: Operations Agent  
**Last Updated**: 2025-11-12  
**Status**: Template Ready