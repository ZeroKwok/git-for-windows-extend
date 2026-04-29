#!/usr/bin/env bash

# ==============================================================================
# Git-for-Windows-Extend Validation Script
# Purpose: Verify that MSYS2-extracted binaries and their DLLs are functional.
# ==============================================================================

# ANSI Color Codes
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

echo -e "${YELLOW}Starting Git Bash Extension Toolchain Check...${NC}"
echo "--------------------------------------------------------"

# Function to test tool existence, dependencies, and execution
check_extension() {
    local cmd=$1
    local args=$2

    echo -n "Checking ($cmd $args)... "

    # 1. Path Check
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}[MISSING]${NC} Command not found in PATH."
        return 1
    fi

    # 2. Dependency Check (ldd looks for missing DLLs)
    local ldd_check
    ldd_check=$(ldd "$(which "$cmd")" 2>&1)
    if echo "$ldd_check" | grep -iq "not found"; then
        echo -e "${RED}[DLL ERROR]${NC} Dependencies missing:"
        echo "$ldd_check" | grep -i "not found"
        return 1
    fi

    # 3. Execution Check
    if eval "$cmd $args" &> /dev/null; then
        echo -e "${GREEN}[OK]${NC}"
    else
        echo -e "${RED}[EXEC FAIL]${NC} Binary crashed or returned error."
        return 1
    fi
}

# --- Component Test List ---

# sshd
if ls /etc/ssh/ssh_host_*_key 1> /dev/null 2>&1; then
    check_extension "sshd" "-t"
else
    echo -e "${YELLOW}Skip sshd. The SSH host key was not found. Please run 'ssh-keygen -A'.${NC}"
fi

# rsync
check_extension "rsync" "--version"

# wget
check_extension "wget" "--version"

# nc
check_extension "nc" "-h"

# System Monitoring (procps-ng)
check_extension "free" "-V"
check_extension "top" "-V"
check_extension "uptime" "-V"
check_extension "watch" "-v"

# micro
check_extension "micro" "-version"

echo "--------------------------------------------------------"
echo -e "${YELLOW}Verification Complete!${NC}"
