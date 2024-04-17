{{/*
Definition of application url for Interactive
*/}}
{{- define "inspire.env.applicationUrl" -}}
{{- if .Values.ingress.enabled | and .Values.global.interactive.enabled }}
{{- $protocol := "http://" }}
{{- if .Values.ingress.tls.enabled }}
{{- $protocol = "https://" }}
{{- end }}
{{- $host := .Values.ingress.host }}
- name: APPLICATION_URL
  value: {{ printf "%s%s%s" $protocol $host "/interactive/" | quote }}
{{- else }}
- name: APPLICATION_URL
  value: ""
{{- end }}
{{- end }}