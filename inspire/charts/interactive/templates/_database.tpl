{{/*
Definition of environment variables of database
*/}}

{{- define "getInteractiveDbType" -}}
{{- if eq "postgresql" (.Values.db.type | trim | lower) }}
POSTGRESQL
{{- else if eq "mssql" (.Values.db.type | trim | lower) }}
MSSQL
{{- else if eq "microsoftsql" (.Values.db.type | trim | lower) }}
MSSQL
{{- else if eq "oracle" (.Values.db.type | trim | lower) }}
ORACLE
{{- else if eq "hsqldb" (.Values.db.type | trim | lower) }}
HSQLDB
{{- else }}
{{- end }}
{{- end }}

{{- define "interactive.env.database" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $dbPassDefinition := dict "value" .Values.db.pass "source" .Values.db.passSource "secretName" (printf "%s-interactive-database" $applicationName) "secretKey" "dbPass" "envName" "DB_PASS" "envOnly" true -}}
{{- $dbUserDefinition := dict "value" .Values.db.user "source" .Values.db.userSource "secretName" (printf "%s-interactive-database" $applicationName) "secretKey" "dbUser" "envName" "DB_USER" "envOnly" true -}}
- name: DB_TYPE
  value: {{ required "Interactive database type is not valid" (include "getInteractiveDbType" . | trim) }}
- name: DB_HOST
  value: {{ .Values.db.host }}
- name: DB_PORT
  value: {{ .Values.db.port | quote }}
- name: DB_NAME
  value: {{ .Values.db.name }}
{{- $dbDelegated := eq (include "inspire.secret.isDelegated" .Values.db.connectionStringSource) "true" }}
{{- if .Values.db.connectionString | or $dbDelegated }}
{{- $dbConnectStringDefinition := dict "value" .Values.db.connectionString "source" .Values.db.connectionStringSource "secretName" (printf "%s-interactive-database" $applicationName) "secretKey" "dbConnectionString" "envName" "DB_CONNECTION_STRING" "envOnly" true -}}
{{- include "inspire.secret.asEnv" ($dbConnectStringDefinition) }}
{{- else }}
- name: DB_CONNECTION_STRING
  value: ""
{{- end }}
{{- include "inspire.secret.asEnv" ($dbUserDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbPassDefinition) -}}
{{- end }}
