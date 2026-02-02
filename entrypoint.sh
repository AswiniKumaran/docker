#!/bin/bash
echo "Running migrations"
python manage.py migrate

echo "starting gunicorn"
exec  gunicorn learn_docker.wsgi:application --bind 0.0.0.0:8000 --workers 3