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

{{/*
Return the Interactive environment settings for licensing
*/}}
{{- define "interactive.env.license" -}}
- name: CX_LICENSE
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: cx-license
- name: CX_LIC_SERVER
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: cx-lic-server
{{- if .Values.license.server2 }}
- name: CX_LIC_SERVER2
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: cx-lic-server2
{{- end }}
{{- end }}

{{/*
Return the environment settings for the Interactive database
*/}}
{{- define "interactive.env.db" -}}
- name: DB_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: db-type
- name: DB_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: db-host
- name: DB_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: db-port
- name: DB_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: db-name
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: db-user
- name: DB_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: db-password
{{- end }}

{{/*
Return the Interactive environment settings for ICM
*/}}
{{- define "interactive.env.icm" -}}
- name: ICM_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: icm-host
- name: ICM_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: icm-port
- name: ICM_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: icm-user
- name: ICM_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: icm-password
- name: ICM_ROOT
  valueFrom:
    secretKeyRef:
      name: {{ include "interactive.secretName" . }}
      key: icm-root
{{- end }}

{{/*
Return the Interactive environment settings for IPS
*/}}
{{- define "interactive.env.ips" -}}
- name: IPS_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: ips-host
- name: IPS_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ include "interactive.configMapName" . }}
      key: ips-port
{{- end }}
