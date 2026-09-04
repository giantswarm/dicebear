{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- $chart := printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 -}}
{{- /* A label value must end alphanumeric; the 63-char cut of a dev chart version
       (0.3.10-dev.<branch>.<date>.<time>.h<sha>) can end on "." or "-". */ -}}
{{- regexReplaceAll "[^A-Za-z0-9]+$" $chart "" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
app: {{ include "name" . | quote }}
{{ include "labels.selector" . }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "io.giantswarm.application.team" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Validated route version. Interpolated unescaped into the path-matching regular
expressions in httproute.yaml and httproutefilter.yaml, so a metacharacter (e.g.
the dot in "v1.2") would silently widen or break routing. values.schema.json
enforces the same pattern; this guard also holds when a consumer renders the
templates with schema validation skipped.
*/}}
{{- define "route.version" -}}
{{- $version := .Values.route.version | toString -}}
{{- if not (regexMatch "^[a-zA-Z0-9]+$" $version) -}}
{{- fail (printf "route.version (%v) must match ^[a-zA-Z0-9]+$" .Values.route.version) -}}
{{- end -}}
{{- $version -}}
{{- end -}}
