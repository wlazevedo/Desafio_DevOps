# Desafio Técnico DevOps

**Infraestrutura Completa em GKE com Terraform, Ansible e GitHub Actions**

[![Infrastructure](https://img.shields.io/badge/Infrastructure-GCP-4285F4?logo=google-cloud)](https://cloud.google.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-GKE-326CE5?logo=kubernetes)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://terraform.io/)
[![CI/CD](https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions)](https://github.com/features/actions)

---

## Índice

- [Visão Geral](#visão-geral)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Arquitetura](#arquitetura)
- [Pré-requisitos](#pré-requisitos)
- [Como Executar](#como-executar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Testes e Validação](#testes-e-validação)
- [Segurança](#segurança)
- [CI/CD](#cicd)

---

## Visão Geral

Este repositório contém uma **infraestrutura completa de DevOps** implementada na Google Cloud Platform (GKE), demonstrando:

- ✅ **Infraestrutura como Código** com Terraform
- ✅ **Automação de Configuração** com Ansible  
- ✅ **Kubernetes de Alta Disponibilidade** (2 nodes)
- ✅ **HTTPS Automático** com Let's Encrypt
- ✅ **Monitoramento Completo** (Prometheus + Grafana + Alertmanager)
- ✅ **Logs Centralizados** (Loki + Promtail)
- ✅ **Gerenciamento de Secrets** (HashiCorp Vault)
- ✅ **CI/CD Automatizado** (GitHub Actions)
- ✅ **Segurança** (Network Policies + RBAC)
- ✅ **Auto-scaling** (HPA)

---

## Tecnologias Utilizadas

### **Infraestrutura**
- Google Cloud Platform
- Terraform v1.6+
- Ansible v2.15+

### **Kubernetes**
- GKE (Google Kubernetes Engine)
- Helm
- Ingress Nginx
- Cert-Manager (Let's Encrypt)

### **Observabilidade**
- Prometheus
- Grafana
- Loki + Promtail

### **Segurança**
- HashiCorp Vault
- Network Policies
- RBAC (Role-Based Access Control)

### **CI/CD**
- GitHub Actions

---

## Arquitetura
```
┌─────────────────────────────────────────────────────────────────┐
│                         INTERNET / USERS                         │
└────────────────────────────┬────────────────────────────────────┘
                             │ HTTPS (443)
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INGRESS NGINX CONTROLLER                      │
│              (Load Balancer + SSL Termination)                   │
│                  Cert-Manager (Let's Encrypt)                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GOOGLE KUBERNETES ENGINE                      │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │           APPLICATION (WhoAmI - 2+ replicas)             │   │
│  │   ┌──────────┐  ┌──────────┐  ┌──────────┐             │   │
│  │   │  Pod 1   │  │  Pod 2   │  │  Pod 3   │   HPA       │   │
│  │   └──────────┘  └──────────┘  └──────────┘             │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              OBSERVABILITY STACK                         │   │
│  │  ┌────────────┐  ┌──────────┐  ┌─────────────────┐     │   │
│  │  │ Prometheus │  │ Grafana  │  │  Alertmanager   │     │   │
│  │  └────────────┘  └──────────┘  └─────────────────┘     │   │
│  │  ┌────────────┐  ┌──────────┐                          │   │
│  │  │    Loki    │  │ Promtail │                          │   │
│  │  └────────────┘  └──────────┘                          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                 SECURITY & SECRETS                       │   │
│  │  ┌────────────┐  ┌──────────────────┐                   │   │
│  │  │   Vault    │  │ Network Policies │                   │   │
│  │  └────────────┘  └──────────────────┘                   │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    NODES (2x)                            │   │
│  │  ┌─────────────────┐      ┌─────────────────┐           │   │
│  │  │   Node 1 (e2)   │      │   Node 2 (e2)   │           │   │
│  │  │  2 vCPU + 4GB   │      │  2 vCPU + 4GB   │           │   │
│  │  └─────────────────┘      └─────────────────┘           │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                             ▲
                             │
                   ┌─────────┴──────────┐
                   │   TERRAFORM (IaC)   │
                   │   ANSIBLE (Config)  │
                   │  GITHUB ACTIONS     │
                   └─────────────────────┘
```

---

## ✅ Requisitos Atendidos

| Requisito | Status | Tecnologia | Observação |
|-----------|--------|------------|------------|
| **Kubernetes HA** | ✅ | GKE (2 nodes) | Alta disponibilidade com múltiplos nodes |
| **HTTPS Automático** | ✅ | Cert-Manager + Let's Encrypt | Certificado válido e renovação automática |
| **Monitoramento** | ✅ | Prometheus + Grafana + Alertmanager | Dashboards e alertas configurados |
| **Logs Centralizados** | ✅ | Loki + Promtail | Agregação de logs dos pods |
| **CI/CD** | ✅ | GitHub Actions | Deploy automático a cada push |
| **Vault** | ✅ | HashiCorp Vault | Gerenciamento de secrets |
| **Segurança** | ✅ | Network Policies + RBAC | Isolamento de rede e controle de acesso |
| **Escalabilidade** | ✅ | HPA (Horizontal Pod Autoscaler) | Auto-scaling baseado em CPU |
| **IaC** | ✅ | Terraform | Infraestrutura reproduzível |
| **Automação** | ✅ | Ansible | Configuração automatizada |

---

## Pré-requisitos

### **Ferramentas Necessárias**
```bash
# Terraform
terraform --version  # >= 1.6.0

# Google Cloud SDK
gcloud --version

# Kubectl
kubectl version --client

# Ansible
ansible --version  # >= 2.15

# Helm (opcional)
helm version
```

### **Conta GCP**

- Conta Google Cloud ativa
- Projeto GCP criado
- APIs habilitadas:
  - Kubernetes Engine API
  - Compute Engine API
- Service Account com permissões:
  - `roles/container.admin`
  - `roles/compute.admin`

---

## Como Executar

### **Opção 1: Deploy Automático (Recomendado)**
```bash
# 1. Clonar repositório
git clone https://github.com/wlazevedo/DevOps_Desafio.git
cd DevOps_Desafio

# 2. Configurar credenciais GCP
gcloud auth login
gcloud config set project SEU-PROJECT-ID

# 3. Provisionar infraestrutura
cd terraform
terraform init
terraform apply -auto-approve

# 4. Configurar kubectl
gcloud container clusters get-credentials devops-challenge-cluster \
  --zone us-central1-a \
  --project SEU-PROJECT-ID

# 5. Verificar
kubectl get nodes
kubectl get pods -A

# 6. Acessar aplicação
curl https://SEU-DOMINIO
```

### **Opção 2: Deploy com Ansible, caso seja necessário por conta de algum manifest que não foi aplicado**
```bash
# Após terraform apply é criado os recursos na GCP e o terraform também roda o playbook com os manifests (path e execução do playbook.yaml dentro do main.tf). Caso queira forçar algum manifest não executado, rode os comandos a seguir:
cd ../ansible
ansible-playbook -i inventory/hosts playbook.yaml
```

### **Opção 3: Deploy via CI/CD**
```bash
# Configurar secrets no GitHub:
# - GCP_SA_JSON (Service Account JSON)

# Fazer push para main
git add .
git commit -m "deploy: initial setup"
git push origin main

# Pipeline executa automaticamente
```

---

## Estrutura do Projeto
```
devops-challenge/
├── README.md                          # Este arquivo
├── .gitignore                         # Arquivos ignorados
├── .github/
│   └── workflows/
│       └── deploy.yml                 # Pipeline CI/CD
├── terraform/
│   ├── main.tf                        # Configuração principal
│   ├── variables.tf                   # Variáveis
│   ├── outputs.tf                     # Outputs
│   └── providers.tf                   # Providers GCP
├── ansible/
│   ├── playbook.yaml                  # Playbook principal
│   ├── inventory/
│   │   └── hosts                      # Inventário
│   └── roles/                         # Roles customizadas
├── k8s/
│   ├── namespace.yaml                 # Namespace da aplicação
│   ├── deployment.yaml                # Deployment WhoAmI
│   ├── service.yaml                   # Service
│   ├── ingress.yaml                   # Ingress + TLS
│   └── hpa.yaml                       # Horizontal Pod Autoscaler
├── monitoring/
│   ├── dashboards/                    # Dashboards Grafana
│   ├── alerts/                        # Regras de alerta
│   └── loki/                          # Configuração Loki
├── logging/
│   └── promtail-config.yaml           # Configuração Promtail
├── security/
│   ├── network-policy.yaml            # Network Policies
│   └── vault/                         # Configurações Vault
├── health/
│   └── health-check.sh                # Script de health check
└── docs/
    ├── arquitetura.md                 # Documentação da arquitetura
    ├── setup-guide.md                 # Guia de instalação
    └── troubleshooting.md             # Solução de problemas
```

---

## Testes e Validação

### **Teste 1: Aplicação funcionando**
```bash
# Verificar pods
kubectl get pods -n devops-challenge

# Resultado esperado: 2+ pods Running
# whoami-xxx  1/1  Running
```

### **Teste 2: HTTPS funcionando**
```bash
# Testar certificado SSL
curl -v https://devops-walax.ddns.net

# Resultado esperado:
# ✓ SSL certificate verify ok
# ✓ HTTP/2 200
```

### **Teste 3: Load Balancing**
```bash
# Ver hostnames diferentes
for i in {1..10}; do 
  curl -s https://devops-walax.ddns.net | grep Hostname
done

# Resultado esperado: Hostnames alternando entre pods
```

### **Teste 4: Auto-scaling (HPA)**
```bash
# Ver estado do HPA
kubectl get hpa -n devops-challenge

# Gerar carga
kubectl run load-generator --image=busybox --rm -it -- /bin/sh
while true; do wget -q -O- http://whoami.devops-challenge.svc.cluster.local; done

# Observar escalando
watch kubectl get hpa,pods -n devops-challenge
```

### **Teste 5: Alta Disponibilidade**
```bash
# Deletar um pod
kubectl delete pod -n devops-challenge -l app=whoami --force

# Verificar recriação automática
kubectl get pods -n devops-challenge -w

# Resultado esperado: Pod recriado em ~10s
```

---

## 📊 Monitoramento

### **Acessar Grafana**
```bash
# Port-forward
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80

# Abrir navegador: http://localhost:3000
# User: admin
# Password: prom-operator
```

### **Dashboards Disponíveis**

- **Kubernetes / Compute Resources / Cluster**: Visão geral do cluster
- **Kubernetes / Compute Resources / Namespace (Pods)**: Métricas por namespace
- **Kubernetes / Networking / Cluster**: Tráfego de rede
- **Node Exporter / Nodes**: Métricas de hardware dos nodes
- **Nginx Ingress Controller**: Métricas do Ingress

### **Acessar Prometheus**
```bash
kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 9090:9090
# Abrir: http://localhost:9090
```

### **Consultar Logs (Loki)**
```bash
# No Grafana → Explore → Datasource: Loki

# Queries úteis:
{namespace="devops-challenge"}
{namespace="devops-challenge"} |= "error"
{namespace="devops-challenge", app="whoami"}
```

---

## Segurança

### **Network Policies**
```bash
# Ver policies aplicadas
kubectl get networkpolicy -n devops-challenge

# Política: Apenas Ingress e Monitoring podem acessar aplicação
```

### **RBAC**
```bash
# Ver roles e bindings
kubectl get roles,rolebindings -n devops-challenge
```

### **Vault**
```bash
# Acessar Vault
kubectl port-forward -n vault svc/vault 8200:8200

# Abrir: http://localhost:8200
# Token root: ver em kubectl logs vault-0 -n vault
```

### **Secrets**
```bash
# Ver secrets (sem expor valores)
kubectl get secrets -n devops-challenge
```

---

## CI/CD

### **Pipeline GitHub Actions**

O pipeline é disparado automaticamente a cada push na branch `main`.

**Etapas:**

1. Checkout do código
2. Autenticação no GCP
3. Configuração do kubectl
4. Aplicação de dashboards e alertas
5. Health checks
6. Verificação de status

**Ver pipeline:**
```
GitHub → Actions → Ver último workflow
```

**Testar pipeline:**
```bash
Run workflow - workflow dispatch 
```
---

## Fontes e Referências para realizar o projeto 

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [Prometheus Community](https://prometheus.io/community/)
- [Grafana Labs](https://grafana.com/)
- [Vault HashiCorp Dev Mode](https://developer.hashicorp.com/vault)
- [Cert-manager](https://cert-manager.io/docs/getting-started/)
- [Kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
- [Promtail + Loki](https://grafana.com/docs/loki/latest/)

---
