{{/*
Definition of environment variables of icm service
*/}}
{{- define "scaler.env.icm" -}}
- name: ICM_HOST
  value: {{ include "inspire.applicationName" . }}-icm.{{ .Release.Namespace }}.svc.cluster.local
- name: ICM_PORT
  value: {{ .Values.global.icm.portOverride | default "30353" | quote }}
- name: ICM_USER
  value: {{ .Values.global.scaler.userOverride | default "scaler" | quote }}
{{- if .Values.global.scaler.passOverrideSource.useSecret }}
- name: ICM_PASS
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.scaler.passOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.scaler.passOverrideSource.secretKey }}
{{- else }}
- name: ICM_PASS
  valueFrom:
    secretKeyRef:
      name: {{ include "inspire.applicationName" . }}-scaler-icm
      key: pass
{{- end }}
{{- end }}
