#!/bin/bash

INGRESS_HOST="devops-walax.ddns.net"

echo "Health Check - Whoami"
echo "----------------------"

echo "Testando HTTP..."
curl -I http://$INGRESS_HOST

echo ""
echo "Testando HTTPS..."
curl -I https://$INGRESS_HOST

echo ""
echo "Verificando Pods..."
kubectl get pods -n devops-challenge
