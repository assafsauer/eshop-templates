#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

echo "-----------------------------------------------"
echo "-- Start testing {{ cookiecutter.component.name }}"
echo "-----------------------------------------------"

check_url_call () {
  echo "Checking url $1"
  http_response=$(curl --silent --output /dev/null --write-out "%{http_code}" --location $1)
  if [ $http_response != "200" ]; then
      echo -e "${RED}Got response $http_response${NOCOLOR}"
  else
      echo -e "${GREEN}Success${NOCOLOR}"
  fi
}

{% if cookiecutter.component.attributes.service_type == 'ClusterIP' -%}
# Local IP
export SERVICE_IP=127.0.0.1

# Start kubectl port-forward command in the background
kubectl port-forward --namespace {{ cookiecutter.component.attributes.namespace }} svc/{{ cookiecutter.component.name }} 8080:8080 &
# Save the PID of the kubectl port-forward command
PORT_FORWARD_PID=$!
# Give it some time to establish the connection
sleep 5

{% elif cookiecutter.component.attributes.service_type == "LoadBalancer" -%}
# External IP
export SERVICE_IP=$(kubectl get svc --namespace {{ cookiecutter.component.attributes.namespace }} {{ cookiecutter.component.name }} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
{% endif -%}

# Health endpoints
check_url_call "http://$SERVICE_IP:8080/actuator/health/liveness"
check_url_call "http://$SERVICE_IP:8080/actuator/health/readiness"

# App endpoints
check_url_call "http://$SERVICE_IP:8080/greeting"
check_url_call "http://$SERVICE_IP:8080/greeting?name=Stacktic"
{% if cookiecutter.__rel_db != '' -%}
check_url_call "http://$SERVICE_IP:8080/greeting-sql/1"
{% endif -%}
{% if cookiecutter.__rabbitmq != '' -%}
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"id":1,"content":"Hello from RabbitMQ!"}' \
  http://$SERVICE_IP:8080/greeting-rabbitmq
check_url_call "http://$SERVICE_IP:8080/greeting-rabbitmq"
{% endif -%}
{% if cookiecutter.__mongodb != '' -%}
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"id":1,"content":"Hello from MongoDB!"}' \
  http://$SERVICE_IP:8080/greeting-mongodb
check_url_call "http://$SERVICE_IP:8080/greeting-mongodb"
{% endif -%}

{% if cookiecutter.component.attributes.service_type == 'ClusterIP' -%}
# Stop kubectl port-forward
kill ${PORT_FORWARD_PID}
{% endif -%}
