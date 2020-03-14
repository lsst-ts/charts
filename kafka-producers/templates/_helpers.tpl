{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "kafka-producers.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-producers.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "auxtel-producers.name" -}}
{{- printf "%s-auxtel" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "comcam-producers.name" -}}
{{- printf "%s-comcam" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "eas-producers.name" -}}
{{- printf "%s-eas" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "latiss-producers.name" -}}
{{- printf "%s-latiss" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "m1m3-producers.name" -}}
{{- printf "%s-m1m3" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "m2-producers.name" -}}
{{- printf "%s-m2" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "obssys-producers.name" -}}
{{- printf "%s-obssys" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "test-producers.name" -}}
{{- printf "%s-test" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-producers.container-boilerplate" -}}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
imagePullPolicy: {{ .Values.image.pullPolicy }}
stdin: true
tty: true
{{- end -}}

{{- define "kafka-producers.env-boilerplate" -}}
- name: BROKER_IP
  value: "{{ .Values.env.brokerIp }}"
- name: BROKER_PORT
  value: "{{ .Values.env.brokerPort }}"
- name: REGISTRY_ADDR
  value: "{{ .Values.env.registryAddr }}"
- name: PARTITIONS
  value: "{{ .Values.env.partitions }}"
- name: REPLICATION
  value: "{{ .Values.env.replication }}"
- name: LOG_LEVEL
  value: "{{ .Values.env.logLevel }}"
{{- end -}}
