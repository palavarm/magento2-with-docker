#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-app}
env=${APP_ENV:-production}


if [ "$env" == "production" ]; then
    exec composer install --optimize-autoloader --no-dev
    exec php artisan config:cache
    exec php artisan route:cache
fi

