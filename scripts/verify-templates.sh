#!/bin/bash

# Template Validation Script
# Validates that all placeholders in templates have been filled

set -e

echo "🔍 Validating Multi-Agent Templates..."
echo ""

ERRORS=0
WARNINGS=0

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo -e "${RED}❌ Error: README.md not found. Run this script from project root.${NC}"
    exit 1
fi

echo "📋 Checking for unfilled placeholders..."
echo ""

# List of files to check
FILES=(
    "README.md"
    "docs/ARCHITECTURE.md"
    "docs/SETUP.md"
    "docs/TESTING.md"
    "docs/GUARDRAILS.md"
    "docs/PROJECT_PLAN.md"
    "docs/AGENT_ROLES.md"
)

# Check each file for placeholders
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        # Count placeholders like {{placeholder_name}}
        placeholder_count=$(grep -o "{{[^}]*}}" "$file" 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$placeholder_count" -gt 0 ]; then
            echo -e "${YELLOW}⚠️  $file has $placeholder_count unfilled placeholders${NC}"
            # Show first 5 unfilled placeholders
            grep -o "{{[^}]*}}" "$file" 2>/dev/null | head -5
            echo ""
            WARNINGS=$((WARNINGS + 1))
        else
            echo -e "${GREEN}✅ $file - All placeholders filled${NC}"
        fi
    else
        echo -e "${RED}❌ $file - File not found${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "📊 Validation Summary:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 All validation checks passed!${NC}"
    echo -e "${GREEN}✅ All required files present${NC}"
    echo -e "${GREEN}✅ All placeholders filled${NC}"
    echo ""
    echo "Your project is ready for development! 🚀"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Validation passed with warnings${NC}"
    echo -e "${YELLOW}   Files with unfilled placeholders: $WARNINGS${NC}"
    echo ""
    echo "Please fill in the remaining placeholders before proceeding."
    exit 0
else
    echo -e "${RED}❌ Validation failed${NC}"
    echo -e "${RED}   Missing files: $ERRORS${NC}"
    echo -e "${YELLOW}   Files with placeholders: $WARNINGS${NC}"
    echo ""
    echo "Please fix the errors above before proceeding."
    exit 1
fi