# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect_with_key()
#
#  Environment:	 HOME
#>
######################################################################
p6_cirrus_ec2_instance_connect_with_key() {
    local tag="$1"
    local key="${2:-$HOME/.ssh/$tag}"

    local instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
    p6_macosx_osa_iterm_color_run "$tag" "p6_aws_cli_cmd ec2-instance-connect ssh --instance-id $instance_id --private-key-file $key"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect(tag)
#
#  Args:
#	tag -
#
#>
######################################################################
p6_cirrus_ec2_instance_connect() {
    local tag="$1"

    local instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
    p6_macosx_osa_iterm_color_run "$tag" "p6_aws_cli_cmd ec2-instance-connect ssh --instance-id $instance_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_ec2_instance_connect_ssh_public_key_send(tag, [key=$HOME/.ssh/$tag])
#
#  Args:
#	tag -
#	OPTIONAL key - [$HOME/.ssh/$tag]
#
#  Environment:	 HOME
#>
######################################################################
p6_cirrus_ec2_instance_connect_ssh_public_key_send() {
    local tag="$1"
    local key="${2:-$HOME/.ssh/$tag}"

    local instance_id=$(p6_aws_svc_ec2_instance_id_from_name_tag "$tag")
    local ami_name=$(p6_aws_svc_ec2_ami_name_from_instance_id "$instance_id")
    local user=$(p6_aws_svc_ec2_user_from_ami_name "$ami_name")
    local az=$(p6_aws_svc_ec2_availability_zone "$instance_id")

    p6_aws_cli_cmd ec2-instance-connect send-ssh-public-key \
        --instance-id "$instance_id" \
        --instance-os-user "$user" \
        --ssh-public-key "$key" \
        --availability-zone "$az"

    p6_return_void
}

######################################################################
#<
#
# Function: stream  = p6_cirrus_ec2_instance_create(instance_name, [vpc_name=p6-lz-sandbox/P6LzVpc/VPC], [ami_name=FreeBSD 15.0-CURRENT-arm64-20241121 small UFS], [subnet_type_or_id=Private], [sg_name=p6-lz-sg-default], [instance_type=t4g.nano], [user_data=])
#
#  Args:
#	instance_name -
#	OPTIONAL vpc_name - [p6-lz-sandbox/P6LzVpc/VPC]
#	OPTIONAL ami_name - [FreeBSD 15.0-CURRENT-arm64-20241121 small UFS]
#	OPTIONAL subnet_type_or_id - [Private]
#	OPTIONAL sg_name - [p6-lz-sg-default]
#	OPTIONAL instance_type - [t4g.nano]
#	OPTIONAL user_data - []
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_cirrus_ec2_instance_create() {
    local instance_name="$1"
    local vpc_name="${2:-p6-lz-sandbox/P6LzVpc/VPC}"
    local ami_name="${3:-FreeBSD 15.0-CURRENT-arm64-20241121 small UFS}"
    local subnet_type_or_id="${4:-Private}"
    local sg_name="${5:-p6-lz-sg-default}"
    local instance_type="${6:-t4g.nano}"
    local user_data="${7:-}"

    local key_name=$(p6_cirrus_ec2_keypair_import "$instance_name")
    local ami_id=$(p6_aws_svc_ec2_ami_find_id "$ami_name")
    local vpc_id=$(p6_aws_svc_ec2_vpc_id_from_vpc_name "$vpc_name")
    local subnet_id=$(p6_aws_svc_ec2_subnet_get "$subnet_type_or_id" "$vpc_id")
    local sg_id=$(p6_aws_svc_ec2_sg_id_from_sg_tag "$sg_name" "$vpc_id")

    p6_aws_cli_cmd ec2 run-instances \
        --output json \
        --key-name "$key_name" \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --security-group-ids "$sg_id" \
        --subnet-id "$subnet_id" \
        --tag-specifications "'ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]'"
        # --user-data "$user_data" \

    p6_return_stream
}
