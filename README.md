# Video Uploader Application CI/CD

  

## Introduction

This repository contains the continuous integration and deployment pipeline for the Video Uploader application using GitHub Actions.

  

## Table of Contents

- [CI/CD Pipeline](#cicd-pipeline)

- [New Version Deployment](#new-version-deployment)

- [Improvements](#improvements)

- [Kind Cluster Deployment](#kind-cluster-deployment)

- [Code Scanning](#code-scanning)

- [Container Image Scanning](#container-image-scanning)

- [Development and Testing](#development-and-testing)

- [Prerequisites](#prerequisites)

- [Installation](#installation)

- [Usage](#usage)

  

## CI/CD Pipeline

The GitHub workflow pipeline consists of four main jobs:

  

1.  **lint-and-test**: Performs lint testing and caches dependencies.

2.  **build-scan-push**: Conducts code scanning using SonarQube Cloud, containerizes the application using Docker Buildx, and pushes to the DockerHub repository.

3.  **deploy**: Provisions a Kind cluster (1 control plane node and 2 worker nodes) using Terraform and deploys the application using Helm charts.

4.  **notify**: Sends deployment status notifications (Failed or Successful) to the configured Slack channel.

  

## New Version Deployment

To deploy a new version of the application:

1. Clone the repository

2. Make necessary changes to the code

3. Push changes to the master branch

The pipeline will automatically handle testing, building, and deployment of the new version.

  

## Improvements

- Application deployment can be made persistent using StatefulSet deployment.

- StatefulSet ensures the application uses the same storage in the event of a pod restart and allows for graceful shutdown.

- Example of graceful shutdown configuration:

```yaml

spec:
terminationGracePeriodSeconds: 30
containers:
- name: api
```
## Kind Cluster Deployment

Terraform is used to provision the Kind cluster with 1 control plane node and 2 worker nodes.

Nginx Ingress port mapping is configured as part of the cluster provisioning.
 

## Code Scanning
SonarQube Cloud is integrated into the GitHub pipeline for application code scanning.

[SonarCloud Project Link](https://sonarcloud.io/organizations/video-uploader/projects)

  

## Container Image Scanning

Trivy, a comprehensive security scanner for container images, is integrated into the GitHub pipeline to identify vulnerabilities, misconfigurations, and other security issues in Docker images.

  

## Development and Testing

  

### Prerequisites

- Docker
- Docker Compose 

### Installation

For M1/M2 Mac OS users, set the following environment variable:

  

```shell
export  CPU_ARCH=arm64
```

then  run:
```shell
docker compose build
docker compose run api rake db:setup
docker compose run api rake db:migrate
```
Running Tests
```shell
docker  compose  run  api  rake  db:migrate  RAILS_ENV=test
docker  compose  run  api  rspec
```
Running  the  Application
```shell
docker compose up
```
Open the application in your browser:
```shell
open  http://localhost:8000
```
