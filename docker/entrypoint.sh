#!/bin/bash

# Create the admin user using values from config.json
export AIRFLOW__WEBSERVER__AUTHENTICATE=True
export AIRFLOW__WEBSERVER__AUTH_BACKEND=airflow.contrib.auth.backends.password_auth
export AIRFLOW__WEBSERVER__BASE_URL=http://localhost:8080
export AIRFLOW__WEBSERVER__SECRET_KEY=your_secret_key

echo "Creating admin user..."
airflow users create \
  --username "$AIRFLOW_ADMIN_USER" \
  --firstname Admin \
  --lastname User \
  --role Admin \
  --email admin@example.com \
  --password "$AIRFLOW_ADMIN_PASSWORD"

# Read config.json
CONFIG_FILE="/config.json"
if [ -f "$CONFIG_FILE" ]; then
  AIRFLOW_ADMIN_USER=$(jq -r .admin_user "$CONFIG_FILE")
  AIRFLOW_ADMIN_PASSWORD=$(jq -r .admin_password "$CONFIG_FILE")
  airflow users create \
    --username "$AIRFLOW_ADMIN_USER" \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password "$AIRFLOW_ADMIN_PASSWORD"
fi

# Initialize the database
airflow db init

# Start Airflow web server, scheduler, and worker
airflow webserver -p 8080 &
airflow scheduler &
airflow worker &

# Wait for all processes to finish
wait
