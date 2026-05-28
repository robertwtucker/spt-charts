{{/*
Definition of environment variables of icm service
*/}}
{{- define "scaler.env.icm" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $icmPassDefinition := dict "value" .Values.global.scaler.passOverride "source" .Values.global.scaler.passOverrideSource "secretName" (printf "%s-scaler-icm" $applicationName) "secretKey" "pass" "envName" "ICM_PASS" "envOnly" true "allowEmpty" true -}}
- name: ICM_HOST
  value: {{ (include "inspire.env.icm.host" .) | quote }}
- name: ICM_PORT
  value: {{ (include "inspire.env.icm.port" .) | quote }}
- name: ICM_USER
  value: {{ (include "inspire.scaler.env.icm.user" .) | quote }}
{{- include "inspire.secret.asEnv" ($icmPassDefinition) -}}
{{- end }}