{{/*
Create the default FQDN for the CMOD headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "ondemand.svc.headless" -}}
{{- printf "%s-ondemand-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}
