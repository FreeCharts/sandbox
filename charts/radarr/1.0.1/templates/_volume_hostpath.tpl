{{- define "freecharts.v1.volume.hostpath" -}}
  {{- if not .storage.hostPath -}}
    {{- fail "Storage - Expected non-empty <hostPath> on <hostPath> type" -}}
  {{- end -}}
  {{- $hostPath := tpl .storage.hostPath .rootCtx -}}

  {{- if not .rootCtx.Values.ixVolumes -}}
    {{- fail "Storage - Expected non-empty <ixVolumes> in values on <ixVolume> type" -}}
  {{- end -}}

  {{- if not (hasPrefix "/" $hostPath) -}}
    {{- fail "Storage - Expected <hostPath> to start with a forward slash [/] on <hostPath> type" -}}
  {{- end -}}

hostPath:
  path: {{ $hostPath }}

{{- end -}}
