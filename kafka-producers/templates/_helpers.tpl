{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "kafka-producers.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-producers.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "eas-producers.name" -}}
{{- printf "%s-eas" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "test-producers.name" -}}
{{- printf "%s-test" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
