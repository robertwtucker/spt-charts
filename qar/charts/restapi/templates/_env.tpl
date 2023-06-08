{{/*
Defines environment variables for the RESTAPI service.
*/}}
{{- define "restapi.env" -}}
- name: OD_HOST
  value: {{ include "qar.applicationName" . }}-ondemand-hl.{{ .Release.Namespace }}.svc.cluster.local
- name: OD_INSTANCE_NAME
  value: {{ upper .Values.global.ondemand.odInstanceName }}
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
      name: {{ include "qar.applicationName" . }}-restapi
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
      name: {{ include "qar.applicationName" . }}-restapi
      key: restPassword
{{- end }}
{{- end }}
