{{/*
Definition of environment variables for Elasticsearch
*/}}
{{- define "interactive.env.elasticsearch" -}}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $dbPassDefinition := dict "value" .Values.fulltext.password "source" .Values.fulltext.passwordSource "secretName" (printf "%s-interactive-elasticsearch" $applicationName) "secretKey" "esPass" "envName" "ES_PASS" "envOnly" true "allowEmpty" true -}}
{{- $dbUserDefinition := dict "value" .Values.fulltext.username "source" .Values.fulltext.usernameSource "secretName" (printf "%s-interactive-elasticsearch" $applicationName) "secretKey" "esUser" "envName" "ES_USER" "envOnly" true "allowEmpty" true -}}
{{- include "inspire.secret.asEnv" ($dbUserDefinition) -}}
{{- include "inspire.secret.asEnv" ($dbPassDefinition) -}}
{{- end }}
