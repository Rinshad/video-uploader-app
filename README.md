## Application pipeline
The Github workflow pipeline contains 2 job


 1. build-and-push => This job will build, scan and push images
 2. provision-kind-cluster => This job will provision a kind cluster and deploy the video-uploader application to the same cluster using Helm chart

## Application deployment
To deploy a new version of the application, make the changes in the code and push to repository, this will trigger the pipeline and the pipeline will perform the application containirization and deployment to the Kind cluster.

## Improvement
Application deployment can be made to perisistent with the help of statefulset deployment. Statefulset helps application to use the same storage in the event of a pod restart as well a grace shutdown of the application (or pods). 

The terminationGracePeriodSeconds in the Stateful give a session time to users to complete the file upload.

```shell
spec:
  terminationGracePeriodSeconds: 30
  containers:
  - name: api
```

## Kind cluster deployment
Terraform used to provision the the kind cluster, 1 controlplane node and 2 worker node. Also, Nginx Ingress port maping also done as part othe cluster provisioning.



### Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Installation
If you're using an M1/2 Mac OS, please consider creating this environment variable:
`CPU_ARCH=arm64`

```shell
docker compose build
docker compose run api rake db:setup
docker compose run api rake db:migrate
```

## Usage
### Tests

```shell
docker compose run api rake db:migrate RAILS_ENV=test
docker compose run api rspec
```

### Run

```shell
docker compose up
open http://localhost:8000
```
