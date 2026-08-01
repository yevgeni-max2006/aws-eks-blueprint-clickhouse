
variable "name" {
  description = "The name of the service/ingress"
  type        = string
  default     = "minio-console"
}

variable "namespace" {
  description = "Namespace where the ingress and service are deployed"
  type        = string
  default     = "default"
}

variable "host" {
  description = "Hostname for ingress"
  type        = string
  default     = "s3-data.appflex.io"
}

variable "tls_secret_name" {
  default = "appflex"
}

variable "service_port" {
  description = "Port of the backend service"
  type        = number
  default     = "9001"
}

