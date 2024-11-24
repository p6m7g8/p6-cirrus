######################################################################
#<
#
# Function: p6_cirrus_log_group_delete(log_group_name)
#
#  Args:
#	log_group_name -
#
#>
######################################################################
p6_cirrus_log_group_delete() {
    local log_group_name="$1"

    p6_aws_cli_cmd logs delete-log-group --log-group-name "$log_group_name"
}

######################################################################
#<
#
# Function: p6_cirrus_logs_groups_prefix_delete(prefix)
#
#  Args:
#	prefix -
#
#>
######################################################################
p6_cirrus_logs_groups_prefix_delete() {
    local prefix="$1"

    if p6_string_blank "$prefix"; then
        p6_error "prefix is required"
        return
    fi

    local log_group_names=$(p6_cirrus_logs_groups_list | awk -v prefix="$prefix" '$1 ~ prefix {print $2}')

    local log_group_name
    for log_group_name in $(p6_echo $log_group_names); do
        p6_cirrus_log_group_delete "$log_group_name"
    done

    p6_return_void
}
