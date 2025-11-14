#!/bin/bash

echo "Health Check - Whoami"

INGRESS_HOST="devops-walax.ddns.net"

echo "Testando HTTP..."
curl -s -o /dev/null -w "%{http_code}" http://$INGRESS_HOST

echo "Testando HTTPS..."
curl -s -o /dev/null -w "%{http_code}" https://$INGRESS_HOST

echo "Testando Readiness..."
kubectl get pods -n devops-challenge -o json \
  | jq '.[].status.conditions[] | select(.type=="Ready")'
