#!/bin/sh

script_path="$(dirname "$0")"

if [ -z "$1" ]; then
    output_path="$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}"
else
    output_path="$script_path/$1"
fi

helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update


helm template "{{ cookiecutter.component.name }}" vmware-tanzu/velero \
--namespace "{{ cookiecutter.__istio_namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values-gateway.yaml" \
> "$output_path/velero.yaml" || exit 1
 

 


