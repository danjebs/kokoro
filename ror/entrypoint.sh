#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /var/www/html/ror/tmp/pids/server.pid

# Clear out the log files on disk
rm -f /var/www/html/ror/log/development.log
rm -f /var/www/html/ror/log/staging.log
rm -f /var/www/html/ror/log/production.log

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
