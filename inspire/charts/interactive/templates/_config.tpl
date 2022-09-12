{{- define "interactive.env.config" -}}
{
  "installationDirectory": "/opt/QuadientInteractive",
  "programDataDirectory": "/tmp/programData",
  "installationType": "NEW",
  "upgradeDatabase": true,
  "eulaAccepted": true,
  "productionEnvironment": {{ .Values.productionEnvironment }},
  "userActivityTracking": true,
  "license": {
    {{- if eq "cl" (.Values.global.license.method | trim | lower)}}
    "type": "CLOUD",
    "cloudLicensingActivationKey": "$(CX_LIC_SERVER)"
    {{- else if eq "ls" (.Values.global.license.method | trim | lower)}}
    "type": "NET",
    "netLicensingServers": [
      "$(CX_LIC_SERVER)",
      "$(CX_LIC_SERVER2)"
    ]
    {{- else }}
    {{- end }}
  },
  "server": {
    "port": 30701,
    "host": "localhost",
    "resolveHostname": true,
    "useSSL": false,
    "applicationUrl": "",
    "embeddedApplicationServer": true,
    "keystoreFile": "",
    "keystorePassword": "",
    "keystoreType": "JKS"
  },
  "icm": {
    "host": "$(ICM_HOST)",
    "port": "$(ICM_PORT)",
    "user": "$(ICM_USER)",
    "password": "$(ICM_PASS)",
    "adminUser": "admin",
    "adminPassword": "$(GROO_ICM_PASS)",
    "createUser": true,
    "rootFolder": {{ .Values.icmRoot | quote }},
    "packageType": "CUSTOM",
    "packagePath": "/tmp/install/initialIcmData.pkg"
  },
  "inspireProductionServer": [
    {
      "host": "localhost",
      "port": 30354
    }
  ],
  "database": {
    "host": "$(DB_HOST)",
    "port": "$(DB_PORT)",
    "databaseName": "$(DB_NAME)",
    "user": "$(DB_USER)",
    "password": "$(DB_PASS)",
    "connectionString": "$(DB_CONNECTION_STRING)",
    "mssqlWindowsAuthenticationLibraryPath": "",
    "windowsAuthentication": false,
    "createContent": false,
    "driver": "",
    "type": "$(DB_TYPE)"
  },
  {{- if .Values.global.scaler.enabled }}
  "scaler": {
    "url": "http://{{ include "inspire.applicationName" . }}-scaler.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.global.scaler.portOverride | default 30600 }}",
    "user": "$(SCALER_USER)",
    "password": "$(SCALER_PASS)"
  },
  {{- end }}
  {{- if .Values.fulltext.enabled }}
  "elasticSearch" : {
    "urls" : ["{{ .Values.fulltext.host }}"],
    "username" : "$(ES_USER)",
    "password" : "$(ES_PASS)",
    "type" : "REMOTE"
  },
  {{- end }}
  "systemd": {
    "environment": "",
    "group": ""
  }
}
{{- end }}
