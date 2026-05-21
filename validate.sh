#!/bin/bash
# KDNA Cluster Validation Script (v0.4 schema compatible)
# Usage: bash validate.sh

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PASS=0; FAIL=0; WARN=0
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log_pass() { echo -e "  ${GREEN}PASS${NC} $1"; ((PASS++)) || true; }
log_fail() { echo -e "  ${RED}FAIL${NC} $1"; ((FAIL++)) || true; }
log_warn() { echo -e "  ${YELLOW}WARN${NC} $1"; ((WARN++)) || true; }
echo "=== KDNA v0.4 Cluster Validation ==="; echo ""

# ── KDNA_Cluster.json ──
echo "--- KDNA_Cluster.json ---"
if [ -f "$SCRIPT_DIR/KDNA_Cluster.json" ]; then
    log_pass "KDNA_Cluster.json exists"
    result=$(python3 -c "
import json
with open('$SCRIPT_DIR/KDNA_Cluster.json') as f: m = json.load(f)
c = ['name','version','purpose','packages','composition_rules','routing_questions']
missing=[k for k in c if k not in m]
print('OK' if not missing else 'FAIL: missing: '+', '.join(missing))
" 2>&1); [ "$result" = "OK" ] && log_pass "Cluster structure valid" || log_fail "$result"
else
    log_fail "KDNA_Cluster.json not found"
fi

echo ""; echo "--- Root files ---"
for f in README.md LICENSE CONTRIBUTING.md CHANGELOG.md CODE_OF_CONDUCT.md .gitignore validate.sh; do
    [ -f "$SCRIPT_DIR/$f" ] && log_pass "$f" || log_warn "$f missing"
done

echo ""; echo "--- Domain validation ---"
KDNA_FILES="KDNA_Core.json KDNA_Patterns.json KDNA_Scenarios.json KDNA_Cases.json KDNA_Reasoning.json KDNA_Evolution.json"
for domain_dir in "$SCRIPT_DIR"/*/ ; do
    dn=$(basename "$domain_dir")
    has=false; for f in $KDNA_FILES; do [ -f "$domain_dir/$f" ] && has=true && break; done
    [ "$has" = false ] && continue
    echo ""; echo "  Domain: $dn"
    for f in $KDNA_FILES; do
        [ -f "$domain_dir/$f" ] && log_pass "$f" || { log_fail "$f missing"; continue; }
    done
    [ -f "$domain_dir/README.md" ] && log_pass "README.md" || log_warn "README.md missing"

    for f in $KDNA_FILES; do
        [ ! -f "$domain_dir/$f" ] && continue
        fp="$domain_dir/$f"
        r=$(python3 -c "
import json
with open('$fp') as fh: d=json.load(fh)
m=d.get('meta',{}); req=['version','domain','created','purpose','load_condition']
ms=[x for x in req if x not in m]
if ms: print('FAIL: missing meta: '+', '.join(ms))
elif m.get('domain')!='$dn': print('FAIL: domain mismatch')
else: print('OK')
" 2>&1)
        [ "$r" = "OK" ] && log_pass "$f meta" || log_fail "$r"
    done

    # Core content checks (v0.4 fields)
    python3 -c "
import json
with open('$domain_dir/KDNA_Core.json') as fh: d=json.load(fh)
issues=[]
# axioms check v0.4 fields
for a in d.get('axioms',[]):
    for k in ['id','one_sentence','full_statement','why']:
        if k not in a: issues.append(f'axiom {a.get(\"id\",\"?\")} missing {k}')
# ontology check v0.4 fields
for o in d.get('ontology',[]):
    for k in ['id','one_sentence','essence','boundary','trigger_signal']:
        if k not in o: issues.append(f'ontology {o.get(\"id\",\"?\")} missing {k}')
# frameworks
for fw in d.get('frameworks',[]):
    for k in ['id','name','when_to_use','steps']:
        if k not in fw: issues.append(f'framework {fw.get(\"id\",\"?\")} missing {k}')
# core_structure
for cs in d.get('core_structure',[]):
    for k in ['from','to','via']:
        if k not in cs: issues.append('core_structure missing '+k)
# stances
if not isinstance(d.get('stances'),list): issues.append('stances not a list')
if issues:
    for i in issues: print(f'WARN Core: {i}')
else:
    print('OK_CORE')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_CORE" ] && log_pass "KDNA_Core.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done

    # Patterns checks (v0.4 fields)
    python3 -c "
import json
with open('$domain_dir/KDNA_Patterns.json') as fh: d=json.load(fh)
issues=[]
t=d.get('terminology',{})
if 'standard_terms' not in t: issues.append('standard_terms missing')
if 'banned_terms' not in t: issues.append('banned_terms missing')
for m in d.get('misunderstandings',[]):
    for k in ['id','wrong','correct','key_distinction','why']:
        if k not in m: issues.append(f'misunderstanding {m.get(\"id\",\"?\")} missing {k}')
if not isinstance(d.get('self_check'),list): issues.append('self_check not a list')
mid={m['id'] for m in d.get('misunderstandings',[]) if 'id' in m}
if mid:
    for s in d.get('self_check',[]):
        if s in mid: issues.append(f'self_check contains misunderstanding ID: {s}')
if issues:
    for i in issues: print(f'WARN Patterns: {i}')
else:
    print('OK_PAT')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_PAT" ] && log_pass "KDNA_Patterns.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done

    # Scenarios checks
    python3 -c "
import json
with open('$domain_dir/KDNA_Scenarios.json') as fh: d=json.load(fh)
issues=[]
for s in d.get('scenes',[]):
    for k in ['id','name','trigger_signal','sub_scenarios']:
        if k not in s: issues.append(f'scene {s.get(\"id\",\"?\")} missing {k}')
if not issues: print('OK_SCN')
else:
    for i in issues: print(f'WARN Scenarios: {i}')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_SCN" ] && log_pass "KDNA_Scenarios.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done

    # Cases checks
    python3 -c "
import json
with open('$domain_dir/KDNA_Cases.json') as fh: d=json.load(fh)
issues=[]
for c in d.get('cases',[]):
    for k in ['id','title','context','what_happened','what_was_learned','structural_pattern']:
        if k not in c: issues.append(f'case {c.get(\"id\",\"?\")} missing {k}')
if not issues: print('OK_CASE')
else:
    for i in issues: print(f'WARN Cases: {i}')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_CASE" ] && log_pass "KDNA_Cases.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done

    # Reasoning checks
    python3 -c "
import json
with open('$domain_dir/KDNA_Reasoning.json') as fh: d=json.load(fh)
issues=[]
for rc in d.get('reasoning_chains',[]):
    for k in ['id','one_sentence','logic','so_what']:
        if k not in rc: issues.append(f'chain {rc.get(\"id\",\"?\")} missing {k}')
if not issues: print('OK_RC')
else:
    for i in issues: print(f'WARN Reasoning: {i}')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_RC" ] && log_pass "KDNA_Reasoning.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done

    # Evolution checks
    python3 -c "
import json
with open('$domain_dir/KDNA_Evolution.json') as fh: d=json.load(fh)
issues=[]
for s in d.get('stages',[]):
    for k in ['id','name','description','indicators']:
        if k not in s: issues.append(f'stage {s.get(\"id\",\"?\")} missing {k}')
for el in d.get('evolution_layers',[]):
    for k in ['id','name','capability','from_stage','to_stage']:
        if k not in el: issues.append(f'layer {el.get(\"id\",\"?\")} missing {k}')
for ms in d.get('measurement',[]):
    for k in ['id','what','how','threshold']:
        if k not in ms: issues.append(f'measurement {ms.get(\"id\",\"?\")} missing {k}')
if not issues: print('OK_EVO')
else:
    for i in issues: print(f'WARN Evolution: {i}')
" 2>&1 | while IFS= read -r line; do
        [ "$line" = "OK_EVO" ] && log_pass "KDNA_Evolution.json v0.4 fields" || ([ "${line:0:4}" = "WARN" ] && log_warn "$line" || true)
    done
done

echo ""; echo "=== Results: $PASS passed, $FAIL failed, $WARN warnings ==="
[ "$FAIL" -gt 0 ] && echo -e "${RED}FAILED${NC}" && exit 1
echo -e "${GREEN}PASSED${NC}"; exit 0
