#!/bin/bash
echo "Test script starting..."
echo "PATH: $PATH"
which php || echo "PHP not in PATH"
which composer || echo "Composer not in PATH"
which yarn || echo "Yarn not in PATH"
which node || echo "Node not in PATH"
ls /nix/store | grep php82 | head -5
