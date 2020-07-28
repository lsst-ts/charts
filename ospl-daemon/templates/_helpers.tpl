{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "ospl-daemon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ospl-daemon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "multicast.annotation" -}}
annotations:
  k8s.v1.cni.cncf.io/networks: kube-system/macvlan-conf
{{- end -}}
