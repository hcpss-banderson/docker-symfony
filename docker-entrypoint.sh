#!/usr/bin/env bash

chgrp -R www-data /var/lib/php/sessions
chown -R www-data:www-data /var/www/symfony/var

exec "$@"
