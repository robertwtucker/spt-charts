{{/*
Defines environment variables for the CMOD user.
*/}}
{{- define "qar.env.user" -}}
{{- if .Values.auth.usernameSource.useSecret -}}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.auth.usernameSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.auth.usernameSource.secretKey }}
{{- else -}}
- name: OD_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: odUsername
{{- end -}}
{{- if .Values.auth.passwordSource.useSecret }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.auth.passwordSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.auth.passwordSource.secretKey }}
{{- else }}
- name: OD_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: odPassword
{{- end }}
{{- if .Values.zookeeper.enabled -}}
  {{- if .Values.zookeeper.auth.usernameSource.useSecret -}}
- name: ZK_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.zookeeper.auth.usernameSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.zookeeper.auth.usernameSource.secretKey }}
  {{- else -}}
- name: ZK_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: zkUsername
  {{- end -}}
  {{- if .Values.zookeeper.auth.passwordSource.useSecret }}
- name: ZK_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.zookeeper.auth.passwordSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.zookeeper.auth.passwordSource.secretKey }}
  {{- else }}
- name: ZK_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: zkPassword
  {{- end }}
{{- end -}}
{{- end -}}

{{/*
Defines environment variables for the Oracle database service.
*/}}
{{- define "qar.env.database" -}}
{{- if eq (upper .Values.db.engine) "ORACLE" -}}
- name: ORACLE_HOST
{{- if eq .Values.oracledb.architecture "replicated" }}
  value: {{ include "qar.fullname" . }}-oracledb-headless.{{ include "qar.namespace" . }}.svc.cluster.local
{{- else }}
  value: {{ include "qar.fullname" . }}-oracledb.{{ include "qar.namespace" . }}.svc.cluster.local
{{- end }}
- name: ORACLE_PORT
  value: "1521"
- name: ORACLE_SERVICE_NAME
  value: {{ .Values.tnsServiceName | default .Values.serverInstanceName | default "archive" | lower }}
{{- if .Values.auth.usernameSource.useSecret }}
- name: ORACLE_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.auth.usernameSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.auth.usernameSource.secretKey }}
{{- else }}
- name: ORACLE_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: dbUsername
{{- end }}
{{- if .Values.auth.passwordSource.useSecret }}
- name: ORACLE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.auth.passwordSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.auth.passwordSource.secretKey }}
{{- else }}
- name: ORACLE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.fullname" . }}-ondemand
      key: dbPassword
{{- end }}
{{- end -}}
{{- end -}}

{{/*
Defines environment variables for the CMOD library server.
*/}}
{{- define "qar.env.library" -}}
- name: ARS_HOST
  value: {{ include "ondemand.svc.host" . }}
- name: ARS_NUM_DBSRVR
  value: {{ .Values.db.numSubServers | quote }}
- name: ARS_PORT
  value: {{ include "ondemand.svc.port" . | quote }}
- name: ARS_SRVR_INSTANCE
  value: {{ .Values.serverInstanceName | default "archive" | lower }}
- name: ARS_STORAGE_MANAGER
  value: {{ .Values.storageManager }}
- name: ENABLE_TRACE
  value: {{ printf "%t" .Values.trace.enabled | quote }}
- name: OD_INSTANCE_NAME
  value: {{ .Values.odInstanceName }}
{{- end -}}
