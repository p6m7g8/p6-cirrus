# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_aws_svc_organization_services_enable(service)
#
#  Args:
#	service -
#
#>
######################################################################
p6_aws_svc_organization_services_enable() {
    local service="$1"

    p6_aws_cli_cmd organizations enable-aws-service-access --service-principal "$service"

    p6_return_void
}
