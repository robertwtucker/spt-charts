{{/*
Apply the global app name in lieu of the chart.
*/}}
{{- define "oracledb.applicationName" -}}
{{- .Values.applicationName | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "oracledb.labels" -}}
app: {{ include "oracledb.applicationName" . }}
role: {{ .Values.role }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "oracledb.serviceAccountName" -}}
{{- if empty .Values.existingServiceAccount }}
{{- include "oracledb.applicationName" . }}
{{- else }}
{{- .Values.existingServiceAccount }}
{{- end }}
{{- end -}}

{{/*
Create the default FQDN for the Oracle DB headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "oracledb.svc.headless" -}}
{{- printf "%s-oracledb-hl" (include "oracledb.applicationName" .) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Defines environment variables for the Oracle database service.
*/}}
{{- define "oracledb.env.database" -}}
{{- if not (empty .Values.sid) }}
- name: ORACLE_SID
  value: {{ .Values.sid }}
{{- end }}
{{- if not (empty .Values.pdb) }}
- name: ORACLE_PDB
  value: {{ .Values.pdb }}
{{- end }}
{{- if not (empty .Values.characterSet) }}
- name: ORACLE_CHARACTERSET
  value: {{ .Values.characterSet }}
{{- end }}
{{- if .Values.passwordSource.useSecret }}
- name: ORACLE_PWD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.passwordSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.passwordSource.secretKey }}
{{- else }}
- name: ORACLE_PWD
  valueFrom:
    secretKeyRef:
      name: {{ include "oracledb.applicationName" . }}-oracledb
      key: password
{{- end }}
{{- end -}}
