# Guardrails Framework

```yaml
meta:
  framework_version: "1.0.0"
  owner_agent: "qa"
  enforcement: "automated"
  last_updated: "2025-11-12"
  
coverage_targets:
  unit: 80
  integration: 70
  e2e: "critical_paths_only"
```

---

## 🧠 Core Principles

### 1. Truth
**Outputs must be correct and traceable**
- All data must be verifiable
- No hallucinated information
- All external data validated

### 2. Utility
**Deliver functional, runnable code**
- Code must execute without errors
- All features must be testable
- No broken implementations

### 3. Completeness
**No placeholders or missing logic**
- No TODO comments in production
- All error paths handled
- All edge cases addressed

### 4. Validation
**≥80% coverage target**
- Comprehensive test suite
- Automated validation on every commit
- Performance benchmarks enforced

### 5. Error Recovery
**Implement fallback and retry logic**
- Graceful degradation on failures
- Circuit breakers for external services
- Clear error messages

---

## 🧩 Guardrail Weights

| Category | Weight | Enforcement | Example |
|----------|--------|-------------|---------|
| Critical | 🟥 | Blocks deployment | Data loss, security breach |
| High | 🟧 | Requires approval | Payment failure, auth error |
| Medium | 🟨 | Warning only | Slow response, cache miss |
| Low | 🟩 | Tracked only | UI glitch, typo |

---

## 🧠 Validation Coverage Targets

| Test Type | Target | Enforcement | Blocking |
|-----------|--------|-------------|----------|
| Unit | 80% | Blocks merge | ✅ Yes |
| Integration | 70% | Blocks merge | ✅ Yes |
| E2E | Critical paths | Blocks deploy | ✅ Yes |
| Performance | <200ms API | Blocks deploy | ✅ Yes |
| Security | 0 vulnerabilities | Blocks deploy | ✅ Yes |

---

## ✅ Automated Validation Commands

### All Guardrail Checks

```bash
# Run all guardrail checks (agent-executable)
npm run guardrails:check

# Expected output:
# 🔍 Running guardrail validation suite...
# 
# ✅ Structure: All required files present
# ✅ Lint: No errors, 0 warnings
# ✅ Security: 0 vulnerabilities found
# ✅ Tests: All passed (85% coverage)
# ✅ Performance: All metrics within targets
# ✅ Build: Bundle size 245KB (under 500KB)
# 
# 🎉 All guardrails passed!
```

### Individual Checks

```bash
# File structure validation
npm run guardrails:structure

# Code quality
npm run guardrails:lint

# Security scan
npm run guardrails:security

# Test coverage
npm run guardrails:tests

# Performance benchmarks
npm run guardrails:performance

# Type safety (if TypeScript)
npm run guardrails:types
```

---

## 🚨 Failure Handling

### Automatic Rollback Triggers

```yaml
trigger_rollback_if:
  error_rate: ">1%"
  response_time_p95: ">500ms"
  memory_usage: ">90%"
  cpu_usage: ">80%"
  test_failures: ">0"
  security_vulnerabilities: ">0"
```

### Recovery Procedures

```bash
# Emergency rollback (agent-executable)
./scripts/rollback.sh --to-version=previous

# Verify rollback success
npm run verify:health

# Expected output:
# ✅ Application responding
# ✅ Database connected
# ✅ All health checks passing
# ✅ Error rate back to normal
```

---

## 🔒 Security Guardrails

### Critical Security Checks

| Check | Enforcement | Tool | Frequency |
|-------|-------------|------|-----------|
| Dependency vulnerabilities | Blocks merge | npm audit | Every commit |
| Secret detection | Blocks merge | git-secrets | Every commit |
| SQL injection | Blocks merge | Static analysis | Every PR |
| XSS prevention | Blocks merge | Static analysis | Every PR |
| CSRF protection | Blocks deploy | Integration tests | Every deploy |
| Auth bypass | Blocks deploy | Security tests | Every deploy |

```bash
# Run all security checks
npm run security:check

# Expected output:
# 🔐 Running security validation...
# 
# ✅ No dependency vulnerabilities (0 found)
# ✅ No secrets detected in code
# ✅ SQL injection protection verified
# ✅ XSS protection verified
# ✅ CSRF tokens present
# ✅ Authentication tests passing
# 
# 🔒 All security checks passed!
```

---

## ⚡ Performance Guardrails

### Performance Budgets

| Metric | Target | Enforcement |
|--------|--------|-------------|
| API Response (p95) | <200ms | Blocks deploy |
| Frontend Load (FCP) | <2s | Blocks deploy |
| Bundle Size | <500KB | Blocks build |
| Lighthouse Score | >90 | Warning |
| Time to Interactive | <3s | Blocks deploy |

```bash
# Run performance validation
npm run performance:check

# Expected output:
# ⚡ Running performance validation...
# 
# ✅ API response time: 145ms (target: <200ms)
# ✅ Frontend load time: 1.8s (target: <2s)
# ✅ Bundle size: 245KB (target: <500KB)
# ✅ Lighthouse score: 92 (target: >90)
# 
# ⚡ All performance targets met!
```

---

## 🧪 Test Quality Guardrails

### Test Requirements

```yaml
unit_tests:
  coverage_minimum: 80%
  max_execution_time: "30 seconds"
  required_for: "all business logic"
  
integration_tests:
  coverage_minimum: 70%
  max_execution_time: "2 minutes"
  required_for: "all API endpoints"
  
e2e_tests:
  required_scenarios: "critical user journeys"
  max_execution_time: "10 minutes"
  required_for: "deployment to production"
```

---

## 📊 Code Quality Guardrails

### Code Quality Standards

| Standard | Tool | Enforcement | Auto-Fix |
|----------|------|-------------|----------|
| Linting | ESLint | Blocks commit | ✅ Yes |
| Formatting | Prettier | Blocks commit | ✅ Yes |
| Type Safety | TypeScript | Blocks build | ❌ No |
| Complexity | SonarQube | Warning | ❌ No |

```bash
# Run code quality checks
npm run quality:check

# Expected output:
# 📊 Running code quality validation...
# 
# ✅ ESLint: 0 errors, 0 warnings
# ✅ Prettier: All files formatted
# ✅ TypeScript: No type errors
# ⚠️  Complexity: 2 functions above threshold
# 
# Status: PASS (warnings don't block)
```

---

## 🔄 CI/CD Guardrails

### Pipeline Stages

```yaml
stage_1_validation:
  - structure_check
  - lint_check
  - type_check
  - security_scan
  blocking: true
  
stage_2_testing:
  - unit_tests
  - integration_tests
  - coverage_check
  blocking: true
  
stage_3_build:
  - frontend_build
  - backend_build
  - bundle_size_check
  blocking: true
  
stage_4_e2e:
  - e2e_tests
  - performance_tests
  - smoke_tests
  blocking: true
  
stage_5_deploy:
  - deploy_to_staging
  - verify_staging
  - manual_approval_required
  - deploy_to_production
  blocking: true
```

### Quality Gates

```yaml
merge_to_main_requires:
  - all_tests_passing: true
  - coverage_above_threshold: true
  - security_scan_clean: true
  - peer_review_approved: true
  - ci_pipeline_green: true
  
deploy_to_production_requires:
  - all_merge_requirements: true
  - e2e_tests_passing: true
  - performance_benchmarks_met: true
  - security_tests_passing: true
  - manual_approval: true
```

---

## 🎯 Agent-Specific Guardrails

### Code Generation Agent

```yaml
must_do:
  - Generate syntactically correct code
  - Include error handling
  - Add documentation
  - Write unit tests
  - Follow project standards
  
must_not_do:
  - Generate code with TODO comments
  - Use deprecated APIs
  - Create security vulnerabilities
  - Skip error handling
```

### Testing Agent

```yaml
must_do:
  - Achieve minimum coverage targets
  - Test all error paths
  - Test edge cases
  - Use descriptive test names
  - Ensure tests are deterministic
  
must_not_do:
  - Skip tests
  - Write flaky tests
  - Test implementation details
  - Share state between tests
```

### Deployment Agent

```yaml
must_do:
  - Verify health checks pass
  - Run smoke tests post-deploy
  - Monitor error rates
  - Have rollback plan ready
  - Document deployment
  
must_not_do:
  - Deploy with failing tests
  - Skip staging environment
  - Deploy without approval
  - Ignore health check failures
```

---

## 🔍 Common Failures & Solutions

| Failure | Cause | Solution |
|---------|-------|----------|
| Coverage below threshold | New code without tests | Write tests for uncovered code |
| Security vulnerability | Outdated dependency | Update: `npm update package-name` |
| Bundle size exceeded | Large dependency | Analyze: `npm run analyze:bundle` |
| Performance test failed | Slow query | Add index or optimize |
| Lint errors | Non-standard style | Auto-fix: `npm run lint:fix` |

---

## 📚 Related Documentation

- [TESTING.md](TESTING.md) - Detailed testing strategy
- [ARCHITECTURE.md](ARCHITECTURE.md) - System design
- [PROJECT_PLAN.md](PROJECT_PLAN.md) - Development phases

---

**Document Owner**: QA Agent  
**Last Updated**: 2025-11-12  
**Status**: Template Ready