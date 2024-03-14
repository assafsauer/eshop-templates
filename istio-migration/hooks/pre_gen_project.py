 # Check namespace
{% for service in cookiecutter.components.values() if service.group == 'mesh' and service.type == 'istio' %}
{{ cookiecutter.update({"__istio_namespace": service.attributes.namespace }) }}
{% endfor %}

# Initialize variables to store the first matching link #
{% set ns = namespace(found_to=None, found_from=None) %}

# Iterate through links_to looking for the first match and store it #
{% for link in cookiecutter.links_to.values() %}
    {% if link.group == "mesh-backend" and ns.found_to is none %}
        {% set ns.found_to = link %}
    {% endif %}
{% endfor %}

# Iterate through links_from looking for the first match and store it #
{% for link in cookiecutter.links_from.values() %}
    {% if link.group == "mesh-backend" and ns.found_from is none %}
        {% set ns.found_from = link %}
    {% endif %}
{% endfor %}

# Update the cookiecutter context with the found links, if any #
{% if ns.found_to %}
    {{ cookiecutter.update({"__backend_to": ns.found_to}) }}
{% endif %}
{% if ns.found_from %}
    {{ cookiecutter.update({"__backend_from": ns.found_from}) }}
{% endif %}



