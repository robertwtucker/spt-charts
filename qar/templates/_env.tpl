{{/*
Defines environment variables for the CMOD user.
*/}}
{{- define "qar.env.user" -}}
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
{{- if .Values.global.zookeeper.enabled }}
  {{- if .Values.global.zookeeper.userOverrideSource.useSecret }}
- name: ZK_USER
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.zookeeper.userOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.zookeeper.userOverrideSource.secretKey }}
  {{- else }}
- name: ZK_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: zkUsername
  {{- end }}
  {{- if .Values.global.zookeeper.passwordOverrideSource.useSecret }}
- name: ZK_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.zookeeper.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.zookeeper.passwordOverrideSource.secretKey }}
  {{- else }}
- name: ZK_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-ondemand
      key: zkPassword
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Defines environment variables for the Oracle database service.
*/}}
{{- define "qar.env.database" -}}
{{- if eq (upper .Values.global.ondemand.db.engine) "ORACLE" }}
- name: ORACLE_HOST
  value: {{ include "qar.applicationName" . }}-oracledb.{{ .Release.Namespace }}.svc.cluster.local
- name: ORACLE_PORT
  value: "1521"
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
{{- end -}}

{{/*
Defines environment variables for the CMOD library server.
*/}}
{{- define "qar.env.library" -}}
- name: ARS_HOST
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: ARS_NUM_DBSRVR
  value: {{ .Values.global.ondemand.db.numSubServers | quote }}
- name: ARS_PORT
  value: {{ .Values.global.ondemand.portOverride | default 1445 | quote }}
- name: ARS_SRVR_INSTANCE
  value: {{ .Values.global.ondemand.serverInstanceName | default "archive" | lower }}
- name: ARS_STORAGE_MANAGER
  value: {{ .Values.global.ondemand.storageManager }}
- name: ENABLE_TRACE
  value: {{ printf "%t" .Values.global.ondemand.trace.enabled | quote }}
- name: OD_INSTANCE_NAME
  value: {{ .Values.global.ondemand.odInstanceName }}
{{- end -}}
