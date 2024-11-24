# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_aws_svc_organizations_admin_delegate_register(account_id, service)
#
#  Args:
#	account_id -
#	service -
#
#>
######################################################################
p6_aws_svc_organizations_admin_delegate_register() {
    local account_id="$1"
    local service="$2"

    p6_aws_cli_cmd organizations register-delegated-administrator --account-id "$account_id" --service-principal "$service" || true

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_organizations_admin_delegate_deregister(account_id, service)
#
#  Args:
#	account_id -
#	service -
#
#>
######################################################################
p6_aws_svc_organizations_admin_delegate_deregister() {
    local account_id="$1"
    local service="$2"

    p6_aws_cli_cmd organizations deregister-delegated-administrator --account-id "$account_id" --service-principal "$service" || true

    p6_return_void
}

######################################################################
#<
#
# Function: p6_aws_svc_organization_services_disable(service)
#
#  Args:
#	service -
#
#>
######################################################################
p6_aws_svc_organization_services_disable() {
    local service="$1"

    p6_aws_cli_cmd organizations disable-aws-service-access --service-principal "$service" || true

    p6_return_void
}
