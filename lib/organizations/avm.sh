# shellcheck shell=bash

######################################################################
#<
#
# Function: aws_account_id account_id = p6_cirrus_organizations_avm_account_create(account_name, account_email)
#
#  Args:
#	account_name -
#	account_email -
#
#  Returns:
#	aws_account_id - account_id
#
#>
######################################################################
p6_cirrus_organizations_avm_account_create() {
    local account_name="$1"
    local account_email="$2"

    local cas_id
    cas_id=$(p6_cirrus_organizations_account_create "$account_email" "$account_name")
    p6_cirrus_organizations_account_wait_for "$cas_id"

    local account_id
    account_id=$(p6_cirrus_organizations_account_id_from_account_name "$account_name")

    p6_return_aws_account_id "$account_id"
}

######################################################################
#<
#
# Function: bool bool = p6_cirrus_organizations_avm_account_create_wait_for(cas_id)
#
#  Args:
#	cas_id -
#
#  Returns:
#	bool - bool
#
#>
######################################################################
p6_cirrus_organizations_avm_account_create_wait_for() {
    local cas_id="$1"

    local bool=$(
        p6_run_retry \
            p6_cirrus_organizations_account_create_stop \
            p6_cirrus_organizations_account_create_status "$cas_id"
    )

    p6_return_bool "$bool"
}

######################################################################
#<
#
# Function: p6_cirrus_organizations_avm_account_create_stop(status, cas_id)
#
#  Args:
#	status -
#	cas_id -
#
#  Environment:	 ACTIVE FAILED
#>
######################################################################
p6_cirrus_organizations_avm_account_create_stop() {
    local status="$1"
    local cas_id="$2"

    [ x"$status" = x"FAILED" ] && p6_die "15" "$cas_id $status"
    [ x"$status" = x"ACTIVE" ] && break

    # continue
}

######################################################################
#<
#
# Function: str status = p6_cirrus_organizations_avm_account_create_status(car_id)
#
#  Args:
#	car_id -
#
#  Returns:
#	str - status
#
#>
######################################################################
p6_cirrus_organizations_avm_account_create_status() {
    local car_id="$1"

    local status=$(
        p6_aws_cli_cmd organizations describe-create-account-status \
            "$car_id" \
            --output text \
            --query "'CreateAccountStatus.State'"
    )

    p6_return_str "$status"
}
