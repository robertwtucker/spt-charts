{{/*
Expand the name of the chart.
*/}}
{{- define "icm.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "icm.fullname" }}
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
{{- define "icm.chart" }}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "icm.labels" }}
helm.sh/chart: {{ include "icm.chart" . }}
{{ include "icm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "icm.selectorLabels" }}
app.kubernetes.io/name: {{ include "icm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "icm.serviceAccountName" }}
{{- if .Values.serviceAccount.create }}
{{- default (include "icm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return true if a secret object should be created
*/}}
{{- define "icm.createSecret" }}
{{- if not (include "icm.useExistingSecret" .) }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "icm.secretName" }}
{{- if .Values.existingSecret }}
    {{- printf "%s" (tpl .Values.existingSecret $) }}
{{- else }}
    {{- printf "%s" (include "icm.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return true if we should use an existingSecret.
*/}}
{{- define "icm.useExistingSecret" }}
{{- if .Values.existingSecret }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Return the configuration configmap name
*/}}
{{- define "icm.configMapName" }}
{{- if .Values.existingConfigMap }}
    {{- printf "%s" (tpl .Values.existingConfigMap $) }}
{{- else }}
    {{- printf "%s-configuration" (include "icm.fullname" .)  }}
{{- end }}
{{- end }}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "icm.createConfigMap" }}
{{- if empty .Values.existingConfigmap }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Return the proper ICM image name
*/}}
{{- define "icm.image" }}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{/*
Return the ICM environment settings for licensing
*/}}
{{- define "icm.env.license" -}}
- name: CX_LICENSE
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: cx-license
- name: CX_LIC_SERVER
  valueFrom:
    secretKeyRef:
      name: {{ include "icm.secretName" . }}
      key: cx-lic-server
{{- end }}

{{/*
Return the ICM database environment settings
*/}}
{{- define "icm.env.database" -}}
- name: DB_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: db-type
- name: DB_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: db-host
- name: DB_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: db-port
- name: DB_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: db-name
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "icm.secretName" . }}
      key: db-user
- name: DB_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "icm.secretName" . }}
      key: db-password
- name: DB_CONNSTRING_ADD
  valueFrom:
    configMapKeyRef:
      name: {{ include "icm.configMapName" . }}
      key: db-connstring-add
{{- end }}
