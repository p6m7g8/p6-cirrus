# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_cirrus_alfred_browser_console(pfunc)
#
#  Args:
#	pfunc -
#
#  Depends:	 p6_aws p6_run
#  Environment:	 HOME
#>
######################################################################
p6_cirrus_alfred_browser_console() {
    local pfunc="$1"

    local profile_dir
    local login_url

    p6_run_yield "p6_awsa_$pfunc"
    p6_aws_svc_sts_role_federation_assume "$pfunc"

    login_url=$(p6_aws_svc_sts_identity_broker_custom_login_url "$(p6_aws_env_shared_credentials_file_active)")
    profile_dir="$HOME/Library/Application Support/Google/Chrome/Profile p6cli-$pfunc"

    open -na 'Google Chrome' --args --incognito --user-data-dir="$profile_dir" "$login_url"

    p6_return_void
}
