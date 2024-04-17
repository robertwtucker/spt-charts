{{/*
Validates and transcripts ICM database type
*/}}
{{- define "getIcmDbType" -}}
{{- if eq "postgresql" (.Values.db.type | trim | lower) }}
PostgreSQL
{{- else if eq "mssql" (.Values.db.type | trim | lower) }}
MsSQL
{{- else if eq "microsoftsql" (.Values.db.type | trim | lower) }}
MicrosoftSQL
{{- else if eq "sqlazure" (.Values.db.type | trim | lower) }}
SQLAzure
{{- else if eq "mysql" (.Values.db.type | trim | lower) }}
MySQL
{{- else if eq "oracle" (.Values.db.type | trim | lower) }}
Oracle
{{- else if eq "db2" (.Values.db.type | trim | lower) }}
DB2
{{- else }}
{{- end }}
{{- end }}

{{/*
Definition of environment variables of database
*/}}
{{- define "icm.env.database" -}}
{{- $connectionStringDelegated := eq (include "inspire.secret.isDelegated" .Values.db.connectionStringSource) "true" }}
{{- if (or .Values.db.connectionString $connectionStringDelegated) | not }}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $secretMountPath := "/mnt/secret" -}}
{{- $dbPassDefinition := dict "value" .Values.db.pass "source" .Values.db.passSource "mountPath" $secretMountPath "secretName" (printf "%s-icm-database" $applicationName) "secretKey" "dbPass" "envName" "DB_PASS" "envOnly" true -}}
{{- $dbUserDefinition := dict "value" .Values.db.user "source" .Values.db.userSource "mountPath" $secretMountPath "secretName" (printf "%s-icm-database" $applicationName) "secretKey" "dbUser" "envName" "DB_USER" "envOnly" true -}}
- name: DB_TYPE
  value: {{ required "ICM database type is not valid" (include "getIcmDbType" . | trim) }}
- name: DB_CONNSTRING_ADD
  value: {{ .Values.db.connectionStringAdd }}
- name: DB_HOST
  value: {{ .Values.db.host }}
- name: DB_PORT
  value: {{ .Values.db.port | quote }}
- name: DB_NAME
  value: {{ .Values.db.name }}
{{- include "inspire.secret.asEnv" ($dbUserDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbPassDefinition) -}}
{{- end }}
{{- $connectionStringDefinition := dict "source" .Values.db.connectionStringSource "secretKey" "dbConnectionString" "mountPath" "/opt/Quadient/secret" "envFileName" "DB_CONNECTION_STRING_FILE" -}}
{{- include "inspire.secret.asFilePointer" $connectionStringDefinition }}
{{- end }}
