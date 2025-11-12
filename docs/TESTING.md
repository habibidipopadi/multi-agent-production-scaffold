# Testing & Validation Strategy

```yaml
meta:
  document_version: "1.0.0"
  owner_agent: "qa"
  testing_philosophy: "shift-left, automation-first"
  last_updated: "2025-11-12"
  
coverage_targets:
  unit: 80
  integration: 70
  e2e: "critical_paths_only"
```

---

## 🎯 Testing Philosophy

### Testing Pyramid

```
        /\
       /  \      E2E Tests (10%)
      /____\     - Critical user journeys
     /      \    - Slow, expensive
    /________\   
   /          \  Integration Tests (20%)
  /____________\ - API contracts, database
 /              \
/________________\ Unit Tests (70%)
                   - Fast, isolated, comprehensive
```

### Agent Testing Responsibilities

```yaml
all_agents_must:
  - "Write tests for code they generate"
  - "Ensure tests pass before marking complete"
  - "Fix failing tests within 1 hour"
  - "Maintain coverage above thresholds"
  
qa_agent_additionally:
  - "Reviews all test code for quality"
  - "Maintains E2E test suite"
  - "Monitors test metrics"
  - "Owns test infrastructure and CI"
```

---

## 🧪 Unit Tests

### What to Unit Test

```yaml
always_unit_test:
  - "Pure functions and business logic"
  - "Utility functions and helpers"
  - "Data transformations"
  - "Validation logic"
  - "Error handling paths"
  
do_not_unit_test:
  - "Third-party library code"
  - "Framework internals"
  - "Trivial getters/setters"
  - "Configuration constants"
```

### Running Unit Tests

```bash
# Run all unit tests (agent-executable)
npm run test:unit

# Expected output:
# PASS src/utils/helpers.test.js
# PASS src/services/auth.test.js
# 
# Tests:       142 passed, 142 total
# Snapshots:   5 passed, 5 total
# Time:        3.5s
# Coverage:    85% statements, 82% branches

# Run specific test file
npm run test:unit -- auth.test.js

# Run in watch mode (for development)
npm run test:unit:watch

# Run with coverage report
npm run test:unit:coverage
```

### Unit Test Best Practices

```yaml
naming_convention:
  format: "describe('<Component>', () => { test('<behavior>', ...) })"
  
structure:
  pattern: "Arrange-Act-Assert (AAA)"
  
isolation:
  - "Mock external dependencies"
  - "Each test independent"
  - "Tests run in any order"

speed:
  - "Unit tests <50ms each"
  - "Total suite <30 seconds"
```

---

## 🔗 Integration Tests

### What to Integration Test

```yaml
integration_test_targets:
  - "API endpoints with real database"
  - "Database queries and transactions"
  - "Authentication flows"
  - "External API integrations (mocked)"
  - "Message queue operations"
```

### Running Integration Tests

```bash
# Start test database
docker-compose -f docker-compose.test.yml up -d

# Run integration tests
npm run test:integration

# Expected output:
# PASS tests/integration/api/auth.test.js
# PASS tests/integration/api/users.test.js
# 
# Tests:       48 passed, 48 total
# Time:        12s

# Clean up
docker-compose -f docker-compose.test.yml down -v
```

---

## 🌐 End-to-End (E2E) Tests

### What to E2E Test

```yaml
critical_user_journeys:
  - "User registration and login"
  - "Main feature workflows"
  - "Payment processing"
  - "Core business operations"
  
do_not_e2e_test:
  - "Edge cases (use unit tests)"
  - "Error scenarios (use integration)"
  - "UI variations"
```

### Running E2E Tests

```bash
# Start application in test mode
npm run start:test

# In another terminal, run E2E tests
npm run test:e2e

# Expected output:
# Running E2E tests with Playwright...
# 
# ✓ User can register (3.2s)
# ✓ User can login (2.5s)
# ✓ User can complete checkout (5.8s)
# 
# 3 passed (11.5s)

# Run in headed mode (see browser)
npm run test:e2e:headed

# Debug specific test
npm run test:e2e:debug
```

---

## 🤖 Test Automation & CI/CD

### GitHub Actions Workflow

```yaml
name: Test Suite

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run unit tests
        run: npm run test:unit:coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
  
  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      
      - name: Run integration tests
        run: npm run test:integration
  
  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run E2E tests
        run: npm run test:e2e
```

### Test Quality Gates

```yaml
deployment_blockers:
  - condition: "Unit coverage < 80%"
    action: "Block merge to main"
    
  - condition: "Any test failures"
    action: "Block merge to main"
    
  - condition: "E2E tests not run"
    action: "Block production deploy"

warnings:
  - condition: "Coverage decreased"
    action: "Comment on PR with diff"
    
  - condition: "Test time increased >20%"
    action: "Flag for investigation"
```

---

## 📊 Test Metrics & Reporting

### Coverage Reports

```bash
# Generate HTML coverage report
npm run test:coverage

# Open report
open coverage/index.html

# Coverage includes:
# - Line coverage (target: 80%)
# - Branch coverage (target: 75%)
# - Function coverage (target: 80%)
# - Uncovered lines highlighted
```

### Test Trends Dashboard

```yaml
metrics_tracked:
  - "Test count over time"
  - "Coverage percentage trend"
  - "Test execution time"
  - "Flaky test rate"
  - "Test failure rate"
```

---

## 🛠️ Test Utilities & Helpers

### Database Helpers

```javascript
// tests/helpers/db.js

export async function setupTestDB() {
  await db.query('DROP SCHEMA IF EXISTS test CASCADE');
  await db.query('CREATE SCHEMA test');
  await runMigrations();
}

export async function teardownTestDB() {
  await db.query('DROP SCHEMA IF EXISTS test CASCADE');
  await db.end();
}

export async function createTestUser(overrides = {}) {
  const defaultUser = {
    email: `test${Date.now()}@example.com`,
    password: await hashPassword('Test123!'),
    ...overrides
  };
  
  return await insertUser(defaultUser);
}
```

### API Test Helpers

```javascript
// tests/helpers/api.js

export async function authenticatedRequest(method, path, data) {
  const token = await getTestAuthToken();
  
  return request(app)
    [method](path)
    .set('Authorization', `Bearer ${token}`)
    .send(data);
}

export async function expectSuccess(response) {
  expect(response.status).toBe(200);
  expect(response.body.error).toBeUndefined();
  return response.body.data;
}
```

---

## ⚠️ Common Testing Pitfalls

| Pitfall | Impact | Solution |
|---------|--------|----------|
| Tests depend on order | Flaky tests | Use `beforeEach` for setup |
| Hardcoded delays | Slow tests | Use async/await or mock timers |
| Testing implementation | Brittle tests | Test behavior, not structure |
| No cleanup | Test interference | Always use `afterEach` |
| Mocking too much | Missing bugs | Only mock external deps |
| Not testing errors | Low confidence | Test every error scenario |

---

## 📚 Testing Resources

### Documentation
- [Jest Documentation](https://jestjs.io/)
- [Playwright Documentation](https://playwright.dev/)
- [Testing Library](https://testing-library.com/)

### Internal Guides
- Testing Best Practices
- Debugging Flaky Tests
- Test Data Management

---

**Document Owner**: QA Agent  
**Last Updated**: 2025-11-12  
**Status**: Template Ready