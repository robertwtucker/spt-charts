# Hello

Hello is a simple deployment for verifying connectivity to a Kubernetes cluster.

## TL;DR

```console
$ helm install hello ./hello
```

## Introduction

This chart deploys an NGINX webserver that serves a simple page containing its hostname, IP address and port as wells as the request URI and the local time of the webserver.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- TBD

## Installing the Chart

To install the chart with the release name `hello`:

```console
$ cd charts
$ helm install hello ./hello
```

These commands deploy Hello on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `hello` deployment:

```console
$ helm uninstall hello
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

TBD