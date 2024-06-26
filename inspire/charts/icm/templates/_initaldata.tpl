{{- define "icm.initialdata" -}}
{
{{- if .Values.useInitImport }}
  "initialPackagePath": "/opt/import/initialIcmData.pkg",
{{- end }}
  "applyOnEveryStartup": {
  {{- if .Values.useEveryStartupSettings }}
    "serverSettings": {{ .Values.onEveryStartupSettings | toJson }},
  {{- end }}
    "Users": [
      {
        "userName": "admin",
        "userPasswordPath": "$(ADMIN_PASS_FILE)",
        "accessRights": {
          "admin": {
            "rightStatus": "allow"
          },
          "allowImpersonate": {
            "rightStatus": "allow"
          }
        }
      }
{{- if .Values.global.scaler.enabled }}
      ,{
        "userName": {{ .Values.global.scaler.userOverride | default "scaler" | quote }},
        "userPasswordPath": "$(SCALER_PASS_FILE)",
        "accessRights": {
          "admin": {
            "rightStatus": "allow"
          },
          "allowImpersonate": {
            "rightStatus": "allow"
          },
          "serverExportImport": {
            "rightStatus": "allow"
          }
        }
      }
{{- end }}
{{- if .Values.global.automation.enabled }}
      ,{
        "userName": {{ .Values.global.automation.userOverride | default "automation" | quote }},
        "userPasswordPath": "$(AUTOMATION_PASS_FILE)",
        "accessRights": {
          "admin": {
            "rightStatus": "allow"
          },
          "allowImpersonate": {
            "rightStatus": "allow"
          },
          "serverExportImport": {
            "rightStatus": "allow"
          }
        }
      }
{{- end }}
{{- if .Values.global.sen.enabled }}
      ,{
        "userName": {{ .Values.global.sen.userOverride | default "sen" | quote }},
        "userPasswordPath": "$(SEN_PASS_FILE)"
      }
{{- end }}
    ]
  }
{{- if .Values.useInitialServerSettings }}
  ,"initialStartup": {
     "serverSettings": {{ .Values.initialServerSettings | toJson }}
  }
{{- end }}
{{- $connectionStringDelegated := eq (include "inspire.secret.isDelegated" .Values.db.connectionStringSource) "true" -}}
{{- if or .Values.db.connectionString $connectionStringDelegated -}}
  ,"connectStringPath": "$(DB_CONNECTION_STRING_FILE)",
  "dbtype": {{ required "ICM database type is not valid" (include "getIcmDbType" . | trim | quote) }}
{{- end }}
}
{{- end }}
