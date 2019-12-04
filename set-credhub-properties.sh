#!/bin/bash
echo Run the credhub login before running this script***********************
echo Usage: set-credhub-properties.sh <pks terraform dir> <credhub prefix>

cd $1
CREDHUB_PREFIX=$2

crehub set -n $CREDHUB_PREFIX/gcp_pks_master_sa_json -t value -v "$(terraform output -json | jq -r .pks_master_node_service_account_key.value | jq -c)"

crehub set -n $CREDHUB_PREFIX/opsman-ssh-pub -t value -v "$(terraform output -json | jq -r .ops_manager_ssh_public_key)"

credhub set -n /concourse/team-a/gcp-project-id -t value -v "$(terraform output -json | jq -r .project.value)"

credhub set -n /concourse/team-a/gcp-pks-master-sa -t value -v "$(terraform output -json | jq -r .pks_master_node_service_account_email.value)"

credhub set -n /concourse/team-a/gcp-pks-worker-sa -t value -v "$(terraform output -json | jq -r .pks_worker_node_service_account_email.value)"

credhub set -n /concourse/team-a/ops_manager_dns -t value -v "$(terraform output -json | jq -r .ops_manager_dns.value)"

credhub set -n /concourse/team-a/pks-api-fqdn -t value -v "$(terraform output -json | jq -r .pks_api_endpoint.value)"

#credhub set -n /concourse/team-a/ops_manager_dns -t value -v "$(terraform output -json | jq -r .ops_manager_dns.value)"

