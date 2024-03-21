from stacktic import encrypt_sops_files
from stacktic import remove_file

if __name__ == '__main__':


    # SOPS Encryption
    if {{ cookiecutter.configuration.sops_enabled }}:
        encrypt_sops_files({{ cookiecutter._metadata.secret_files }}, '{{ cookiecutter.configuration.sops_age_recipients }}')
