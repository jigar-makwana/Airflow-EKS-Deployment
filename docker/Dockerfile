# Use the official Python base image
FROM python:3.8-slim-buster

# Set environment variables
ENV AIRFLOW_HOME=/airflow
ENV AIRFLOW_ADMIN_USER=admin
ENV AIRFLOW_ADMIN_PASSWORD=password

# Install Apache Airflow (latest version within constraints)
RUN pip install "apache-airflow==2.7.0" "psycopg2-binary"

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy DAGs, requirements, and plugins
COPY dags/ /airflow/dags/
COPY requirements.txt /airflow/requirements.txt
COPY plugins/ /airflow/plugins/

# Expose the web server port
EXPOSE 8080

# Start Airflow using the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
