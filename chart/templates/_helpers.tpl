{{/*
Expand the name of the chart.
*/}}
{{- define "ah.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ah.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ah.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ah.labels" -}}
helm.sh/chart: {{ include "ah.chart" . }}
{{ include "ah.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ah.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ah.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ah.redisLabels" -}}
helm.sh/chart: {{ include "ah.chart" . }}
{{ include "ah.redisSelectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ah.redisSelectorLabels" -}}
app.kubernetes.io/name: {{ include "ah.name" . }}-redis
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ah.postgresLabels" -}}
helm.sh/chart: {{ include "ah.chart" . }}
{{ include "ah.postgresSelectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ah.postgresSelectorLabels" -}}
app.kubernetes.io/name: {{ include "ah.name" . }}-redis
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ah.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ah.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ah.envValues" -}}
{{- $fullname := include "ah.fullname" . }}
{{- range $k, $v := .Values.app.config }}
- name: {{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- if .Values.ingress.enabled }}
- name: WEB_APP_URL
  value: "https://{{ .Values.ingress.hostname }}"
- name: WEBHOOK_URL
  value: "https://{{ .Values.ingress.hostname }}"
{{- end }}
{{- range $k, $v := .Values.app.credentials }}
- name: {{ $k }}
  valueFrom:
    secretKeyRef:
      name: "{{ $fullname }}"
      key: {{ include "ah.camelcase" $k }}
{{- end }}
- name: REDIS_HOST
  value: "{{ $fullname }}-redis"
- name: POSTGRES_HOST
  valueFrom:
    secretKeyRef:
      name: "{{ $fullname }}"
      key: dbHost
- name: POSTGRES_DATABASE
  valueFrom:
    secretKeyRef:
      name: "{{ $fullname }}"
      key: dbName
- name: POSTGRES_USERNAME
  valueFrom:
    secretKeyRef:
      name: "{{ $fullname }}"
      key: dbUser
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: "{{ $fullname }}"
      key: dbPassword
{{- end -}}
{{- define "ah.camelcase" -}}
{{- $string := camelcase (lower .) }}
{{- $count := len $string }}
{{- printf "%s%s" (lower (substr 0 1 $string) ) (substr 1 $count $string)}}
{{- end -}}