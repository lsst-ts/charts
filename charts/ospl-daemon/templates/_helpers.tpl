{{/*
Expand the name of the chart.
*/}}
{{- define "ospl-daemon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ospl-daemon.fullname" -}}
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

{{- define "ospl-daemon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ospl-daemon.labels" -}}
helm.sh/chart: {{ include "ospl-daemon.chart" . }}
{{ include "ospl-daemon.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ospl-daemon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ospl-daemon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "multicast.annotation" -}}
annotations:
  k8s.v1.cni.cncf.io/networks: kube-system/macvlan-conf
{{- end -}}
