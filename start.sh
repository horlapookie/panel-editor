#!/usr/bin/env bash
set -e

echo "Starting Pterodactyl Panel setup..."

# Sanity check for required tools
for cmd in php composer node yarn; do
    if ! command -v $cmd &> /dev/null; then
        echo "ERROR: $cmd not found in PATH"
        exit 1
    fi
    echo "✓ Found $cmd: $(which $cmd)"
done

# Install composer dependencies
if [ ! -d "vendor" ]; then
    echo "Installing Composer dependencies..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

# Install node dependencies  
echo "Installing/updating Node.js dependencies with Yarn..."
yarn install --frozen-lockfile

# Add node_modules/.bin to PATH for build tools
export PATH="$PWD/node_modules/.bin:$PATH"
echo "PATH updated: node_modules/.bin added"

# Generate app key if not set
if grep -q "APP_KEY=$" .env || grep -q "APP_KEY=\"\"" .env; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

# Build frontend assets (this may take a few minutes)
# Use legacy OpenSSL provider for Webpack 4 compatibility with Node.js 17+
echo "Building frontend assets..."
export NODE_OPTIONS=--openssl-legacy-provider
yarn run build:production

# Run migrations (skip for now as we don't have a database)
# php artisan migrate --force

# Start the panel server
echo "Starting Pterodactyl Panel on port 5000..."
php artisan serve --host=0.0.0.0 --port=5000
