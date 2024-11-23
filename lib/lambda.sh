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
        p6_file_display $dir/response | awk '/ExecutedVersion/ { print $2 }' | sed -e 's,",,g'
        p6_file_display $dir/response | awk '/LogResult/ { print $2 }' | sed -e 's,",,g' | python -m base64 -d
    fi

    p6_return_void
}
