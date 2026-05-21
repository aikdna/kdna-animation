#!/bin/bash
# KDNA Cluster Validation Script
# Checks that all domains have the required six-file structure and valid meta fields.
# Requires: bash, python3
# Usage: bash validate.sh

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PASS=0
FAIL=0
WARN=0

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_pass() { echo -e "  ${GREEN}PASS${NC} $1"; ((PASS++)) || true; }
log_fail() { echo -e "  ${RED}FAIL${NC} $1"; ((FAIL++)) || true; }
log_warn() { echo -e "  ${YELLOW}WARN${NC} $1"; ((WARN++)) || true; }

echo "=== KDNA Cluster Validation ==="
echo ""

# Check cluster_manifest.json
echo "--- cluster_manifest.json ---"
if [ -f "$SCRIPT_DIR/cluster_manifest.json" ]; then
    log_pass "cluster_manifest.json exists"
    result=$(python3 -c "
import json
with open('$SCRIPT_DIR/cluster_manifest.json') as f:
    m = json.load(f)
checks = ['name', 'version', 'domains', 'composition_rules', 'conflict_resolution']
missing = [c for c in checks if c not in m]
if missing:
    print('FAIL: missing fields: ' + ', '.join(missing))
else:
    print('OK')
" 2>&1)
    if [ "$result" = "OK" ]; then
        log_pass "Manifest structure valid"
    else
        log_fail "$result"
    fi
else
    log_fail "cluster_manifest.json not found"
fi

echo ""
echo "--- Root files ---"
for f in README.md LICENSE CONTRIBUTING.md CHANGELOG.md CODE_OF_CONDUCT.md .gitignore validate.sh; do
    if [ -f "$SCRIPT_DIR/$f" ]; then
        log_pass "$f exists"
    else
        log_warn "$f missing"
    fi
done

echo ""
echo "--- Domain validation ---"

KDNA_FILES="KDNA_Core.json KDNA_Patterns.json KDNA_Scenarios.json KDNA_Cases.json KDNA_Reasoning.json KDNA_Evolution.json"

for domain_dir in "$SCRIPT_DIR"/*/ ; do
    domain_name=$(basename "$domain_dir")

    has_kdna=false
    for f in $KDNA_FILES; do
        [ -f "$domain_dir/$f" ] && has_kdna=true && break
    done
    [ "$has_kdna" = false ] && continue

    echo ""
    echo "  Domain: $domain_name"

    missing_files=0
    for f in $KDNA_FILES; do
        if [ -f "$domain_dir/$f" ]; then
            log_pass "$f exists"
        else
            log_fail "$f missing"
            missing_files=$((missing_files + 1))
        fi
    done

    if [ -f "$domain_dir/README.md" ]; then
        log_pass "README.md exists"
    else
        log_warn "README.md missing"
    fi

    for f in $KDNA_FILES; do
        [ ! -f "$domain_dir/$f" ] && continue
        filepath="$domain_dir/$f"

        result=$(python3 -c "
import json
with open('$filepath') as fh:
    data = json.load(fh)
meta = data.get('meta', {})
required = ['version', 'domain', 'created', 'purpose', 'load_condition']
missing = [m for m in required if m not in meta]
if missing:
    print('FAIL: missing meta fields: ' + ', '.join(missing))
elif meta.get('domain') != '$domain_name':
    print('FAIL: meta.domain mismatch (expected $domain_name, got ' + str(meta.get('domain')) + ')')
else:
    print('OK')
" 2>&1)
        if [ "$result" = "OK" ]; then
            log_pass "$f JSON and meta valid"
        else
            log_fail "$result"
        fi

        case "$f" in
            KDNA_Core.json)
                result=$(python3 -c "
import json
with open('$filepath') as fh:
    d = json.load(fh)
axioms = d.get('axioms', [])
ontology = d.get('ontology', [])
frameworks = d.get('frameworks', [])
issues = []
if not isinstance(axioms, list) or len(axioms) < 2:
    issues.append('axioms too few (need >=2)')
if not isinstance(ontology, list) or len(ontology) < 2:
    issues.append('ontology too few (need >=2)')
if not isinstance(frameworks, list) or len(frameworks) < 1:
    issues.append('frameworks too few (need >=1)')
if issues:
    print('WARN: ' + ', '.join(issues))
else:
    print('OK')
" 2>&1)
                if [ "$result" = "OK" ]; then
                    log_pass "$f content checks pass"
                else
                    log_warn "$result"
                fi
                ;;
            KDNA_Patterns.json)
                result=$(python3 -c "
import json
with open('$filepath') as fh:
    d = json.load(fh)
sc = d.get('self_check', [])
mis = d.get('misunderstandings', [])
mis_ids = {m['id'] for m in mis if 'id' in m}
sc_ids = {s['id'] for s in sc if 'id' in s}
overlap = mis_ids & sc_ids
if overlap:
    print('FAIL: duplicate IDs between misunderstandings and self_check: ' + str(overlap))
else:
    print('OK')
" 2>&1)
                if [ "$result" = "OK" ]; then
                    log_pass "$f no ID overlap between misunderstandings and self_check"
                else
                    log_fail "$result"
                fi
                ;;
        esac
    done
done

echo ""
echo "=== Results: $PASS passed, $FAIL failed, $WARN warnings ==="

if [ "$FAIL" -gt 0 ]; then
    echo -e "${RED}Validation FAILED${NC}"
    exit 1
else
    echo -e "${GREEN}Validation PASSED${NC}"
    exit 0
fi
