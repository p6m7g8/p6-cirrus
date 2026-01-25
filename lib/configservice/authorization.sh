# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_configservice_aggregation_authorization_put(account_id, region)
#
#  Args:
#	account_id -
#	region -
#
#>
######################################################################
p6_cirrus_configservice_aggregation_authorization_put() {
    local account_id="$1"
    local region="$2"

    p6_aws_cli_cmd configservice put-aggregation-authorization --authorized-account-id "$account_id" --authorized-aws-region "$region"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_aggregation_authorization_delete(account_id, region)
#
#  Args:
#	account_id -
#	region -
#
#>
######################################################################
p6_cirrus_configservice_aggregation_authorization_delete() {
    local account_id="$1"
    local region="$2"

    p6_aws_cli_cmd configservice delete-aggregation-authorization --authorized-account-id "$account_id" --authorized-aws-region "$region"

    p6_return_void
}
