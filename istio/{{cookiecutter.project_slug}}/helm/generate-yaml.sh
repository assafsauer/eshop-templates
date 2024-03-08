#!/bin/sh

script_path="$(dirname "$0")"

if [ -z "$1" ]; then
    output_path="$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}"
else
    output_path="$script_path/$1"
fi

helm repo add istio https://istio-release.storage.googleapis.com/charts helm repo update

helm install istio-base istio/base -n istio-system

helm template "{{ cookiecutter.component.name }}" istio/istio-control/istio-discovery  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values.yaml" \
> "$output_path/istio-operator.yaml" || exit 1


helm template "{{ cookiecutter.component.name }}"  istio/gateway  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values.yaml" \
> "$output_path/istio-operator.yaml" || exit 1

helm template "{{ cookiecutter.component.name }}" istio/istio-control/istio-discovery  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values.yaml" \
> "$output_path/istio-operator.yaml" || exit 1
 

 


