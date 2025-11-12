# Agent Roles & Coordination

```yaml
meta:
  document_version: "1.0.0"
  owner: "orchestrator-agent"
  coordination_protocol: "v1.0"
  last_updated: "2025-11-12"
```

---

## 🤖 Agent Registry

This template defines how multiple AI agents coordinate to build production software. Each agent has specific responsibilities, approval authority, and handoff points.

### Key Agents

| Agent ID | Role | Primary Modules | Approval Authority |
|----------|------|-----------------|-------------------|
| orchestrator | Project coordination | Overall planning | High (can override) |
| architect | System design | Architecture, scaffold | Medium |
| backend | API implementation | Backend services | Medium |
| frontend | UI implementation | User interface | Medium |
| data | Database design | Data layer | Medium |
| qa | Quality assurance | Testing, validation | High (can block) |
| ops | Deployment | Infrastructure | High (controls deploy) |
| security | Security review | Security validation | High (can block) |

---

## 🔄 Handoff Protocol

### Phase Transitions

Agents hand off work when completing specific milestones. Each handoff includes:
- **Trigger**: Condition that enables handoff
- **Artifacts**: Files/data being transferred
- **Validation**: Automated checks before handoff
- **Approval**: Whether manual approval needed

#### Plan → Scaffold

```yaml
trigger: "All documentation approved"
from_agent: "orchestrator"
to_agent: "architect"
artifacts:
  - README.md
  - ARCHITECTURE.md
  - PROJECT_PLAN.md
  - AGENT_ROLES.md
validation: "npm run verify:structure"
approval_required: false
```

#### Scaffold → Implement

```yaml
trigger: "Base structure complete"
from_agent: "architect"
to_agent: "backend, frontend"
artifacts:
  - package.json
  - tsconfig.json
  - docker-compose.yml
  - CI/CD configuration
validation: "npm run verify:scaffold"
approval_required: false
```

#### Implement → Verify

```yaml
trigger: "All features complete"
from_agent: "backend, frontend"
to_agent: "qa"
artifacts:
  - Source code
  - Unit tests
  - Integration tests
  - API documentation
validation: "npm run test:all"
approval_required: false
```

#### Verify → Deploy

```yaml
trigger: "All tests passing and guardrails satisfied"
from_agent: "qa"
to_agent: "ops"
artifacts:
  - Test reports
  - Coverage reports
  - Performance benchmarks
  - Security scan results
validation: "npm run verify:production-ready"
approval_required: true
```

---

## 🎯 Agent Responsibilities

### Orchestrator Agent

**Primary Responsibilities**:
- Overall project planning and coordination
- Agent task assignment and scheduling
- Conflict resolution and escalation
- Progress monitoring and reporting
- Risk management

**Deliverables**:
- Project plan and timeline
- Agent coordination logs
- Status reports
- Risk assessments

**Authority Level**: High (can override other agents)

---

### Architect Agent

**Primary Responsibilities**:
- System architecture design
- Technology stack selection
- Module dependency mapping
- Scaffold generation
- Design pattern enforcement

**Deliverables**:
- ARCHITECTURE.md
- System diagrams
- File/folder structure
- Configuration files

**Authority Level**: Medium (approves design decisions)

---

### Backend Agent

**Primary Responsibilities**:
- API endpoint implementation
- Database schema and migrations
- Business logic and services
- Authentication and authorization
- Backend unit and integration tests

**Deliverables**:
- Backend source code
- API documentation
- Database migrations
- Integration tests

**Authority Level**: Medium (approves backend changes)

---

### Frontend Agent

**Primary Responsibilities**:
- UI component implementation
- Page layouts and routing
- State management
- API integration
- Frontend unit tests

**Deliverables**:
- Frontend source code
- Component library
- E2E test scenarios
- Responsive designs

**Authority Level**: Medium (approves frontend changes)

---

### QA Agent

**Primary Responsibilities**:
- Test strategy and planning
- Test automation
- Coverage monitoring
- Guardrail enforcement
- Quality gate validation

**Deliverables**:
- TESTING.md
- GUARDRAILS.md
- Test suite
- Coverage reports
- Quality reports

**Authority Level**: High (can block deployments)

---

### Operations Agent

**Primary Responsibilities**:
- Deployment automation
- Infrastructure management
- Monitoring and alerting
- Incident response
- Runbook maintenance

**Deliverables**:
- CI/CD pipelines
- Deployment scripts
- Monitoring dashboards
- Runbooks

**Authority Level**: High (controls deployments)

---

## ⚠️ Conflict Resolution

### Priority Order

When conflicts arise between agents:

1. **Security vulnerabilities** - Highest priority
2. **Critical bugs** - Must fix immediately
3. **Performance issues** - Address before features
4. **Feature development** - Standard priority
5. **Refactoring** - Lower priority
6. **Documentation** - Ongoing priority

### Escalation Path

```
Agent detects issue
    ↓
Attempt auto-resolution
    ↓
Success? → Log and continue
    ↓ No
Escalate to module owner
    ↓
Can resolve? → Fix and deploy
    ↓ No
Escalate to Orchestrator
    ↓
Coordinate multi-agent response
```

---

## 📊 Coordination Metrics

Track these metrics to measure agent coordination effectiveness:

```yaml
handoff_success_rate: "target >95%"
average_handoff_time: "target <5 minutes"
conflict_rate: "target <5%"
escalation_count: "track monthly"
blocked_time_percentage: "target <10%"
```

---

## 📚 Related Documentation

- [PROJECT_PLAN.md](PROJECT_PLAN.md) - Project phases and timeline
- [ARCHITECTURE.md](ARCHITECTURE.md) - System design
- [GUARDRAILS.md](GUARDRAILS.md) - Quality standards
- [TESTING.md](TESTING.md) - Test strategy

---

**Document Owner**: Orchestrator Agent  
**Last Updated**: 2025-11-12  
**Status**: Template Ready