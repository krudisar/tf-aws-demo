variable "agent_count" {
    default = 3
}

variable "dns_prefix" {
    default = "k8stest"
}

variable cluster_name {
    default = "k8stest-tf"
}

variable resource_group_name {
    default = "azure-k8stest"
}

variable location {
    default = "West Europe"
}

variable client_secret {
}

variable client_id {
}

