 # Check namespace
{% for service in cookiecutter.components.values() if service.group == 'mesh' and service.type == 'istio' %}
{{ cookiecutter.update({"__istio_namespace": service.attributes.namespace }) }}
{% endfor %}

# Check if there is an existing link to Python backends
{% for link in cookiecutter.links_to.values() if link.group == "mesh-backend"  %}
{{ cookiecutter.update({"__backend_to": link }) }}
{% endfor %}

# Check if there is an existing link from Python backends
{% for link in cookiecutter.links_from.values() if link.group == "backend-mesh"  %}
{{ cookiecutter.update({"__backend_from": link }) }}
{% endfor %}

{% for component in cookiecutter.components.values() if component.group == "gateway" %}
{{ cookiecutter.update({"__ingress": component }) }}
{% endfor %}

