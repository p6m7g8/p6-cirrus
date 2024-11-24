# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_ec2_launch_template_create(lt_name, ami_id, [instance_type=t3a.nano], sg_ids, key_name)
#
#  Args:
#	lt_name -
#	ami_id -
#	OPTIONAL instance_type - [t3a.nano]
#	sg_ids -
#	key_name -
#
#  Environment:	 ASSOCIATE_PUBLIC_IP_ADDRESS DELETE_ON_TERMINATE IMAGE_ID INSTANCE_TYPE KEY_NAME SECURITY_GROUPS TAG_NAME
#>
######################################################################
p6_cirrus_ec2_launch_template_create() {
	local lt_name="$1"
	local ami_id="$2"
	local instance_type="${3:-t3a.nano}"
	local sg_ids="$4"
	local key_name="$5"

	[ -n "$user_data" ] && user_data="--user-data=$user_data"

	local launch_template_data=$(p6_aws_template_process "ec2/launch_configuration.json" \
			"ASSOCIATE_PUBLIC_IP_ADDRESS=true" \
			"SECURITY_GROUPS=$sg_ids" \
			"DELETE_ON_TERMINATE=true" \
			"IMAGE_ID=$ami_id" \
			"INSTANCE_TYPE=$instance_type" \
			"TAG_NAME=$lt_name" \
			"KEY_NAME=$key_name")

	p6_aws_cli_cmd ec2 create-launch-template "$lt_name" "'$launch_template_data'" --version-description "initial"
}
