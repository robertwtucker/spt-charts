# Document Host

![Version: 0.1.19](https://img.shields.io/badge/Version-0.1.19-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.3.12](https://img.shields.io/badge/AppVersion-0.3.12-informational?style=flat-square)

## TL;DR

```console
$ helm install test-release ./docuhost
```

## Introduction

This [Helm](https://helm.sh) chart installs the Document Host (Docuhost)
service used for temporarily hosting demo documents for retrieval using a
generated link.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.1+

## Installing the Chart

To install the chart with the release name `dev-release`:

```console
$ cd charts
$ helm install dev-release ./docuhost
```

These commands deploy Docuhost on the [Kubernetes](https://kubernetes.io)
cluster in the default configuration. The [Parameters](#parameters) section
lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```console
$ helm uninstall dev-release
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Parameters

| Key                                        | Type   | Default                           | Description                                                                                                                                                                                                                     |
| ------------------------------------------ | ------ | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| affinity                                   | object | `{}`                              | Affinity for pod assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity NOTE: podAffinityPreset, podAntiAffinityPreset, and nodeAffinityPreset will be ignored when set. |
| app.url                                    | string | `"http://localhost/v1/documents"` | Fully-qualified URL to the documents resource (gets prepend to document ID)                                                                                                                                                     |
| autoscaling.enabled                        | bool   | `false`                           | Enable auto-scaling for DocuHost                                                                                                                                                                                                |
| autoscaling.maxReplicas                    | int    | `100`                             | Maximum number of replicas that can be deployed                                                                                                                                                                                 |
| autoscaling.minReplicas                    | int    | `1`                               | Minimum number of replicas to deploy                                                                                                                                                                                            |
| autoscaling.targetCPUUtilizationPercentage | int    | `80`                              | Target CPU utilization (percent) for each replica                                                                                                                                                                               |
| containerPort                              | int    | `8080`                            | DocuHost container port                                                                                                                                                                                                         |
| db.host                                    | string | `"localhost"`                     | Database host                                                                                                                                                                                                                   |
