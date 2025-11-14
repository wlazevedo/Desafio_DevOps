variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Region used for VPC/Subnet"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "Zonal GKE cluster"
}

variable "cluster_name" {
  type    = string
  default = "devops-challenge-cluster"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "ansible_command" {
  type    = string
  default = "cd ../ansible && ansible-playbook -i inventory.ini playbook.yaml"
}
