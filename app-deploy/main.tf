provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "video_uploader" {
  name             = "video-uploader"
  namespace        = "video-uploader"
  create_namespace = true
  chart            = "${path.root}/../Helm_Chart"

  values = [
    file("${path.module}/../Helm_Chart/values.yaml")
  ]

  set {
    name  = "image.tag"
    value = "latest"
  }
  timeout {
    install = 600  # Increase to 600 seconds (10 minutes)
  }
}
