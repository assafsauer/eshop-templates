 # Check namespace
{% for service in cookiecutter.components.values() if service.group == 'mesh' and service.type == 'istio' %}
{{ cookiecutter.update({"__istio_namespace": service.attributes.namespace }) }}
{% endfor %}

 # Check if there is an existing link from
 {% for link in cookiecutter.links_to.values() if link.group == "mesh-backend" and link.type == 'istio-migration-python' %}
 {{ cookiecutter.update({"__backend_python_to": link }) }}
 {% endfor %}

 # Check if there is an existing link from
 {% for link in cookiecutter.links_from.values() if link.group == "mesh-backend" and link.type == 'istio-migration-python' %}
 {{ cookiecutter.update({"__backend_python_from": link }) }}
 {% endfor %}


