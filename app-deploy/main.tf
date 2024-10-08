provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

variable "image_tag" {
  type    = string
  default = "latest"  
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
    value = var.image_tag
  } 
}
