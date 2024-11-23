# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect()
#
#>
######################################################################
p6_cirrus_ec2_instance_connect() {
    local tag="$1"

    p6_macosx_osa_iterm_color_run "$tag" "p6_aws_svc_ec2_connect \"$tag\""

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

    local sg_id=$(p6_aws_svc_ec2_sg_id_from_instance_tag "$tag")
    p6_cirrus_sg_allow "$sg_id"

    p6_return_void
}
