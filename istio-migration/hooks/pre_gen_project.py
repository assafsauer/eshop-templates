{% for service in cookiecutter.components.values() if service.group == 'mesh' and service.type == 'istio' %}
{{ cookiecutter.update({"__istio_namespace": service.attributes.namespace }) }}
{% endfor %}


# define components for links from adn to

{% set backend_to = [] %}
{% set backend_from = [] %}

{# Iterate through links_to looking for connections from components in the backend group #}
{% for link_name, link in cookiecutter.links_to.items() %}
    {% if cookiecutter.components[link.component].group == 'backend' %}
        {% do backend_to.append(link.component) %}
    {% endif %}
{% endfor %}

{# Iterate through links_from looking for connections to components in the backend group #}
{% for link_name, link in cookiecutter.links_from.items() %}
    {% if cookiecutter.components[link.component].group == 'backend' %}
        {% do backend_from.append(link.component) %}
    {% endif %}
{% endfor %}

{# Update the cookiecutter context with the identified components #}
{{ cookiecutter.update({"__backend_to": backend_to, "__backend_from": backend_from}) }}
