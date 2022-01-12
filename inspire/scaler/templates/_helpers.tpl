{{/*
Expand the name of the chart.
*/}}
{{- define "scaler.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "scaler.fullname" -}}
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
{{- define "scaler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "scaler.labels" -}}
helm.sh/chart: {{ include "scaler.chart" . }}
{{ include "scaler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "scaler.selectorLabels" -}}
app.kubernetes.io/name: {{ include "scaler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "scaler.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "scaler.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return true if a secret object should be created
*/}}
{{- define "scaler.createSecret" }}
{{- if empty .Values.existingSecret }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Get the password secret.
*/}}
{{- define "scaler.secretName" }}
{{- if .Values.existingSecret }}
    {{- printf "%s" (tpl .Values.existingSecret $) }}
{{- else }}
    {{- printf "%s" (include "scaler.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Return true if a ConfigMap object should be created
*/}}
{{- define "scaler.createConfigMap" }}
{{- if empty .Values.existingConfigMap }}
    {{- true }}
{{- end }}
{{- end }}

{{/*
Return the configuration configmap name
*/}}
{{- define "scaler.configMapName" }}
{{- if .Values.useExistingConfigMap }}
    {{- printf "%s" (tpl .Values.existingConfigMap $) }}
{{- else }}
    {{- printf "%s-configuration" (include "scaler.fullname" .)  }}
{{- end }}
{{- end }}

{{/*
Return the proper Scaler image name
*/}}
{{- define "scaler.image" }}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{/*
Return the proper IPS image name
*/}}
{{- define "ips.image" }}
{{- printf "%s/%s:%s" .Values.ips.image.registry .Values.ips.image.repository (.Values.ips.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{/*
Return the Scaler environment settings for licensing
*/}}
{{- define "scaler.env.license" -}}
- name: CX_LICENSE
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: cx-license
- name: CX_LIC_SERVER
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: cx-lic-server
{{- if .Values.license.server2 }}
- name: CX_LIC_SERVER2
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: cx-lic-server2
{{- end }}
{{- end }}

{{/*
Return the environment settings for the Scaler database
*/}}
{{- define "scaler.env.db" -}}
- name: DB_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: db-type
- name: DB_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: db-host
- name: DB_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: db-port
- name: DB_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: db-name
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: db-user
- name: DB_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: db-password
{{- end }}

{{/*
Return the Scaler environment settings for ICM
*/}}
{{- define "scaler.env.icm" -}}
- name: ICM_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: icm-host
- name: ICM_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "scaler.configMapName" . }}
      key: icm-port
- name: ICM_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: icm-user
- name: ICM_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "scaler.secretName" . }}
      key: icm-password
{{- end }}
