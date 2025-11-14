#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -

helm repo add hashicorp https://helm.releases.hashicorp.com >/dev/null 2>&1 || true
helm repo update >/dev/null

helm upgrade --install vault hashicorp/vault \
    -n vault \
    --set "server.dev.enabled=true"

kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=vault -n vault --timeout=300s
