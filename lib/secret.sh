######################################################################
#<
#
# Function: p6_cirrus_secretsmanager_secret_create(name, value)
#
#  Args:
#	name -
#	value -
#
#>
######################################################################
p6_cirrus_secretsmanager_secret_create() {
	local name="$1"
	local value="$2"

    p6_aws_cli_cmd secretsmanager \
		create-secret \
		--name "$name" \
		--secret-string "$value"
}
