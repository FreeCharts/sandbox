{{- define "freecharts.v1.volume.ixvolume" -}}
  {{- if not .storage.datasetName -}}
    {{- fail "Storage - Expected non-empty <datasetName> on <ixVolume> type" -}}
  {{- end -}}
  {{- $datasetName := tpl .storage.datasetName .rootCtx -}}

  {{- if not .rootCtx.Values.ixVolumes -}}
    {{- fail "Storage - Expected non-empty <ixVolumes> in values on <ixVolume> type" -}}
  {{- end -}}

  {{- $hostPath := "" -}}
  {{- $found := false -}}
  {{- range $idx, $normalizedHostPath := .rootCtx.Values.ixVolumes -}}
    {{- if eq $datasetName (base $normalizedHostPath.hostPath) -}}
      {{- $found = true -}}
      {{- $hostPath = $normalizedHostPath.hostPath -}}
    {{- end -}}
  {{- end -}}

  {{/* If we go over the ixVolumes and we dont find a match, fail */}}
  {{- if not $found -}}
    {{- $datasets := list -}}
    {{- range .rootCtx.Values.ixVolumes -}}
      {{- $datasets = mustAppend $datasets (base .hostPath) -}}
    {{- end -}}
    {{- fail (printf "Storage - Expected <datasetName> [%s] to exist on <ixVolumes> list, but list contained [%s] on <ixVolume> type" $datasetName (join ", " $datasets)) -}}
  {{- end -}}

  {{- if not (hasPrefix "/" $hostPath) -}}
    {{- fail "Storage - Expected normalized path from <ixVolumes> to start with a forward slash [/] on <ixVolume> type" -}}
  {{- end -}}

hostPath:
  path: {{ $hostPath }}

{{- end -}}
