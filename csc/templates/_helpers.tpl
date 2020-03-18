{{- define "multicast.annotation" -}}
annotations:
  k8s.v1.cni.cncf.io/networks: kube-system/macvlan-conf
{{- end -}}
