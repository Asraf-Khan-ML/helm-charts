{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "sf-archival.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sf-archival.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sf-archival.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "sf-archival.labels" -}}
app.kubernetes.io/name: {{ include "sf-archival.name" . }}
helm.sh/chart: {{ include "sf-archival.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
To get api version for HPA
*/}}
{{- define "autoscaling.apiVersion" -}}
   {{- if .Capabilities.APIVersions.Has "autoscaling/v2" -}}
      {{- print "autoscaling/v2" -}}
   {{- else -}}
     {{- print "autoscaling/v2beta2" -}}
   {{- end -}}
{{- end -}}

{{/*
To get api version for cronJob
*/}}
{{- define "batch.apiVersion" -}}
   {{- if .Capabilities.APIVersions.Has "batch/v1" -}}
      {{- print "batch/v1" -}}
   {{- end -}}
{{- end -}}