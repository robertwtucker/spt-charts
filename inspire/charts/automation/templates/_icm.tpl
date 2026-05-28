{{/*
Definition of environment variables of icm service
*/}}
{{- define "automation.env.icm" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $icmPassDefinition := dict "value" .Values.global.automation.passOverride "source" .Values.global.automation.passOverrideSource "secretName" (printf "%s-automation-icm" $applicationName) "secretKey" "pass" "envName" "SECURITY_ICM_SERVICE_PASSWORD" "envOnly" true "allowEmpty" true -}}
- name: SECURITY_ICM_HOST
  value: {{ (include "inspire.env.icm.host" .) | quote }}
- name: SECURITY_ICM_PORT
  value: {{ (include "inspire.env.icm.port" .) | quote }}
- name: SECURITY_ICM_SERVICE_USER
  value: {{ (include "inspire.automation.env.icm.user" .) | quote }}
{{- include "inspire.secret.asEnv" ($icmPassDefinition) }}
- name: SECURITY_ICM_ADMINISTRATOR_GROUP
  value: {{ .Values.securityIcmAdministratorGroup }}
{{- end }}