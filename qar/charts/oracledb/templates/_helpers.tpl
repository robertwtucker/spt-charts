{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "oracledb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the default FQDN for the Oracle DB headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "oracledb.svc.headless" -}}
{{- printf "%s-oracledb-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}
