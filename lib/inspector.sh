# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_cirrus_inspector_organization_service_enable()
#
#>
######################################################################
p6_cirrus_inspector_organization_service_enable() {

    p6_cirrus_organization_services_enable inspector2.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_organization_service_disable()
#
#>
######################################################################
p6_cirrus_inspector_organization_service_disable() {

    p6_cirrus_organization_services_disable inspector2.amazonaws.com

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_admin_delegate_register(da_account_id)
#
#  Args:
#	da_account_id -
#
#>
######################################################################
p6_cirrus_inspector_admin_delegate_register() {
    local da_account_id="$1"

    p6_cirrus_organizations_admin_delegate_register "$da_account_id" "inspector2.amazonaws.com"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_admin_delegate_deregister(da_account_id)
#
#  Args:
#	da_account_id -
#
#>
######################################################################
p6_cirrus_inspector_admin_delegate_deregister() {
    local da_account_id="$1"

    p6_cirrus_organizations_admin_delegate_deregister "$da_account_id" "inspector2.amazonaws.com"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_admin_delegated_enable(da_account_id)
#
#  Args:
#	da_account_id -
#
#>
######################################################################
p6_cirrus_inspector_admin_delegated_enable() {
    local da_account_id="$1"

    p6_aws_cli_cmd inspector2 enable-delegated-admin-account --delegated-admin-account-id "$da_account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_role_service_linked_create()
#
#>
######################################################################
p6_cirrus_inspector_role_service_linked_create() {

    p6_cirrus_iam_role_service_linked_create "inspector2.amazonaws.com"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_role_service_linked_delete()
#
#>
######################################################################
p6_cirrus_inspector_role_service_linked_delete() {

    p6_cirrus_iam_role_service_linked_delete "AWSServiceRoleForAmazonInspector2"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_member_associate(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_inspector_member_associate() {
    local account_id="$1"

    p6_aws_cli_cmd inspector2 associate-member --account-id "$account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_member_remove(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_inspector_member_remove() {
    local account_id="$1"

    p6_aws_cli_cmd inspector2 disassociate-member --account-id "$account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_resource_scanning_enable(account_ids)
#
#  Args:
#	account_ids -
#
#>
######################################################################
p6_cirrus_inspector_resource_scanning_enable() {
    local account_ids="$1"

    p6_aws_cli_cmd inspector2 enable --resource-types "EC2" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 enable --resource-types "ECR" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 enable --resource-types "LAMBDA" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 enable --resource-types "LAMBDA_CODE" --account-ids "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_resource_scanning_disable(account_ids)
#
#  Args:
#	account_ids -
#
#>
######################################################################
p6_cirrus_inspector_resource_scanning_disable() {
    local account_ids="$1"

    p6_aws_cli_cmd inspector2 disable --resource-types "EC2" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 disable --resource-types "ECR" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 disable --resource-types "LAMBDA" --account-ids "$account_ids"
    p6_aws_cli_cmd inspector2 disable --resource-types "LAMBDA_CODE" --account-ids "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_status_batch_get(account_ids)
#
#  Args:
#	account_ids -
#
#>
######################################################################
p6_cirrus_inspector_status_batch_get() {
    local account_ids="$1"

    p6_aws_cli_cmd inspector2 batch-get-account-status --account-ids "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_organization_members_enable()
#
#>
######################################################################
p6_cirrus_inspector_organization_members_enable() {

    local account_ids=$(p6_aws_svc_organizations_accounts_list_active_ids_as_list)
    local account_id
    for account_id in $(echo $account_ids); do
        p6_cirrus_inspector_member_associate "$account_id"
    done
    p6_cirrus_inspector_resource_scanning_enable "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_organization_members_disable()
#
#>
######################################################################
p6_cirrus_inspector_organization_members_disable() {

    local account_ids=$(p6_aws_svc_organizations_accounts_list_active_ids_as_list)
    local account_id
    for account_id in $(echo $account_ids); do
        p6_cirrus_inspector_member_remove "$account_id"
    done
    p6_cirrus_inspector_resource_scanning_disable "$account_ids"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_from_delegated_off()
#
#>
######################################################################
p6_cirrus_inspector_from_delegated_off() {

    p6_cirrus_inspector_organization_members_disable
    p6_cirrus_inspector_role_service_linked_delete

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_from_management_on(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_inspector_from_management_on() {
    local account_id="$1"

    p6_cirrus_inspector_organization_service_enable
    p6_cirrus_inspector_admin_delegate_register "$account_id"

    p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_inspector_from_management_off(account_id)
#
#  Args:
#	account_id -
#
#>
######################################################################
p6_cirrus_inspector_from_management_off() {
    local account_id="$1"

    p6_cirrus_inspector_admin_delegate_deregister "$account_id"
    p6_cirrus_inspector_organization_service_disable

    p6_return_void
}
