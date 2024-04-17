{{- define "inspire.applicationName" -}}
{{- .Values.global.applicationName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "inspire.labels" -}}
app: {{ include "inspire.applicationName" . }}
role: {{ .Values.role }}
{{- end }}

{{- define "inspire.labels.ips" -}}
app: {{ include "inspire.applicationName" . }}
role: {{ .Values.ips.role }}
{{- end }}

{{- define "inspire.env.icm.host" }}
{{- include "inspire.applicationName" . }}-icm.{{ .Release.Namespace }}.svc.cluster.local
{{- end }}

{{- define "inspire.env.icm.port" }}
{{- .Values.global.icm.portOverride | default 30353 }}
{{- end }}

{{- define "inspire.scaler.env.icm.user" }}
{{- .Values.global.scaler.userOverride | default "scaler" }}
{{- end }}

{{- define "inspire.interactive.env.icm.user" }}
{{- .Values.global.interactive.userOverride | default "system" }}
{{- end }}

{{- define "inspire.automation.env.icm.user" }}
{{- .Values.global.automation.userOverride | default "automation" }}
{{- end }}

{{/*
Definition of licensing method
*/}}
{{- define "inspire.env.license" -}}
- name: CX_LICENSE
  value: {{ .Values.global.license.method }}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $primary := dict "value" .Values.global.license.server "source" .Values.global.license.serverSource "secretName" (printf "%s-license" $applicationName) "secretKey" "cxLicServer" "envName" "CX_LIC_SERVER" "envOnly" true -}}
{{- include "inspire.secret.asEnv" $primary }}
{{- $secondary := dict "value" .Values.global.license.server2 "source" .Values.global.license.server2Source "secretName" (printf "%s-license" $applicationName) "secretKey" "cxLicServer2" "envName" "CX_LIC_SERVER2" "envOnly" true -}}
{{- include "inspire.secret.asEnv" $secondary }}
{{- end }}


{{/*
A resulting value is not typeOf bool but string, so comparison to "false" or "true" is required.
*/}}
{{- define "inspire.secret.isDelegated" -}}
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
{{- define "inspire.secrets.areDelegated" }}
{{- if .secrets }}
  {{- $firstKey := get (first .secrets) .sourceField }}
  {{- include "inspire.secret.isDelegated" $firstKey }}
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
{{- define "inspire.secret.check" -}}
{{- if (eq (include "inspire.secret.isDelegated" .source) "false") }}
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
{{- define "inspire.secret.asEnv" }}
{{- if or (empty .source) (eq (include "inspire.secret.isDelegated" .source) "false") }}
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
{{- include "inspire.secret.asFilePointer" (dict "envFileName" .envFileName "source" .source "mountPath" .mountPath "secretKey" .secretKey) }}
{{- end }}
{{- else }}
{{- /* Variable is delegated and its value is not empty. Invalid state. */}}
{{- end }}
{{- end }}

{{/*
Arguments:
* source: {useSecret bool, secretName, secretKey string}
* mountPath: string, a target filepath where the secret will be mounted
* secretKey: string, a file name where the secret will be mounted by default when not using mountAll
* envFileName: string, the name of the environment variable
* mountAll: bool, if specified, the entire directory specified by mountPath is put into the value

Returns:
Environment variable with a mount path of the secret file pointer as a value
*/}}
{{- define "inspire.secret.asFilePointer" }}
{{- if and .mountAll }}
  {{- /* Variable is delegated and whole secret should be mounted without pointing to secret keys. So point to a directory */}}
- name: {{ .envFileName }}
  value: {{ .mountPath }}
{{- else if or (empty .source) (eq (include "inspire.secret.isDelegated" .source) "false") }}
  {{- /* Variable is empty or is not delegated, but, variable should be mounted as a file, so we need to create a env pointer to this file */}}
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
* secretKey: string, the secret key which is used as subPath when mounting the file with withoutSubpath=false
* withoutSubpath: bool
* volumeName: string, a name of the volume this mount references when not using external secret source

Returns:
A new mount which references the specified volumeName. When using custom secret source, the mount name is composed from the secret name specified in this source.
*/}}
{{- define "inspire.secret.asMount" -}}
{{- if or (empty .source) ( eq (include "inspire.secret.isDelegated" .source) "false") -}}
{{- /* Variable is empty or is not delegated, and variable must be mounted as a file, pointing to our secret created by helm chart */}}
- name: {{ .volumeName }}
  {{- if not .withoutSubpath }}
  {{- if empty .secretKey }}
    {{- fail "'secretKey' parameter is required when mounting with a subpath" }}
  {{- end }}
  mountPath: {{ .mountPath }}/{{ .secretKey }}
  subPath: {{ .secretKey }}
  {{- else }}
  mountPath: {{ .mountPath }}
  {{- end }}
  readOnly: true
{{- else }}
{{- /* Variable is delegated to use a secret, and simultaneously, variable is required to be mounted as a file */}}
- name: {{ required "'secretName' is required" .source.secretName }}
  {{- if not .withoutSubpath }}
  subPath: {{ required "'secretKey' is required" .source.secretKey }}
  mountPath: {{ .mountPath }}/{{ .source.secretKey }}
  {{- else }}
  mountPath: {{ .mountPath }}
  {{- end }}
  readOnly: true
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
{{- define "inspire.secret.checkUniqueSource" }}
{{- $secretSources := list }}
{{- $sourceField := .sourceField }}
{{- range $ind, $val := .secrets }}
  {{- $source := get $val $sourceField }}
  {{- $notDelegated := eq (include "inspire.secret.isDelegated" $source) "false" }}
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
{{- define "inspire.secret.uniqueVolumes" }}
{{- $secretNames := list }}
{{- range . }}
    {{- if eq (include "inspire.secret.isDelegated" .source) "true" }}
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