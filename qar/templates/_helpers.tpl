{{/*
Expand the name of the chart.
*/}}
{{- define "qar.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
Truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains the chart name it will be used as the full name.
*/}}
{{- define "qar.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "qar.namespace" -}}
{{- $namespace := default .Release.Namespace .Values.global.namespaceOverride -}}
{{- default $namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "qar.labels.standard" -}}
{{- include "common.labels.standard" . -}}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "qar.labels.matchLabels" -}}
{{- include "common.labels.matchLabels" . -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "qar.serviceAccountName" -}}
{{- if empty .Values.existingServiceAccount }}
{{- include "qar.fullname" . }}
{{- else }}
{{- .Values.existingServiceAccount }}
{{- end }}
{{- end -}}
