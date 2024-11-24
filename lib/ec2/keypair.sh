# shellcheck shell=bash

######################################################################
#<
#
# Function: str key_name = p6_cirrus_ec2_keypair_import()
#
#  Returns:
#	str - key_name
#
#  Environment:	 HOME
#>
######################################################################
p6_cirrus_ec2_keypair_import() {
    local key_name="$1"

    local prefix="$HOME/.ssh"
    local priv_key_path="$prefix/$key_name"
    local pub_key_path="$prefix/$key_name.pub"

    if ! p6_file_exists "$priv_key_path"; then
        p6_ssh_key_make "$priv_key_path" >/dev/null
        p6_aws_cli_cmd ec2 import-key-pair \
            --key-name "$key_name" \
            --public-key-material fileb://$pub_key_path >/dev/null
    fi

    p6_return_str "$key_name"
}
