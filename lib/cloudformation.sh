# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_aws_cloudformation_stack_delete(stack_name)
#
#  Args:
#	stack_name -
#
#>
######################################################################
p6_aws_cloudformation_stack_delete() {
	local stack_name="$1"

	p6_aws_cli_cmd cloudformation delete-stack --stack-name "$stack_name"

	p6_return_void
}
