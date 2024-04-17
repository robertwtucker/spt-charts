{{/*
Definition of environment variables of icm service
*/}}
{{- define "scaler.env.icm" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $icmPassDefinition := dict "value" .Values.global.scaler.passOverride "source" .Values.global.scaler.passOverrideSource "secretName" (printf "%s-scaler-icm" $applicationName) "secretKey" "pass" "envName" "ICM_PASS" "envOnly" true "allowEmpty" true -}}
- name: ICM_HOST
  value: {{ printf "%s-icm.%s.svc.cluster.local" ($applicationName) (.Release.Namespace) }}
- name: ICM_PORT
  value: {{ .Values.global.icm.portOverride | default "30353" | quote }}
- name: ICM_USER
  value: {{ .Values.global.scaler.userOverride | default "scaler" | quote }}
{{- include "inspire.secret.asEnv" ($icmPassDefinition) -}}
{{- end }}
