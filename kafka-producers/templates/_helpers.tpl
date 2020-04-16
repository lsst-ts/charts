{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "kafka-producers.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-producers.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-producers.container-boilerplate" -}}
stdin: true
tty: true
{{- end -}}

{{- define "kafka-producers.env-boilerplate" -}}
- name: BROKER_IP
  value: "{{ .Values.defaults.env.brokerIp }}"
- name: BROKER_PORT
  value: "{{ .Values.defaults.env.brokerPort }}"
- name: REGISTRY_ADDR
  value: "{{ .Values.defaults.env.registryAddr }}"
{{- end -}}

{{- define "multicast.annotation" -}}
annotations:
  k8s.v1.cni.cncf.io/networks: kube-system/macvlan-conf
{{- end -}}
