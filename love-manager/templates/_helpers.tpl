{{/*
Handle environment parameters
*/}}
{{- define "helpers.envFromList" -}}
{{- range $item := .env }}
{{ include "helpers.envType" $item }}
{{- end }}
{{- end -}}

{{/*
Determine type of environment
*/}}
{{- define "helpers.envType" -}}
- name: {{ .key }}
{{- if .isSecret }}
  valueFrom:
    secretRef:
      name: {{ .value }}
{{- else }}
  value: {{ .value | quote }}
{{- end }}
{{- end -}}
