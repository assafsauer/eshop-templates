#!/bin/sh

script_path="$(dirname "$0")"

if [ -z "$1" ]; then
    output_path="$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}"
else
    output_path="$script_path/$1"
fi

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update


helm template "{{ cookiecutter.component.name }}" istio/gateway  \
--namespace "{{ cookiecutter.__istio_namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values-gateway.yaml" \
> "$output_path/istio-gateway.yaml" || exit 1
 

 


