# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Overview

This is a Helm chart library for deploying Quadient Inspire and related demo/support applications to Kubernetes. Each top-level directory is an independent Helm chart.

## Charts

- **inspire** — The main Quadient Inspire suite. An umbrella chart with four subcharts: `automation`, `icm`, `interactive`, `scaler` (each under `inspire/charts/`). Version follows `{upstream}-spt-{local}` convention.
- **docuhost** — Document Host demo service. Depends on Bitnami MongoDB.
- **qar** — Quadient Archive. Depends on Bitnami common and the `oracledb` chart (from `oci://registry.sptcloud.com/charts`).
- **oracledb** — Oracle Database. Supports standalone and replicated modes (separate template directories). Depends on Bitnami common.
- **registry** — Docker registry.
- **hello** — Minimal chart for testing cluster connectivity.

## Common Commands

```bash
# Lint a chart
helm lint <chart-dir>

# Template render (dry-run) to inspect output
helm template test-release <chart-dir> -f <chart-dir>/values.yaml

# Install/upgrade a release
helm upgrade --install <release-name> <chart-dir>

# Update chart dependencies (e.g. for docuhost, qar, oracledb)
helm dependency update <chart-dir>
```

## Conventions

- All charts use `apiVersion: v2` and `type: application`.
- Each chart follows standard Helm structure: `Chart.yaml`, `values.yaml`, `templates/`, `templates/_helpers.tpl`.
- Helper templates in `_helpers.tpl` are namespaced by chart name (e.g. `docuhost.fullname`, `qar.labels`).
- `config.json` at repo root configures the Bitnami `readme-generator` tool for generating parameter docs from `values.yaml` comments. Parameter comments use `## @param` / `## @section` annotations.
- Container images are hosted on `registry.sptcloud.com`. Image signatures are verified with `cosign.pub`.
- Branch naming for contributions: `chart/<ChartName>`.
- Charts with external dependencies use Bitnami charts from `oci://registry-1.docker.io/bitnamicharts` or OCI charts from `registry.sptcloud.com/charts`.
