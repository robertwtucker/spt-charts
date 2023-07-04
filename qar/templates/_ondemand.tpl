{{/*
Create the default name for the OnDemand service. Truncate the name
at 63 characters to allow for the host name to fit in the DNS limit.
*/}}
{{- define "ondemand.svc.name" -}}
{{- if eq .Values.architecture "replicated" -}}
{{- include "ondemand.svc.headless" . -}}
{{- else -}}
{{- printf "%s-ondemand" ( include "qar.fullname" . ) | trunc 63 -}}
{{- end -}}
{{- end -}}

{{/*
Create the default name for the OnDemand headless service. Truncate the name
at 63 characters to allow for the host name to fit in the DNS limit.
*/}}
{{- define "ondemand.svc.headless" -}}
{{- printf "%s-ondemand-headless" ( include "qar.fullname" . ) | trunc 63 -}}
{{- end -}}

{{/*
Create the default FQDN for the OnDemand service.
*/}}
{{- define "ondemand.svc.host" -}}
{{- printf "%s.%s.svc.cluster.local" ( include "ondemand.svc.name" . ) ( include "qar.namespace" . ) -}}
{{- end -}}

{{/*
Convenience function for deterrmining the port exposed by the OnDemand service.
*/}}
{{- define "ondemand.svc.port" -}}
{{- .Values.service.ports.ondemand | default 1445 -}}
{{- end -}}

{{/*
Return the list of Zookeeper servers to use (string format).
*/}}
{{- define "zookeeper.servers" -}}
{{- $serverList := list -}}
{{- range .Values.zookeeper.servers -}}
{{- $serverList = append $serverList . -}}
{{- end -}}
{{- printf "%s" (default "" (join "," $serverList)) -}}
{{- end -}}

