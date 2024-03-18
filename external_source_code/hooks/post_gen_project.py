from stacktic import remove_file
from stacktic import encrypt_sops_files

if __name__ == '__main__':

    if "{{ cookiecutter.__rel_db }}" == "":
        remove_file('src/greeting-sql')
        remove_file('src/db')
        remove_file('config/postgresql')

    if "{{ cookiecutter.__prometheus }}" == "":
        remove_file('src/prometheus')

    if "{{ cookiecutter.__rabbitmq }}" == "":
        remove_file('src/greeting-rabbitmq')

    if "{{ cookiecutter.__mongodb }}" == "":
        remove_file('src/greeting-mongodb')

    if not {{ cookiecutter.component.attributes.network_policy }}:
        remove_file('k8s/deploy/base/network-policy.yaml')

    # SOPS Encryption
    if {{ cookiecutter.configuration.sops_enabled }}:
        encrypt_sops_files({{ cookiecutter._metadata.secret_files }}, '{{ cookiecutter.configuration.sops_age_recipients }}')
