{{/*
Definition of environment variable of installation type
*/}}
{{- define "scaler.installationType" -}}
{{ required "Scaler installation type is invalid. The possible values are [Stateless/Cluster]" (include "getScalerInstallationType" . | trim ) | quote }}
{{- end }}

{{/*
Validates and transcripts Scaler installation type
*/}}
{{- define "getScalerInstallationType" -}}
{{- if eq "cluster" (.Values.installationType | trim | lower)  }}
Cluster
{{- else if eq "stateless" (.Values.installationType | trim | lower) }}
Stateless
{{- else }}
{{- end }}
{{- end }}