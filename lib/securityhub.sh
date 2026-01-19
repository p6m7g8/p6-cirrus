# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_securityhub_organization_service_enable()
#
#>
######################################################################
p6_cirrus_securityhub_organization_service_enable() {

    p6_cirrus_organization_services_enable securityhub.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_organization_service_disable()
#
#>
######################################################################
p6_cirrus_securityhub_organization_service_disable() {

    p6_cirrus_organization_services_disable securityhub.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_admin_delegate_register(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_admin_delegate_register() {
    local account_id="$1"

    p6_cirrus_organizations_admin_delegate_register "$account_id" securityhub.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_admin_delegate_deregister(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_admin_delegate_deregister() {
    local account_id="$1"

    p6_cirrus_organizations_admin_delegate_deregister "$account_id" securityhub.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_admin_enable(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_admin_enable() {
    local account_id="$1"

    p6_aws_cli_cmd securityhub enable-organization-admin-account --admin-account-id $account_id || true

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_admin_disable(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_admin_disable() {
    local account_id="$1"

    p6_aws_cli_cmd securityhub disable-organization-admin-account --admin-account-id $account_id

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_members_remove()
#
#>
######################################################################
p6_cirrus_securityhub_members_remove() {

    local account_ids=$(p6_aws_svc_organizations_accounts_list_active | awk '{print $1}' | xargs)
    p6_aws_cli_cmd securityhub disassociate-members --account-ids "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_aggregator_delete()
#
#>
######################################################################
p6_cirrus_securityhub_aggregator_delete() {

    local arn=$(p6_aws_svc_securityhub_aggregator_arn)
    if ! p6_string_blank "$arn"; then
        p6_aws_cli_cmd securityhub delete-finding-aggregator --finding-aggregator-arn "$arn"
    fi

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_organization_config_update()
#
#>
######################################################################
p6_cirrus_securityhub_organization_config_update() {

    p6_aws_cli_cmd securityhub update-organization-configuration --organization-configuration ConfigurationType=LOCAL --no-auto-enable

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_disable()
#
#>
######################################################################
p6_cirrus_securityhub_disable() {

    p6_aws_cli_cmd securityhub disable-security-hub

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_from_delegated_off()
#
#>
######################################################################
p6_cirrus_securityhub_from_delegated_off() {

    p6_cirrus_securityhub_members_remove
    p6_cirrus_securityhub_aggregator_delete
    p6_cirrus_securityhub_organization_config_update
    p6_cirrus_securityhub_disable

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_from_management_on(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_from_management_on() {
    local account_id="$1"

    p6_cirrus_securityhub_organization_service_enable
    p6_cirrus_securityhub_admin_delegate_register "$account_id"
    p6_cirrus_securityhub_admin_enable "$account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_securityhub_from_management_off(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_securityhub_from_management_off() {
    local account_id="$1"

    p6_cirrus_securityhub_admin_delegate_deregister "$account_id"
    p6_cirrus_securityhub_organization_service_disable

    p6_return_void
}
