{{/*
Create the default FQDN for the CMOD headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "ondemand.svc.headless" -}}
{{- printf "%s-ondemand-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Generates the Oracle TNS service name from the database name, if not provided directly.
*/}}
{{- define "ondemand.tnsServiceName" -}}
{{- .Values.tnsServiceName | default .Values.serverInstanceName | default "archive" | lower }}
{{- end }}

{{/*
Defines environment variables for the CMOD user.
*/}}
{{- define "ondemand.env.user" -}}
{{- if .Values.global.ondemand.userOverrideSource.useSecret }}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.ondemand.userOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.ondemand.userOverrideSource.secretKey }}
{{- else }}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: odUsername
{{- end }}
{{- if .Values.global.ondemand.passwordOverrideSource.useSecret }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.ondemand.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.ondemand.passwordOverrideSource.secretKey }}
{{- else }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: odPassword
{{- end }}
{{- end }}

{{/*
Defines environment variables for the Oracle database service.
*/}}
{{- define "ondemand.env.database" -}}
{{- if eq (upper .Values.db.engine) "ORACLE" -}}
- name: ORACLE_HOST
  value: {{ include "qar.applicationName" . }}-oracledb.{{ .Release.Namespace }}.svc.cluster.local
- name: ORACLE_PORT
  value: {{ .Values.global.oracledb.tnsListener.portOverride | default 1521 | quote }}
- name: ORACLE_SERVICE_NAME
  value: {{ include "ondemand.tnsServiceName" . }}
{{- if .Values.global.ondemand.userOverrideSource.useSecret }}
- name: ORACLE_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.ondemand.userOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.ondemand.userOverrideSource.secretKey }}
{{- else }}
- name: ORACLE_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: dbUsername
{{- end }}
{{- if .Values.global.ondemand.passwordOverrideSource.useSecret }}
- name: ORACLE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.ondemand.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.ondemand.passwordOverrideSource.secretKey }}
{{- else }}
- name: ORACLE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: dbPassword
{{- end }}
{{- end }}
{{- end }}

{{/*
Defines environment variables for the CMOD library server.
*/}}
{{- define "ondemand.env.library" -}}
- name: ARS_HOST
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: ARS_NUM_DBSRVR
  value: {{ .Values.db.numSubServers | quote }}
- name: ARS_PORT
  value: {{ .Values.service.nodePorts.ondemand | quote }}
- name: ARS_SRVR_INSTANCE
  value: {{ include "ondemand.serverInstanceName" . }}
- name: ARS_STORAGE_MANAGER
  value: {{ .Values.storageManager }}
- name: ENABLE_TRACE
  value: {{ printf "%t" .Values.trace.enabled | quote }}
- name: OD_INSTANCE_NAME
  value: {{ .Values.odInstanceName }}
{{- end }}
