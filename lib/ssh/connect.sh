# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_ssh_connect_public()
#
#  Depends:	 p6_aws p6_msg p6_remote
#>
######################################################################
p6_cirrus_ssh_connect_public() {
  local tag="$1"

  local instance_id
  instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")

  cli="aws ec2-instance-connect ssh --instance-id $instance_id --private-key-file ~/.ssh/$tag"

  p6_msg "$cli"
  p6_macosx_osa_iterm_color_run "$tag" "p6_remote_ssh_do \"$cli\""

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ssh_connect_jump(tag)
#
#  Args:
#	tag -
#
#  Depends:	 p6_aws p6_msg p6_remote
#>
######################################################################
p6_cirrus_ssh_connect_jump() {
  local tag="$1"

  local bastion_instance_id
  local bastion_host
  local bastion_ami_name
  local bastion_user
  bastion_instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "Bastion")
  bastion_host=$(p6_aws_svc_ec2_instance_public_ip "$bastion_instance_id")
  bastion_ami_name=$(p6_aws_svc_ec2_ami_name_from_instance_id "$bastion_instance_id")
  bastion_user=$(p6_aws_svc_ec2_user_from_ami_name "$bastion_ami_name")

  p6_aws_svc_ec2_instance_connect_ssh_public_key_send "$bastion_instance_id"

  local instance_id
  local host
  instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
  host=$(p6_aws_svc_ec2_instance_private_ip "$instance_id")

  local rcli
  local cli
  rcli="ssh -t -i .ssh/private-bastion.pem $host"
  cli="ssh -A -t $bastion_user@$bastion_host \"$rcli\""

  p6_msg "$cli"
  p6_remote_ssh_do "$cli"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ssh_connect_private(tag)
#
#  Args:
#	tag -
#
#  Depends:	 p6_msg p6_remote
#>
######################################################################
p6_cirrus_ssh_connect_private() {
  local tag="$1"

  local instance_id
  instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
  local host
  host=$(p6_aws_svc_ec2_instance_private_ip "$instance_id")

  cli="mssh $host"

  p6_msg "$cli"
  p6_remote_ssh_do "$cli"

  p6_return_void
}
