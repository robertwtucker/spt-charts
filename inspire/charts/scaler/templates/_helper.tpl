{{/*
Computes backup count according to given maximum number of nodes
*/}}
{{- define "computeBackupCount" -}}
{{- $replicas := index . "replicas" -}}
{{ max 1 (min 6 (add (div (add $replicas (mod $replicas 2)) 2) -1)) }}
{{- end }}

