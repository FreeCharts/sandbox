{{- define "freecharts.v1.service" -}}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Chart.Name }}

spec:
  selector:
    app: {{ .Chart.Name }}

  ports:
  {{- range .Values.ports }}
  - name: {{ .name }}
    protocol: TCP
    port: {{ .containerPort }}
  {{- end -}}
{{- end -}}
