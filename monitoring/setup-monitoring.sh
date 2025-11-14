#!/usr/bin/env bash
set -euo pipefail

# Path
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Namespaces
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace logging --dry-run=client -o yaml | kubectl apply -f -

# Helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo add grafana https://grafana.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update >/dev/null

# Prometheus + Grafana
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  -f "$SCRIPT_DIR/values-prometheus.yaml" \
  --wait

# Loki
helm upgrade --install loki grafana/loki-stack \
  --namespace logging \
  -f "$SCRIPT_DIR/values-grafana.yaml" \
  --set grafana.enabled=false \
  --set promtail.enabled=true \
  --wait

# esperar pods
kubectl -n monitoring wait --for=condition=Ready pod -l app.kubernetes.io/name=grafana --timeout=300s || true
kubectl -n logging wait --for=condition=Ready pod -l app.kubernetes.io/name=loki --timeout=300s || true
