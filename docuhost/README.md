# Document Host

![Version badge](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Frobertwtucker%2Fspt-charts%2Fmaster%2Fdocuhost%2FChart.yaml&query=%24.version&label=Version)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion badge](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Frobertwtucker%2Fspt-charts%2Fmaster%2Fdocuhost%2FChart.yaml&query=%24.appVersion&label=AppVersion&link=https%3A%2F%2Fgithub.com%2Frobertwtucker%2Fdocument-host)

## TL;DR

```console
helm install test-release ./docuhost
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
cd charts
helm install dev-release ./docuhost
```

These commands deploy Docuhost on the [Kubernetes](https://kubernetes.io)
cluster in the default configuration. The [Parameters](#parameters) section
lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `dev-release` deployment:

```console
helm uninstall dev-release
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

## License

Copyright (c) 2022 Quadient Group AG and distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [Helm](https://helm.sh)
- [Bitnami](https://bitnami.com/)
