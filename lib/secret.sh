######################################################################
#<
#
# Function: p6_aws_svc_secretsmanager_get_secret(name)
#
#  Arguments:
#	name - The name of the secret or the full path of the secret
#
#  Environment:	 ARN
#>
######################################################################
p6_aws_svc_secretsmanager_secret_create() {
	local name="$1"
	local value="$2"

    p6_aws_cli_cmd secretsmanager \
		create-secret \
		--name "$name" \
		--secret-string "$value"
}
