{{/*
Expand the name of the chart.
*/}}
{{- define "rubintv-broadcaster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rubintv-broadcaster.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rubintv-broadcaster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rubintv-broadcaster.labels" -}}
helm.sh/chart: {{ include "rubintv-broadcaster.chart" . }}
{{ include "rubintv-broadcaster.selectorLabels" . }}
{{- end }}

{{/*
Create script name extension
*/}}
{{- define "rubintv-broadcaster.scriptName" -}}
{{ .Values.script | trimPrefix "run" | trimSuffix ".py" | kebabcase }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rubintv-broadcaster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rubintv-broadcaster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-{{ include "rubintv-broadcaster.scriptName" . }}
{{- end }}
