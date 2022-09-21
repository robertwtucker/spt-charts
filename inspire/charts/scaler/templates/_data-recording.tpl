{{/*
Definition of environment variables of Data Recording
*/}}
{{- define "scaler.env.dataRecording" -}}
- name: DATA_RECORDING_MANAGED_EXTERNALLY
  value: {{ quote .Values.global.dataRecording.prepareEnvironment }}
{{- if .Values.global.dataRecording.prepareEnvironment }}
- name: DATA_RECORDING_PORT
  value: "30800"
- name: DATA_RECORDING_SERVICE
  value: {{ include "inspire.applicationName" . }}-datarecording.{{ .Release.Namespace }}.svc.cluster.local
{{- end }}
{{- end }}