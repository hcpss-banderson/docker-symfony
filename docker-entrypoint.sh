#!/usr/bin/env bash

/var/www/symfony/bin/console cache:clear
/var/www/symfony/bin/console assets:install --symlink --relative %PUBLIC_DIR%

chgrp -R www-data /var/lib/php/sessions
chown -R www-data:www-data /var/www/symfony/var
chown -R www-data:www-data /var/www/symfony/public/images
chown -R www-data:www-data /var/www/symfony/public/imagine

exec "$@"
