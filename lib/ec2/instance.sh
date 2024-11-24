# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect(instance_id, key)
#
#  Args:
#	instance_id -
#	key -
#
#>
######################################################################
p6_cirrus_ec2_instance_connect() {
    local tag="$1"

    p6_macosx_osa_iterm_color_run "$tag" "p6_cirrus_ec2_connect \"$tag\""

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_allow(tag)
#
#  Args:
#	tag -
#
#>
######################################################################
p6_cirrus_ec2_instance_allow() {
    local tag="$1"

    local sg_id=$(p6_cirrus_ec2_sg_id_from_instance_tag "$tag")
    p6_cirrus_sg_allow "$sg_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_connect(tag)
#
#  Args:
#	tag -
#
#  Environment:	 HOME
#>
######################################################################
p6_cirrus_ec2_connect() {
  local tag="$1"

  local instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
  p6_cirrus_ec2_instance_connect "$instance_id" "$HOME/.ssh/$tag.pem"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect(instance_id, key)
#
#  Args:
#	instance_id -
#	key -
#
#>
######################################################################
p6_cirrus_ec2_instance_connect() {
  local instance_id="$1"
  local key="$2"

  p6_aws_cli_cmd ec2-instance-connect ssh --instance-id $instance_id --private-key-file $key

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect_ssh_public_key_send(instance_id, user, key, az)
#
#  Args:
#	instance_id -
#	user -
#	key -
#	az -
#
#>
######################################################################
p6_cirrus_ec2_instance_connect_ssh_public_key_send() {
    local instance_id="$1"
    local user="$2"
    local key="$3"
    local az="$4"

    p6_aws_cli_cmd ec2-instance-connect send-ssh-public-key \
        --instance-id "$instance_id" \
        --instance-os-user "$user" \
        --ssh-public-key "$key" \
        --availability-zone "$az"

    p6_return_void
}
