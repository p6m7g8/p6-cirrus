# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_sg_allow()
#
#  Depends:	 p6_aws
#>
######################################################################
p6_cirrus_sg_allow() {
    local sg_id="$1"
    local port="${2:-22}"

    local myip
    myip=$(p6_network_ip_public)

    p6_aws_cli_cmd ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port "$port" --cidr "$myip/32"

    p6_return_void
}

######################################################################
#<
#
# Function: str sg_id = p6_cirrus_sg_id_from_instance_id(instance_id)
#
#  Args:
#	instance_id -
#
#  Returns:
#	str - sg_id
#
#  Depends:	 p6_aws
#>
######################################################################
p6_cirrus_sg_id_from_instance_id() {
    local instance_id="$1"

    local sg_id
    sg_id=$(
        p6_aws_cli_cmd ec2 describe-instances \
            --instance-ids "$instance_id" |
            jq -r ".Reservations[0].Instances[0].SecurityGroups[0].GroupId"
    )

    p6_return_str "$sg_id"
}
