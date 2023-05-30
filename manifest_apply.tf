data "kubectl_file_documents" "provisioner" {
  content = templatefile("k8s/provisioner.yaml", { "cluster_name" : var.cluster_name })
}

data "kubectl_file_documents" "runner-test" {
  content = templatefile("k8s/runner-test.yaml", { "target_repo" : var.target_repo })
}

resource "kubectl_manifest" "provisioner" {
  for_each  = data.kubectl_file_documents.provisioner.manifests
  yaml_body = each.value
  depends_on = [
    helm_release.cert_manager
  ]
}

resource "kubectl_manifest" "runner-test" {
  for_each  = data.kubectl_file_documents.runner-test.manifests
  yaml_body = each.value
  depends_on = [
    helm_release.cert_manager,
    kubectl_manifest.provisioner
  ]
}
