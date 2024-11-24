# shellcheck shell=bash

######################################################################
#<
#
# Function: str key_file_priv_target = p6_cirrus_ec2_keypair_import()
#
#  Returns:
#	str - key_file_priv_target
#
#>
######################################################################
p6_cirrus_ec2_keypair_import() {
    local key_file_priv_target="$1"

    local key_file_pub="$key_file_priv_target.pub"

    p6_ssh_key_make "$key_file_priv_target"

    p6_aws_cli_cmd ec2 import-key-pair \
        --key-name "$key_file_priv_target" \
        --public-key-material fileb://$key_file_pub

    p6_return_str "$key_file_priv_target"
}
