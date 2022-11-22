{{/*
Create the default FQDN for the Oracle DB headless service
We truncate at 63 chars because of the DNS naming spec.
*/}}
{{- define "oracledb.svc.headless" -}}
{{- printf "%s-oracledb-hl" (include "qar.applicationName" .) | trunc 63 | trimSuffix "-" }}
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
{{- if .Values.global.oracledb.passwordOverrideSource.useSecret }}
- name: ORACLE_PWD
  valueFrom:
    secretKeyRef:
      name: {{ required "secretName is mandatory" .Values.global.oracledb.passwordOverrideSource.secretName }}
      key: {{ required "secretKey is mandatory" .Values.global.oracledb.passwordOverrideSource.secretKey }}
{{- else }}
- name: ORACLE_PWD
  valueFrom:
    secretKeyRef:
      name: {{ include "qar.applicationName" . }}-oracledb
      key: password
{{- end }}
{{- end }}
