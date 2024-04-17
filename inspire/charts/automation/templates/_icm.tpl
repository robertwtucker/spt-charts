{{/*
Definition of environment variables of icm service
*/}}
{{- define "automation.env.icm" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $icmPassDefinition := dict "value" .Values.global.automation.passOverride "source" .Values.global.automation.passOverrideSource "secretName" (printf "%s-automation-icm" $applicationName) "secretKey" "pass" "envName" "SECURITY_ICM_SERVICE_PASSWORD" "envOnly" true "allowEmpty" true -}}
- name: SECURITY_ICM_HOST
  value: {{ include "inspire.applicationName" . }}-icm.{{ .Release.Namespace }}.svc.cluster.local
- name: SECURITY_ICM_PORT
  value: {{ .Values.global.icm.portOverride | default "30353" | quote }}
- name: SECURITY_ICM_SERVICE_USER
  value: {{ .Values.global.automation.userOverride | default "automation" | quote }}
{{- include "inspire.secret.asEnv" ($icmPassDefinition) }}
- name: SECURITY_ICM_ADMINISTRATOR_GROUP
  value: {{ .Values.securityIcmAdministratorGroup }}
{{- end }}