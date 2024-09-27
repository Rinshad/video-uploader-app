terraform {
  required_providers {
    kind = {
      source  = "kind-io/kind"
      version = "~> 0.5.0"  
    }
  }
}

provider "kind" {}

resource "kind_cluster" "my_cluster" {
  name = "video-cluster"

  node {
    role = "control-plane"

    kubeadm_config_patches = <<EOF
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    node-labels: "ingress-ready=true"
EOF

    extra_port_mappings {
      container_port = 80
      host_port      = 80
      protocol       = "TCP"
    }

    extra_port_mappings {
      container_port = 443
      host_port      = 443
      protocol       = "TCP"
    }
  }

  node {
    role = "worker"
  }

  node {
    role = "worker"
  }
}
