{{- define "vikunja.namespace" -}}
{{ .Values.namespace | default "default" }}
{{- end -}}

{{- define "vikunja.database.type" -}}
{{ .Values.database.type | default "postgres" }}
{{- end -}}

{{- define "vikunja.database.host" -}}
{{- if .Values.database.host -}}
  {{ .Values.database.host }}
{{- else -}}
  vikunja-database.{{ include "vikunja.namespace" . }}.svc.cluster.local
{{- end -}}
{{- end -}}

{{- define "vikunja.frontend.host" -}}
{{- if and .Values.frontend .Values.frontend.host -}}
  {{ .Values.frontend.host }}
{{- else -}}
  vikunja-frontend.{{ include "vikunja.namespace" . }}.svc.cluster.local
{{- end -}}
{{- end -}}

{{- define "vikunja.backend.host" -}}
{{- if and .Values.backend .Values.backend.host -}}
  {{ .Values.backend.host }}
{{- else -}}
  vikunja-backend.{{ include "vikunja.namespace" . }}.svc.cluster.local
{{- end -}}
{{- end -}}
