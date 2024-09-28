provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "video_uploader" {
  name             = "video-uploader"
  namespace        = "video-uploader"
  create_namespace = true

  # Assuming that the Helm_Chart folder is at the root of the repository
  chart = "${path.root}/../Helm_Chart"

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "image.tag"
    value = "latest"
  }
}
