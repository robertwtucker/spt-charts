{{/*
Scaler ingress settings
*/}}

{{- define "inspire.scaler.ingress.annotations.nginx" -}}
kubernetes.io/ingress.class: nginx
nginx.ingress.kubernetes.io/affinity: "cookie"
nginx.ingress.kubernetes.io/x-forwarded-prefix: {{ .Values.ingress.applicationPath }}
{{- if not (eq .Values.ingress.applicationPath "/") }}
nginx.ingress.kubernetes.io/rewrite-target: /$2
nginx.ingress.kubernetes.io/session-cookie-path: {{ .Values.ingress.applicationPath }}/
{{- else }}
nginx.ingress.kubernetes.io/rewrite-target: /$1
nginx.ingress.kubernetes.io/session-cookie-path: {{ .Values.ingress.applicationPath }}
{{- end }}
nginx.ingress.kubernetes.io/session-cookie-name: "ingress-route"
nginx.ingress.kubernetes.io/session-cookie-expires: "3600"
nginx.ingress.kubernetes.io/session-cookie-max-age: "3600"
{{- end }}

{{- define "inspire.scaler.ingress.annotations.appgw" -}}
kubernetes.io/ingress.class: azure/application-gateway
appgw.ingress.kubernetes.io/backend-path-prefix: "/"
appgw.ingress.kubernetes.io/cookie-based-affinity: "true"
{{- end }}

{{- define "inspire.scaler.ingress.annotations.haproxy" -}}
haproxy.org/cookie-persistence: "ingress-route-scaler"
haproxy.org/request-set-header: "X-Forwarded-Prefix {{ .Values.ingress.applicationPath }}"
{{- if not (eq .Values.ingress.applicationPath "/") }}
haproxy.org/path-rewrite: "{{ .Values.ingress.applicationPath }}/(.*) /\\1"
{{- end }}
{{- end }}

{{- define "inspire.scaler.ingress.annotations" }}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType }}
{{ include "inspire.scaler.ingress.annotations.appgw" . }}
{{- else if eq "nginx" $ingressType }}
{{ include "inspire.scaler.ingress.annotations.nginx" . }}
{{- else if eq "haproxy" $ingressType }}
{{ include "inspire.scaler.ingress.annotations.haproxy" . }}
{{- end }}
{{- end }}

{{- define "inspire.scaler.ingress.path.appgw" }}
{{- if not (eq .Values.ingress.applicationPath "/") }}
{{- .Values.ingress.applicationPath }}/*
{{- else }}
{{- .Values.ingress.applicationPath }}*
{{- end }}
{{- end }}

{{- define "inspire.scaler.ingress.path.nginx" }}
{{- if not (eq .Values.ingress.applicationPath "/") }}
{{- .Values.ingress.applicationPath }}(/|$)(.*)
{{- else }}
{{- .Values.ingress.applicationPath }}(.*)
{{- end }}
{{- end }}

{{- define "inspire.scaler.ingress.path" }}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType -}}
{{ include "inspire.scaler.ingress.path.appgw" . }}
{{- else if eq "nginx" $ingressType -}}
{{ include "inspire.scaler.ingress.path.nginx" . }}
{{- else if eq "haproxy" $ingressType -}}
{{ .Values.ingress.applicationPath }}
{{- end }}
{{- end }}