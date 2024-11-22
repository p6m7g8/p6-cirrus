######################################################################
#<
#
# Function: p6_cirrus_instance_allow(instance_id)
#
#  Args:
#	instance_id -
#
#  Depends:	 p6_aws
#>
######################################################################
p6_cirrus_instance_allow() {
    local instance_id="$1"

    local sg_id
    sg_id=$(p6_cirrus_sg_id_from_instance_id "$instance_id")

    p6_cirrus_sg_allow "$sg_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_instance_create(name, ami_id, [instance_type=t3a.nano], [user_data=], [subnet_type=infra])
#
#  Args:
#	name -
#	ami_id -
#	OPTIONAL instance_type - [t3a.nano]
#	OPTIONAL user_data - []
#	OPTIONAL subnet_type - [infra]
#
#  Depends:	 p6_aws p6_string
#  Environment:	 USER
#>
######################################################################
p6_cirrus_instance_create() {
    local name="$1"
    local ami_id="$2"
    local instance_type="${3:-t3a.nano}"
    local user_data="${4:-}"
    local subnet_type="${5:-infra}"

    p6_string_blank "$ami_id" && ami_id=$(p6_cirrus_amis_freebsd12_latest)
    p6_string_blank "$user_data" && user_data="--user-data=$user_data"

    local sg_id
    local sg_outbound_id
    local subnet_id
    local key_name
    key_name=$(p6_cirrus_key_pair_make "$USER")

    case $name in
    bastion)
        sg_id=$(p6_cirrus_sg_id_from_group_name "bastion-ssh")
        subnet_id=$(p6_cirrus_subnet_bastion_get)
        ;;
    *)
        sg_id=$(p6_cirrus_sg_id_from_group_name "vpc-ssh")
        subnet_id=$(p6_cirrus_subnet_"${subnet_type}"_get)
        ;;
    esac

    sg_outbound_id=$(p6_cirrus_sg_id_from_group_name "outbound")

    p6_aws_ec2_instances_run \
        --output json \
        --key-name "$key_name" \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --security-group-ids "$sg_id" "$sg_outbound_id" \
        --subnet-id "$subnet_id" \
        "$user_data" \
        --tag-specifications "'ResourceType=instance,Tags=[{Key=Name,Value=$name}]'"
}

######################################################################
#<
#
# Function: p6_cirrus_instance_bastion_create()
#
#>
######################################################################
p6_cirrus_instance_bastion_create() {

    p6_cirrus_instance_create "bastion"
}
