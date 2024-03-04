#!/bin/sh

script_path=$(dirname "$0")

if [ -z "$1" ]; then
output_path=$script_path/../../k8s/deploy/base/{{ cookiecutter.component.name }}
else
output_path=$script_path/$1
fi

helm template {{ cookiecutter.component.name }} istio/istio-operator \
--namespace {{ cookiecutter.component.attributes.namespace }} \
--version {{ cookiecutter.technical.chart_version }} \
--include-crds \
-f $script_path/helm-values.yaml \
> $output_path/istio-operator.yaml

