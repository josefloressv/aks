output "resource_group_name" {
  value = data.azurerm_resource_group.guru.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.guru.location
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.guru.name
}