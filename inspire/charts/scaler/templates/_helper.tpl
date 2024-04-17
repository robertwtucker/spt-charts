{{/*
Computes backup count according to given maximum number of nodes
*/}}
{{- define "computeBackupCount" -}}
{{- $replicas := index . "replicas" -}}
{{ max 1 (min 6 (add (div (add $replicas (mod $replicas 2)) 2) -1)) }}
{{- end }}

{{/*
Gets the Scaler's custom logger config ConfigMap name.
*/}}
{{- define "getCustomLoggerConfigCM" -}}
{{- if .Values.customLoggerConfigCM -}}
  {{- .Values.customLoggerConfigCM }}
{{- else -}}
  {{- include "inspire.applicationName" . }}-scaler-custom-logger-config
{{- end -}}
{{- end -}}

{{/*
Gets the Scenario engine's custom logger config ConfigMap name.
*/}}
{{- define "getSenCustomLoggerConfigCM" -}}
{{- if .Values.sen.customLoggerConfigCM -}}
  {{- .Values.sen.customLoggerConfigCM }}
{{- else -}}
  {{- include "inspire.applicationName" . }}-scaler-sen-custom-logger-config
{{- end -}}
{{- end -}}