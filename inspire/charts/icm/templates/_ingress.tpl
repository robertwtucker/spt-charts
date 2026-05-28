{{/*
ICM ingress settings
*/}}

{{- define "inspire.icm.ingress.annotations.nginx" -}}
kubernetes.io/ingress.class: nginx
nginx.ingress.kubernetes.io/rewrite-target: /$2
{{- end }}

{{- define "inspire.icm.ingress.annotations.appgw" -}}
kubernetes.io/ingress.class: azure/application-gateway
appgw.ingress.kubernetes.io/backend-path-prefix: "/"
appgw.ingress.kubernetes.io/health-probe-status-codes: "200-399, 400, 404"
appgw.ingress.kubernetes.io/health-probe-path: "/health"
{{- end }}

{{- define "inspire.icm.ingress.annotations.haproxy" -}}
haproxy.org/path-rewrite: "/icm/(.*) /\\1"
{{- end }}

{{- define "inspire.icm.ingress.annotations" }}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType }}
{{ include "inspire.icm.ingress.annotations.appgw" . }}
{{- else if eq "nginx" $ingressType }}
{{ include "inspire.icm.ingress.annotations.nginx" . }}
{{- else if eq "haproxy" $ingressType }}
{{ include "inspire.icm.ingress.annotations.haproxy" . }}
{{- end }}
{{- end }}

{{- define "inspire.icm.ingress.path" -}}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType -}}
/icm/*
{{- else if eq "nginx" $ingressType -}}
/icm(/|$)(.*)
{{- else if eq "haproxy" $ingressType -}}
/icm
{{- end }}
{{- end }}