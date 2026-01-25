######################################################################
#<
#
# Function: p6_cirrus_lambda_invoke(function_name, ...)
#
#  Args:
#	function_name -
#	... - 
#
#>
######################################################################
p6_cirrus_lambda_invoke() {
    local function_name="$1"
    shift 1

    local dir=$(p6_transient_create "aws.lambda")
    local outfile="$dir/outfile"

    p6_aws_cli_cmd lambda invoke \
        --function-name $function_name \
        --log-type Tail $outfile \
        "$@" \
        >$dir/response

    if p6_file_exists "$outfile"; then
        p6_file_display "$outfile" | python -mjson.tool
        p6_file_display $dir/response | p6_filter_row_select "ExecutedVersion" | p6_filter_column_pluck 2 | p6_filter_double_quote_strip
        p6_file_display $dir/response | p6_filter_row_select "LogResult" | p6_filter_column_pluck 2 | p6_filter_double_quote_strip | python -m base64 -d
    fi

    p6_return_void
}
