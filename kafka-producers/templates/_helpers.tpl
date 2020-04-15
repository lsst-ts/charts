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


{{- define "multicast.annotation" -}}
annotations:
  k8s.v1.cni.cncf.io/networks: kube-system/macvlan-conf
{{- end -}}
