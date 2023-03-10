variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "cluster_name" {
  default = "gke"
}

variable "monitoring_components" {
  default = ["SYSTEM_COMPONENTS"]

}

variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
  
}

variable "initial_node_count" {
  default = 1
}

variable "max_node_count" {
  default = 5
  
}

variable "min_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "env" {
}