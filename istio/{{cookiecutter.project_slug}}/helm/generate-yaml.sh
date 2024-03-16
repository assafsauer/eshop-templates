#!/bin/sh

script_path="$(dirname "$0")"

if [ -z "$1" ]; then
    output_path="$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}"
else
    output_path="$script_path/$1"
fi

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update


helm template "{{ cookiecutter.component.name }}" istio/istiod  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values-control.yaml" \
> "$output_path/istio-control.yaml" || exit 1


helm template "{{ cookiecutter.component.name }}"  istio/base  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "{{ cookiecutter.technical.chart_version }}" \
-f "$script_path/helm-values-base.yaml" \
> "$output_path/istio-base.yaml" || exit 1

{%- if cookiecutter.component.attributes.kiali %}

helm repo add kiali https://kiali.org/helm-charts
helm repo update

helm template "{{ cookiecutter.component.name }}"  kiali/kiali-server  \
--namespace "{{ cookiecutter.component.attributes.namespace }}" \
--version "1.81.0" \
-f "$script_path/helm-values-kiali.yaml" \
> "$output_path/istio-kiali.yaml" || exit 1

{%- endif %}
 




