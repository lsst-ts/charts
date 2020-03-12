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

{{- define "kafka-producers.boilerplate" -}}
- name: BROKER_IP
  value: "{{ .Values.env.brokerIp }}"
- name: BROKER_PORT
  value: "{{ .Values.env.brokerPort }}"
- name: REGISTRY_ADDR
  value: "{{ .Values.env.registryAddr }}"
- name: REPLICATION
  value: "{{ .Values.env.replication }}"
- name: LOG_LEVEL
  value: "{{ .Values.env.logLevel }}"
{{- end -}}
