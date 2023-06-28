{{/*
Apply the global app name in lieu of the chart.
*/}}
{{- define "qar.applicationName" -}}
{{- .Values.global.applicationName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "qar.labels" -}}
app: {{ include "qar.applicationName" . }}
role: {{ .Values.role }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "qar.serviceAccountName" -}}
{{- if empty .Values.global.existingServiceAccount }}
{{- include "qar.applicationName" . }}
{{- else }}
{{- .Values.global.existingServiceAccount }}
{{- end }}
{{- end }}

{{- define "qar.env.oracledb.host" }}
{{- include "qar.applicationName" . }}-oracledb.{{ .Release.Namespace }}.svc.cluster.local
{{- end }}

{{- define "qar.env.ondemand.host" }}
{{- include "qar.applicationName" . }}-ondemand.{{ .Release.Namespace }}.svc.cluster.local
{{- end }}

{{/*
A resulting value is not typeOf bool but string, so comparison to "false" or "true" is required.
*/}}
{{- define "qar.secret.isDelegated" -}}
{{- if . }}
{{- .useSecret | default false }}
{{- else }}
false
{{- end }}
{{- end -}}

{{/*
Arguments:
  secrets: A list of dictionaries
  sourceField: A name of a field that contains a secret source path

All keys must come from single source.
*/}}
{{- define "qar.secrets.areDelegated" }}
{{- if .secrets }}
  {{- $firstKey := get (first .secrets) .sourceField }}
  {{- include "qar.secret.isDelegated" $firstKey }}
{{- else }}
false
{{- end }}
{{- end }}

{{/*
Checks integrity of a given password. Fails validation when inconsistent
Arguments:
  source    {} useSecret bool, secretName, secretKey string
  value     string
*/}}
{{- define "qar.secret.check" -}}
{{- if (eq (include "qar.secret.isDelegated" .source) "false") }}
{{- else if not (empty .value) }}
{{ fail "The Secret value is set as plaintext while the 'useSecret' variable is used as well. Choose one option." }}
{{- end -}}
{{- end -}}

{{/*
Arguments:
* source: {useSecret bool, secretName, secretKey string}
* value: string
* envName: An environment variable name that would be passed to a container
* envFileName: An environment variable name that would be passed to a container containing a path to a secret
* secretName: string, a name of a secret that the value is located in
* secretKey: string
* envOnly: bool, if false, {{.envName}}_FILE variable is created pointing to mounted secret location
* allowEmpty: bool? = false
Returns:
a) If secret defined in plaintext, default variable declaration pointing to a secret created by this helm chart
b) If useSecret evaluates to true, variable points to already existing secret, defined by .secret.secretName and .secret.secretKey
c) If envOnly evaluates to true, validation fails.
*/}}
{{- define "qar.secret.asEnv" }}
{{- if or (empty .source) (eq (include "qar.secret.isDelegated" .source) "false") }}
    {{- if or (.allowEmpty) (not (empty .value)) }}
{{- /* Allow empty is useful for e.g. icmAdminPassword, which is automatically generated.
    So, such password is empty and not delegated, but we want to create an env pointing to a secret, where it will be created.
*/}}
- name: {{ .envName }}
  valueFrom:
    secretKeyRef:
      name: {{ .secretName }}
      key: {{ .secretKey | quote }}
    {{- end }}
{{- else if .source.useSecret }}
{{- /*Secret is delegated as a secret, mounting it from existing secret */}}
- name: {{ .envName }}
  valueFrom:
    secretKeyRef:
      name: {{ required "field 'secretName' of a secret must be filled." .source.secretName }}
      key: {{ (required "field 'secretKey' of a secret must be filled." .source.secretKey) | quote }}
{{- if not .envOnly }}
{{- /*Variable can be mounted as an env or as a file. useSecret had its own if condition */}}
{{- include "qar.secret.asFilePointer" (dict "envFileName" .envFileName "source" .source "mountPath" .mountPath "secretKey" .secretKey) }}
{{- end }}
{{- else }}
{{- /* Variable is delegated and its value is not empty. Invalid state. */}}
{{- end }}
{{- end }}

{{- define "qar.secret.asFilePointer" }}
{{- if or (empty .source) (eq (include "qar.secret.isDelegated" .source) "false") }}
  {{- /* Variable is empty or is not delegated, but, variable should be mounted as a file, so we need to create a env pointer to this file */}}
- name: {{ .envFileName }}
  value: {{ printf "%s/%s" .mountPath .secretKey }}
{{- else if and .mountAll }}
  {{- /* Variable is delegated and whole secret should be mounted without pointing to secret keys. So point to a directory */}}
- name: {{ .envFileName }}
  value: {{ printf "%s/%s" .mountPath .secretKey }}
{{- else }}
  {{- /* Variable is mounted as a file and we need to point to this variable */}}
- name: {{ .envFileName }}
  value: {{ printf "%s/%s" .mountPath .source.secretKey }}
{{- end }}
{{- end }}

{{/*
Arguments:
* source: {useSecret bool, secretName, secretKey string}
* mountPath: string, a target filepath that the volume should be mounted to.
* withoutSubpath bool
* value string

Returns:
b) nothing otherwise.
*/}}
{{- define "qar.secret.asMount" -}}
{{- if or (empty .source) ( eq (include "qar.secret.isDelegated" .source) "false") -}}
{{- /* if not .mountSecret: Variable is empty or is not delegated, so there is nothing to mount, because variable is passed via env variable from secret */}}
{{- if .mountSecret }}
  {{- /* Variable is empty or is not delegated, and variable must be mounted as a file, pointing to our secret created by helm chart */}}
- name: {{ .secretName }}
  {{- if not .withoutSubpath }}
  mountPath: {{ .mountPath }}/{{ .secretKey }}
  subPath: {{ .secretKey }}
  {{- else }}
  mountPath: {{ .mountPath }}
  {{- end }}
  readOnly: true
{{- end }}
{{- else if .mountSecret | and .source.useSecret }}
{{- /* Variable is delegated to use a secret, and simultaneously, variable is required to be mounted as a file */}}
- name: {{ required "'secretName' is required" .source.secretName }}
  {{- if not .withoutSubpath }}
  subPath: {{ required "'secretKey' is requried" .source.secretKey }}
  mountPath: {{ .mountPath }}/{{ .source.secretKey }}
  {{- else }}
  mountPath: {{ .mountPath }}
  {{- end }}
  readOnly: true
{{- else -}}
{{- end -}}
{{- end -}}

{{/*
Arguments:
* secrets: A list of objects that each contain a password interface
* sourceField: A field key of a secret in an object

Throws a validation error when secrets are not from a single source.
e.g. This is important for customEncryption keys source, because all keys must be from same secret,
because customEncryption is mounted into directory with all contained keys.
*/}}
{{- define "qar.secret.checkUniqueSource" }}
{{- $secretSources := list }}
{{- $sourceField := .sourceField }}
{{- range $ind, $val := .secrets }}
  {{- $source := get $val $sourceField }}
  {{- $notDelegated := eq (include "qar.secret.isDelegated" $source) "false" }}
  {{- if or (not (hasKey $val $sourceField)) $notDelegated }}
    {{- $secretSources = append $secretSources "__internalkeys" }}
  {{- else if $source.useSecret }}
    {{- $secretSources = append $secretSources (printf "secret-%s" $source.secretName) }}
  {{- end }}
{{- end }}
{{- $secretSourcesCount := uniq $secretSources | len }}
{{- if gt $secretSourcesCount 1 }}
{{- fail (printf "The given Secrets can only be defined from a single source, but come from %d" $secretSourcesCount ) }}
{{- end }}
{{- end }}

{{/*
Arguments:
* A list of secrets

Collects secretNames of each secret and then creates individual volume for each secret source.
For variable that would be mounted as a file.
Multiple sources can have same source and thus the source should be specified as a volume only once.
*/}}
{{- define "qar.secret.uniqueVolumes" }}
{{- $secretNames := list }}
{{- range . }}
    {{- if eq (include "qar.secret.isDelegated" .source) "true" }}
        {{- if .source.useSecret | and (not (has .source.secretName $secretNames)) }}
            {{- $secretNames = append $secretNames .source.secretName }}
        {{- end }}
    {{- else }}
- name: {{ .volumeName }}
  secret:
    secretName: {{ .secretName }}
    {{- end }}
{{- end }}
{{- range $secretNames }}
- name: {{ . }}
  secret:
    secretName: {{ . }}
{{- end }}
{{- end }}

{{/*
Return the list of Zookeeper servers to use (string format).
*/}}
{{- define "qar.zookeeper.servers" -}}
{{- $serverList := list -}}
{{- range .Values.global.zookeeper.servers -}}
{{- $serverList = append $serverList . -}}
{{- end -}}
{{- printf "%s" (default "" (join "," $serverList)) -}}
{{- end -}}
