{{/*
Expand the name of the chart.
*/}}
{{- define "love-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "love-manager.fullname" -}}
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
{{- define "love-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "love-manager.labels" -}}
helm.sh/chart: {{ include "love-manager.chart" . }}
{{ include "love-manager.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "love-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "love-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Handle environment parameters
 */}}
{{- define "helpers.envFromList" -}}
{{- $secretName := .secretName }}
{{- range $item := .env }}
{{- $_ := set $item "secretName" $secretName }}
{{ include "helpers.envType" $item }}
{{- end }}
{{- end }}

{{/*
Determine type of environment
*/}}
{{- define "helpers.envType" -}}
- name: {{ .var }}
{{- if .isSecret }}
  valueFrom:
    secretKeyRef:
      name: {{ .secretName }}-secrets
      key: {{ .value }}
{{- else }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name for database.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "love-manager.database.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-database" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-database" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels - database
*/}}
{{- define "love-manager.database.labels" -}}
helm.sh/chart: {{ include "love-manager.chart" . }}
{{ include "love-manager.database.selectorLabels" . }}
{{- end }}

{{/*
Selector labels - database
*/}}
{{- define "love-manager.database.selectorLabels" -}}
app.kubernetes.io/name: {{ include "love-manager.name" . }}
app.kubernetes.io/instance: {{ include "love-manager.database.fullname" . }}
{{- end }}

{{/*
Create a default fully qualified app name for redis.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "love-manager.redis.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-redis" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-redis" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels - redis
*/}}
{{- define "love-manager.redis.labels" -}}
helm.sh/chart: {{ include "love-manager.chart" . }}
{{ include "love-manager.redis.selectorLabels" . }}
{{- end }}

{{/*
Selector labels - redis
*/}}
{{- define "love-manager.redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "love-manager.name" . }}
app.kubernetes.io/instance: {{ include "love-manager.redis.fullname" . }}
{{- end }}
