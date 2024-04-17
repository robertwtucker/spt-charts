{{/*
Definition of environment variables for SAML configuration
*/}}
{{- define "scaler.env.saml" -}}
- name: SAML_ENABLED
  value: {{ .Values.authentication.saml2.enabled | quote }}
{{- if .Values.authentication.saml2.enabled }}
{{- $applicationName := include "inspire.applicationName" . -}}
{{- $samlKeystoreDefinition := dict "source" .Values.authentication.saml2.keystoreSource "secretKey" "keystore" "mountPath" "/opt/Quadient/secrets/saml" "envFileName" "SAML_KEYSTORE_FILE" -}}
{{- $samlKeystorePasswordDefinition := dict "value" .Values.authentication.saml2.keystorePassword "source" .Values.authentication.saml2.keystorePasswordSource "secretName" (printf "%s-scaler-saml" $applicationName) "secretKey" "keystorePassword" "envName" "SAML_KEYSTORE_PASSWORD" "envOnly" true -}}
{{- $samlServiceProviderKeystorePasswordDefinition := dict "value" .Values.authentication.saml2.serviceProviderKeypairPassword "source" .Values.authentication.saml2.serviceProviderKeypairPasswordSource "secretName" (printf "%s-scaler-saml" $applicationName) "secretKey" "serviceProviderKeypairPassword" "envName" "SAML_SP_KEYPAIR_PASSWORD" "envOnly" true }}
- name: SAML_REGISTRATION_ALIAS
  value: {{ .Values.authentication.saml2.registrationAlias }}
{{- include "inspire.secret.asFilePointer" $samlKeystoreDefinition }}
{{- include "inspire.secret.asEnv" ($samlKeystorePasswordDefinition) }}
- name: SAML_KEYSTORE_TYPE
  value: {{ .Values.authentication.saml2.keystoreType }}
- name: SAML_SP_KEYPAIR_ALIAS
  value: {{ .Values.authentication.saml2.serviceProviderKeypairAlias }}
{{- include "inspire.secret.asEnv" ($samlServiceProviderKeystorePasswordDefinition) }}
- name: SAML_CERTIFICATE_ALIAS
  value: {{ .Values.authentication.saml2.certificateAlias }}
- name: SAML_ENTITY_ID
  value: {{ .Values.authentication.saml2.entityId }}
- name: SAML_SSO_URL
  value: {{ .Values.authentication.saml2.singleSignOnUrl }}
- name: SAML_UPDATE_STRATEGY
  value: {{ .Values.authentication.saml2.updateStrategy }}
- name: SAML_MISSING_GROUP_STRATEGY
  value: {{ .Values.authentication.saml2.missingGroupStrategy }}
- name: SAML_ATTRIBUTE_MAPPING_USER
  value: {{ .Values.authentication.saml2.attributeMappingUser }}
- name: SAML_ATTRIBUTE_MAPPING_MAIL
  value: {{ .Values.authentication.saml2.attributeMappingMail }}
- name: SAML_ATTRIBUTE_MAPPING_NAME
  value: {{ .Values.authentication.saml2.attributeMappingName }}
- name: SAML_ATTRIBUTE_MAPPING_GROUP
  value: {{ .Values.authentication.saml2.attributeMappingGroup }}
{{- end }}
{{- end }}