{{/*
Validates and transcripts Automation database type
*/}}
{{- define "getAutomationDbType" -}}
{{- if eq "postgresql" (.Values.db.type | trim | lower)  }}
PostgreSQL
{{- else if eq "mssql" (.Values.db.type | trim | lower) }}
MSSQL
{{- else if eq "mysql" (.Values.db.type | trim | lower) }}
MySQL
{{- else if eq "oracle thin" (.Values.db.type | trim | lower) }}
Oracle Thin
{{- else }}
{{- end }}
{{- end }}

{{/*
Definition of environment variables of database
*/}}
{{- define "automation.env.database" -}}
- name: DB_TYPE
  value: {{ required "Automation database type is not valid" (include "getAutomationDbType" . | trim )}}
- name: DB_URL
  value: {{ .Values.db.connectionURL }}
- name: DB_HOST
  value: {{ .Values.db.host }}
- name: DB_PORT
  value: {{ .Values.db.port | quote }}
- name: DB_NAME
  value: {{ .Values.db.name }}
- name: DB_DRIVER_CLASS
  value: {{ .Values.db.driverClass }}
- name: DB_DRIVER
  value: {{ .Values.db.driver }}
- name: DB_ENCRYPT_CONNECTION
  value: {{ .Values.db.encryptConnection }}
{{- $dbPassDefinition := dict "source" .Values.db.passSource "mountPath" "/opt/Quadient/secrets/db/password" "secretKey" "dbPass" "envFileName" "DB_PASS" -}}
{{- $dbUserDefinition := dict "source" .Values.db.userSource "mountPath" "/opt/Quadient/secrets/db/username" "secretKey" "dbUser" "envFileName" "DB_USER" -}}
{{- include "inspire.secret.asFilePointer" ($dbUserDefinition) -}}
{{- include "inspire.secret.asFilePointer" ($dbPassDefinition) -}}
{{- if eq "verified" (.Values.db.encryptConnection | trim | lower) }}
{{- $dbTruststoreDefinition := dict "source" .Values.db.truststoreSource "mountPath" "/opt/Quadient/secrets/db/truststore" "secretKey" "dbTruststore" "envFileName" "DB_TRUSTSTORE" -}}
{{- include "inspire.secret.asFilePointer" ($dbTruststoreDefinition) -}}
{{- if not (eq "postgresql" (.Values.db.type | trim | lower)) }}
{{- $dbTruststorePassDefinition := dict "source" .Values.db.truststorePassSource "mountPath" "/opt/Quadient/secrets/db/truststorePassword" "secretKey" "dbTruststorePass" "envFileName" "DB_TRUSTSTORE_PASSWORD" -}}
{{- include "inspire.secret.asFilePointer" ($dbTruststorePassDefinition) -}}
{{- end }}
{{- end }}

{{- end }}