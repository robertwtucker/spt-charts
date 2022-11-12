{{/*
Create the default FQDN for the Oracle DB headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "oracledb.svc.headless" -}}
{{- printf "%s-oracledb-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}
