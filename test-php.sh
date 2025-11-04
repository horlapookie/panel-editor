#!/usr/bin/env bash
echo "===== Testing PHP availability ====="
echo "PATH: $PATH"
echo ""
echo "Checking for PHP..."
which php || echo "PHP not in which"
command -v php || echo "PHP not in command -v"
echo ""
echo "Checking /nix/store for PHP..."
find /nix/store -maxdepth 2 -name php -type f 2>/dev/null | head -5
echo ""
echo "Directly trying to run PHP..."
/nix/store/*/bin/php --version 2>&1 | head -5 || echo "Failed to run PHP directly"
echo ""
echo "Sleeping 5 seconds then retrying..."
sleep 5
which php && php --version
