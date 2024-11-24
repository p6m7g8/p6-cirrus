# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cirrus_configservice_organization_service_enable()
#
#>
######################################################################
p6_cirrus_configservice_organization_service_enable() {

    p6_cirrus_organization_services_enable config.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_organization_service_disable()
#
#>
######################################################################
p6_cirrus_configservice_organization_service_disable() {

    p6_cirrus_organization_services_disable config.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_admin_delegate_register(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_configservice_admin_delegate_register() {
    local account_id="$1"

    p6_cirrus_organizations_admin_delegate_register "$account_id" "config.amazonaws.com"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_admin_delegate_deregister(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_configservice_admin_delegate_deregister() {
    local account_id="$1"

    p6_cirrus_organizations_admin_delegate_deregister "$account_id" "config.amazonaws.com"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_from_management_on(account_id, region)
#
#  Args:
#	account_id -
#	region -
#
#>
######################################################################
p6_cirrus_configservice_from_management_on() {
    local account_id="$1"
    local region="$2"

    p6_cirrus_configservice_organization_service_enable
    p6_cirrus_configservice_admin_delegate_register "$account_id"
    p6_cirrus_configservice_aggregation_authorization_put "$account_id" "$region"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_configservice_from_management_off(account_id, region)
#
#  Args:
#	account_id -
#	region -
#
#>
######################################################################
p6_cirrus_configservice_from_management_off() {
    local account_id="$1"
    local region="$2"

    p6_cirrus_configservice_aggregation_authorization_delete "$account_id" "$region"
    p6_cirrus_configservice_admin_delegate_deregister "$account_id"
    p6_cirrus_configservice_organization_service_disable

    p6_return_void
}
