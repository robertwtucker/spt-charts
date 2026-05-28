{{/*
Interactive ingress settings
*/}}

{{- define "inspire.interactive.ingress.annotations.nginx" -}}
kubernetes.io/ingress.class: nginx
nginx.ingress.kubernetes.io/rewrite-target: /interactive$1
nginx.ingress.kubernetes.io/affinity: "cookie"
nginx.ingress.kubernetes.io/session-cookie-path: "/interactive/"
nginx.ingress.kubernetes.io/session-cookie-name: "ingress-route"
nginx.ingress.kubernetes.io/session-cookie-expires: "3600"
nginx.ingress.kubernetes.io/session-cookie-max-age: "3600"
{{- end }}

{{- define "inspire.interactive.ingress.annotations.appgw" -}}
kubernetes.io/ingress.class: azure/application-gateway
appgw.ingress.kubernetes.io/backend-path-prefix: "/interactive/"
appgw.ingress.kubernetes.io/cookie-based-affinity: "true"
{{- end }}

{{- define "inspire.interactive.ingress.annotations.haproxy" -}}
haproxy.org/cookie-persistence: "ingress-route-interactive"
haproxy.org/path-rewrite: "/interactive/(.*) /interactive/\\1"
{{- end }}

{{- define "inspire.interactive.ingress.annotations" }}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType }}
{{ include "inspire.interactive.ingress.annotations.appgw" . }}
{{- else if eq "nginx" $ingressType }}
{{ include "inspire.interactive.ingress.annotations.nginx" . }}
{{- else if eq "haproxy" $ingressType }}
{{ include "inspire.interactive.ingress.annotations.haproxy" . }}
{{- end }}
{{- end }}

{{- define "inspire.interactive.ingress.path" -}}
{{- $ingressType := (.Values.global.ingress.type | trim | lower) }}
{{- if eq "appgw" $ingressType -}}
/interactive/*
{{- else if eq "nginx" $ingressType -}}
/interactive(.*)
{{- else if eq "haproxy" $ingressType -}}
/interactive
{{- end }}
{{- end }}