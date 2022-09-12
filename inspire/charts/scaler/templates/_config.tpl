{{- define "scaler.config" -}}
{
    "internalSettings": {
        "version": "ISC-9564,ISC-8533,ISC-10431,ISC-13603,ISC-12606"
    },
    "inspireInteractiveConnections": {
        "importEnabled": true,
        "inspireInteractiveConnectionsList": [
          {
            "alias" : "interactive",
            "url" : "http://$(INTERACTIVE_HOST):$(INTERACTIVE_PORT)/interactive",
            "systemUser" : "$(INTERACTIVE_USER)",
            "password" : {
                "id" : "password.interactive.interactive",
                "definedBy" : "VALUE",
                "encryptedValue" : "$(INTERACTIVE_PASS)",
                "variables" : null
            },
            "sslEnabledDefinedBy" : "VALUE",
            "sslEnabled" : false,
            "sslEnabledVariable" : null,
            "certificateVerification" : {
                "id" : "interactive.server.default",
                "definedBy" : "VALUE",
                "certificateVerification" : null,
                "certificateVerificationVariables" : null,
                "certificateAlias" : null,
                "certificateAliasVariables" : null
            }
          }
        ]
    }
}
{{- end }}