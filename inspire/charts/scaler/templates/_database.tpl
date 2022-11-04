{{/*
Validates and transcripts Scaler database type
*/}}
{{- define "getScalerDbType" -}}
{{- if eq "postgresql" (.Values.db.type | trim | lower)  }}
PostgreSql
{{- else if eq "mssql" (.Values.db.type | trim | lower) }}
MsSql
{{- else if eq "mysql" (.Values.db.type | trim | lower) }}
Mysql
{{- else if eq "oracle" (.Values.db.type | trim | lower) }}
Oracle
{{- else }}
{{- end }}
{{- end }}

{{/*
Definition of environment variables of database
*/}}
{{- define "scaler.env.database" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $secretMountPath := "/mnt/secret" -}}
{{- $dbPassDefinition := dict "value" .Values.db.pass "source" .Values.db.passSource "mountPath" $secretMountPath "secretName" (printf "%s-scaler-database" $applicationName) "secretKey" "dbPass" "envName" "DB_PASS" "envOnly" true -}}
{{- $dbUserDefinition := dict "value" .Values.db.user "source" .Values.db.userSource "mountPath" $secretMountPath "secretName" (printf "%s-scaler-database" $applicationName) "secretKey" "dbUser" "envName" "DB_USER" "envOnly" true -}}
{{- $dbConnectStringDefinition := dict "value" .Values.db.connectionString "source" .Values.db.connectionStringSource "mountPath" $secretMountPath "secretName" (printf "%s-scaler-database" $applicationName) "secretKey" "dbConnectionString" "envName" "DB_CUSTOM_CONNECTION_STRING" "envOnly" true -}}
{{- $dbDelegated := eq (include "inspire.secret.isDelegated" .Values.db.connectionStringSource) "true" }}
{{- if .Values.db.connectionString | or $dbDelegated }}
{{- include "inspire.secret.asEnv" ($dbConnectStringDefinition) }}
{{- else }}
- name: DB_HOST
  value: {{ .Values.db.host }}
- name: DB_PORT
  value: {{ .Values.db.port | quote }}
- name: DB_NAME
  value: {{ .Values.db.name }}
{{- if eq "oracle" (.Values.db.type | trim | lower) }}
- name: DB_ORACLE_CONN_TYPE
  value: {{ .Values.db.oracleConnectionType }}
{{- end }}
{{- if eq "mssql" (.Values.db.type | trim | lower) }}
- name: DB_MSSQL_CONN_TYPE
  value: {{ .Values.db.mssqlConnectionType }}
- name: DB_MSSQL_INSTANCE_NAME
  value: {{ .Values.db.mssqlInstanceName }}
{{- end }}
{{- end }}
- name: DB_TYPE
  value: {{ required "Scaler database type is not valid" (include "getScalerDbType" . | trim )}}
{{- include "inspire.secret.asEnv" ($dbUserDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbPassDefinition) -}}
{{- end }}
