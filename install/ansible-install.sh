#!/usr/bin/env bash

# Copyright (c) 2026 didshwa
# Author: didshwa (Rachid)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://docs.ansible.com/projects/ansible | Github: https://github.com/ansible/ansible

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt install -y \
  curl \
  sudo \
  gnupg \
  ca-certificates \
  python3-pip \
  python3-full
msg_ok "Installed Dependencies"


msg_info "Installing Ansible"
$STD apt install -y ansible

echo -e "\n--- Vérification de l'installation ---"
if command -v ansible >/dev/null 2>&1; then
  VERSION=$(ansible --version | head -n 1)
  msg_ok "Installation réussie : $VERSION"
else
  msg_error "L'installation a échoué. Veuillez vérifier les logs ci-dessus."
fi

msg_ok "Félicitations ! Ansible est prêt à l'emploi sur Debian 13."

motd_ssh
customize
cleanup_lxc
