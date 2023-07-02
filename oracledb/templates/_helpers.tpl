{{/*
Expand the name of the chart.
*/}}
{{- define "oracledb.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
Truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains the chart name it will be used as the full name.
*/}}
{{- define "oracledb.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "oracledb.namespace" -}}
{{- $namespace := default .Release.Namespace .Values.global.namespaceOverride -}}
{{- default $namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "oracledb.labels.standard" -}}
{{- include "common.labels.standard" . -}}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "oracledb.labels.matchLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "oracledb.serviceAccountName" -}}
{{- if empty .Values.existingServiceAccount -}}
{{- include "oracledb.fullname" . -}}
{{- else -}}
{{- .Values.existingServiceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Create the default FQDN for the Oracle DB headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "oracledb.svc.headless" -}}
{{- printf "%s-headless" (include "oracledb.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Oracle Database image name
*/}}
{{- define "oracledb.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper registry Secret names
*/}}
{{- define "oracledb.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}
