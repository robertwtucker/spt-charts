{{/*
Definition of environment variables referencing secrets of Scenario Engine
*/}}
{{- define "scaler.env.sen" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $scalerPassDefinition := dict "value" .Values.global.sen.passOverride "source" .Values.global.sen.passOverrideSource "secretName" (printf "%s-scaler-sen" $applicationName) "secretKey" "pass" "envName" "SCALER_PASSWORD" "envOnly" true "allowEmpty" true -}}
{{- $dbUserDefinition := dict "value" .Values.sen.db.user "source" .Values.sen.db.userSource "secretName" (printf "%s-scaler-sen-database" $applicationName) "secretKey" "dbUser" "envName" "DB_USERNAME" "envOnly" true -}}
{{- $dbPassDefinition := dict "value" .Values.sen.db.pass "source" .Values.sen.db.passSource "secretName" (printf "%s-scaler-sen-database" $applicationName) "secretKey" "dbPass" "envName" "DB_PASSWORD" "envOnly" true -}}
{{- $dbConnectionStringDefinition := dict "value" .Values.sen.db.connectionString "source" .Values.sen.db.connectionStringSource "secretName" (printf "%s-scaler-sen-database" $applicationName) "secretKey" "dbConnectionString" "envName" "DB_JDBC_URL" "envOnly" true -}}
- name: SEN_AUTHORIZATION_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-scaler-authorization-token" $applicationName }}
      key: senAuthorizationToken
- name: SCALER_USER
  value: {{ .Values.global.sen.userOverride | default "sen" | quote }}
{{- include "inspire.secret.asEnv" ($scalerPassDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbUserDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbPassDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbConnectionStringDefinition) -}}
{{- end }}
