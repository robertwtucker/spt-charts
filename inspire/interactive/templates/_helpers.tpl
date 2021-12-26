{{/*
Expand the name of the chart.
*/}}
{{- define "interactive.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "interactive.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "interactive.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "interactive.labels" -}}
helm.sh/chart: {{ include "interactive.chart" . }}
{{ include "interactive.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "interactive.selectorLabels" -}}
app.kubernetes.io/name: {{ include "interactive.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "interactive.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "interactive.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return true if a secret object should be created
*/}}
{{- define "interactive.createSecret" }}
{{- if empty .Values.existingSecret }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "interactive.secretName" }}
{{- if .Values.existingSecret }}
    {{- printf "%s" (tpl .Values.existingSecret $) }}
{{- else }}
    {{- printf "%s" (include "interactive.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return true if a ConfigMap object should be created
*/}}
{{- define "interactive.createConfigMap" }}
{{- if empty .Values.existingConfigMap }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Return the configuration configmap name
*/}}
{{- define "interactive.configMapName" }}
{{- if .Values.useExistingConfigMap }}
    {{- printf "%s" (tpl .Values.existingConfigMap $) }}
{{- else }}
    {{- printf "%s-configuration" (include "interactive.fullname" .)  }}
{{- end }}
{{- end }}

{{/*
Return the proper Interactive image name
*/}}
{{- define "interactive.image" }}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{/*
Return the proper IPS image name
*/}}
{{- define "ips.image" }}
{{- printf "%s/%s:%s" .Values.ips.image.registry .Values.ips.image.repository (.Values.ips.image.tag | default .Chart.AppVersion) }}
{{- end }}
