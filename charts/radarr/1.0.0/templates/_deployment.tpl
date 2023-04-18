{{- define "freecharts.v1.deployment" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
        imagePullPolicy: IfNotPresent

        ports:
        {{- range .Values.ports }}
        - name: {{ .name }}
          containerPort: {{ .containerPort }}
        {{ end -}}

        {{- with .Values.healthcheck }}
        livenessProbe:
          httpGet:
            port: {{ .httpGet.port }}
            path: {{ .httpGet.path }}
            scheme: {{ .httpGet.scheme }}
          initialDelaySeconds: 10
          failureThreshold: 5
          successThreshold: 1
          timeoutSeconds: 5
          periodSeconds: 10
        readinessProbe:
          httpGet:
            port: {{ .httpGet.port }}
            path: {{ .httpGet.path }}
            scheme: {{ .httpGet.scheme }}
          initialDelaySeconds: 10
          failureThreshold: 5
          successThreshold: 2
          timeoutSeconds: 5
          periodSeconds: 10
        startupProbe:
          httpGet:
            port: {{ .httpGet.port }}
            path: {{ .httpGet.path }}
            scheme: {{ .httpGet.scheme }}
          initialDelaySeconds: 10
          failureThreshold: 60
          successThreshold: 1
          timeoutSeconds: 2
          periodSeconds: 5
        {{- end }}
{{- end -}}
