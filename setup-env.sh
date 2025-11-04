#!/bin/bash

# Find and add Nix packages to PATH
export PATH="/nix/var/nix/profiles/default/bin:$PATH"

# Try to find PHP
PHP_PATH=$(find /nix/store -maxdepth 1 -name "*php-8.2*" -o -name "*php82-8.2*" 2>/dev/null | head -1)
if [ -n "$PHP_PATH" ] && [ -d "$PHP_PATH/bin" ]; then
    export PATH="$PHP_PATH/bin:$PATH"
fi

# Try to find Composer
COMPOSER_PATH=$(find /nix/store -maxdepth 1 -name "*composer-2*" 2>/dev/null | head -1)
if [ -n "$COMPOSER_PATH" ] && [ -d "$COMPOSER_PATH/bin" ]; then
    export PATH="$COMPOSER_PATH/bin:$PATH"
fi

# Try to find Node.js
NODE_PATH=$(find /nix/store -maxdepth 1 -name "*nodejs-20*" 2>/dev/null | head -1)
if [ -n "$NODE_PATH" ] && [ -d "$NODE_PATH/bin" ]; then
    export PATH="$NODE_PATH/bin:$PATH"
fi

# Try to find Yarn
YARN_PATH=$(find /nix/store -maxdepth 1 -name "*yarn-1*" 2>/dev/null | head -1)
if [ -n "$YARN_PATH" ] && [ -d "$YARN_PATH/bin" ]; then
    export PATH="$YARN_PATH/bin:$PATH"
fi

echo "Environment setup complete"
echo "PATH: $PATH"
which php && php --version
which composer && composer --version
which node && node --version
which yarn && yarn --version
