terraform {
          required_providers {
            kind = {
              source  = "tehcyx/kind"
              version = "0.2.1"
            }
          }
        }

        resource "kind_cluster" "default" {
          name = "test-cluster"
          kind_config {
            kind = "Cluster"
            api_version = "kind.x-k8s.io/v1alpha4"
            node {
              role = "control-plane"
            }
            node {
              role = "worker"
            }
            node {
              role = "worker"
            }
          }
        }