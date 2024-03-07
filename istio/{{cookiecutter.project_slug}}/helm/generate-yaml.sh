#!/bin/sh

script_path="$(dirname "$0")"

if [ -z "$1" ]; then
    output_path="$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}"
else
    output_path="$script_path/$1"
fi

helm repo add stevehipwell https://stevehipwell.github.io/helm-charts/ || exit 1
helm repo update || exit 1

helm template "{{ cookiecutter.component.name }}" stevehipwell/istio-operator \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
--include-crds \
-f "$script_path/helm-values.yaml" \
> "$output_path/istio-operator.yaml" || exit 1


