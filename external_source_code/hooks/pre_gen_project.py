# Check if there is an existing link from ingress
{% for link in cookiecutter.links_from.values() if link.group == "gateway-backend" %}
{{ cookiecutter.update({"__ingress": link }) }}
{% endfor %}

# Check if there is an existing link from a relational DB
{% for link in cookiecutter.links_to.values() if link.group == "backend-rel_db" %}
{{ cookiecutter.update({"__rel_db": link }) }}
{% endfor %}

# Check if there is prometheus monitoring
{% for component in cookiecutter.links_from.values() if component.type == "prometheus-nodejs" %}
{{ cookiecutter.update({"__prometheus": component }) }}
{% endfor %}

# Check if there is rabbitmq link
{% for component in cookiecutter.links_to.values() if component.type == "nodejs-rabbitmq" %}
{{ cookiecutter.update({"__rabbitmq": component }) }}
{% endfor %}

# Check if there is MongoDB link
{% for component in cookiecutter.links_to.values() if component.type == "nodejs-mongodb" %}
{{ cookiecutter.update({"__mongodb": component }) }}
{% endfor %}