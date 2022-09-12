{{/*
Definition of environment variables of icm service
*/}}
{{- define "interactive.env.icm" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $icmPassDefinition := dict "value" .Values.global.interactive.passOverride "source" .Values.global.interactive.passOverrideSource "secretName" (printf "%s-interactive-icm" $applicationName) "secretKey" "pass" "envName" "ICM_PASS" "envOnly" true "allowEmpty" true -}}
- name: ICM_HOST
  value: {{ include "inspire.applicationName" . }}-icm.{{ .Release.Namespace }}.svc.cluster.local
- name: ICM_PORT
  value: {{ .Values.global.icm.portOverride | default "30353" | quote }}
- name: ICM_USER
  value: {{ .Values.global.interactive.userOverride | default "system" }}
{{- include "inspire.secret.asEnv" ($icmPassDefinition) }}
{{- end }}
