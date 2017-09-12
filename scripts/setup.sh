#!/bin/bash

set -e
cmd="$@"

until psql -h pg -U postgres -c "\l"; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command(s)"
rails db:create
rails db:migrate
exec $cmd