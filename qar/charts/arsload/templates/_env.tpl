{{/*
Defines environment variables for the ARSLOAD service.
*/}}
{{- define "arsload.env" -}}
- name: ARS_HOST
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: ARS_PORT
  value: {{ .Values.global.ondemand.portOverride | default 1445 | quote }}
- name: ARSLOAD_PERIOD
  value: {{ .Values.timeInterval | quote }}
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
      name: {{ include "qar.applicationName" . }}-arsload
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
      name: {{ include "qar.applicationName" . }}-arsload
      key: loadPassword
{{- end }}
- name: OD_INSTANCE_NAME
  value: {{ upper .Values.global.ondemand.odInstanceName }}
{{- end }}
