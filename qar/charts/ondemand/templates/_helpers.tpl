{{/*
Create the default FQDN for the CMOD headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "ondemand.svc.headless" -}}
{{- printf "%s-ondemand-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

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

{{/*
Ensures the default database name is specified.
*/}}
{{- define "ondemand.serverInstanceName" -}}
{{- .Values.serverInstanceName | default "archive" | lower }}
{{- end }}

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

{{/*
Defines environment variables for the RESTAPI service.
*/}}
{{- define "ondemand.env.restapi" -}}
- name: OD_HOST
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: OD_INSTANCE_NAME
  value: {{ upper .Values.odInstanceName }}
- name: OD_PORT
  value: {{ .Values.global.ondemand.portOverride | default 1445 | quote }}
{{- if .Values.global.restapi.userOverrideSource.useSecret }}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.restapi.userOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.restapi.userOverrideSource.secretKey }}
{{- else }}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: restUsername
{{- end }}
{{- if .Values.global.restapi.passwordOverrideSource.useSecret }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.restapi.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.restapi.passwordOverrideSource.secretKey }}
{{- else }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: restPassword
{{- end }}
{{- end }}

{{/*
Defines environment variables for the ARSLOAD service.
*/}}
{{- define "ondemand.env.arsload" -}}
- name: ARS_HOST
  valueFrom:
    fieldRef:
        fieldPath: metadata.name
- name: ARS_PORT
  value: {{ .Values.global.ondemand.portOverride | default 1445 | quote }}
- name: ARS_SRVR
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: ARSLOAD_PERIOD
  value: {{ .Values.arsload.timeInterval | quote }}
{{- if .Values.global.arsload.userOverrideSource.useSecret }}
- name: ARSLOAD_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.arsload.userOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.arsload.userOverrideSource.secretKey }}
{{- else }}
- name: ARSLOAD_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: loadUsername
{{- end }}
{{- if .Values.global.arsload.passwordOverrideSource.useSecret }}
- name: ARSLOAD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.arsload.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.arsload.passwordOverrideSource.secretKey }}
{{- else }}
- name: ARSLOAD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: loadPassword
{{- end }}
- name: OD_INSTANCE_NAME
  value: {{ upper .Values.odInstanceName }}
{{- end }}
