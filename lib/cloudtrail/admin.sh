# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_organization_service_enable()
#
#>
######################################################################
p6_aws_svc_cloudtrail_organization_service_enable() {

    p6_aws_svc_organization_services_enable cloudtrail.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_organization_service_disable()
#
#>
######################################################################
p6_aws_svc_cloudtrail_organization_service_disable() {

    p6_aws_svc_organization_services_disable cloudtrail.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_admin_delegate_register(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_aws_svc_cloudtrail_admin_delegate_register() {
    local account_id="$1"

    p6_aws_cli_cmd cloudtrail register-organization-delegated-admin --member-account-id "$account_id" || true

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_admin_delegate_deregister(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_aws_svc_cloudtrail_admin_delegate_deregister() {
    local account_id="$1"

    p6_aws_cli_cmd cloudtrail deregister-organization-delegated-admin --delegated-admin-account-id "$account_id" || true

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_from_management_on(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_aws_svc_cloudtrail_from_management_on() {
    local account_id="$1"

    p6_aws_svc_cloudtrail_organization_service_enable
    p6_aws_svc_cloudtrail_admin_delegate_register "$account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_cloudtrail_from_management_off(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_aws_svc_cloudtrail_from_management_off() {
    local account_id="$1"

    p6_aws_svc_cloudtrail_admin_delegate_deregister "$account_id"
    p6_aws_svc_cloudtrail_organization_service_disable

    p6_return_void
}
