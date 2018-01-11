#!/usr/bin/env bash

chgrp -R www-data /var/lib/php/sessions

exec "$@"
