{{/*
Create the default FQDN for the CMOD headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "ondemand.svc.headless" -}}
{{- printf "%s-ondemand-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Generates the Oracle TNS service name from the database name, if not provided directly.
*/}}
{{- define "ondemand.tnsServiceName" -}}
{{- .Values.global.ondemand.tnsServiceName | default .Values.global.ondemand.serverInstanceName | default "archive" | lower }}
{{- end }}
