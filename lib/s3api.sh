######################################################################
#<
#
# Function: false  = p6_cirrus_s3api_bucket_delete_with_versioned_objects(bucket, bucket)
#
#  Args:
#	bucket -
#	bucket -
#
#  Returns:
#	false - 
#	code - rc
#
#  Environment:	 EOF
#>
######################################################################
p6_cirrus_s3api_bucket_delete_with_versioned_objects() {
    local bucket="$1"

    if p6_string_blank "$bucket"; then
        p6_error "bucket is a required argument"
        p6_return_false
    else
        local cmd=$(_p6_cirrus_s3api_generate_delete_bucket_script "$bucket")
        local rc=$(p6_run_write_cmd "python -c $cmd")
        p6_return_code_as_code "$rc"
    fi
}

_p6_cirrus_s3api_generate_delete_bucket_script() {
    local bucket="$1"

    cat <<EOF
import boto3

session = boto3.Session()
s3 = session.resource(service_name='s3')

bucket = s3.Bucket("$bucket")
bucket.object_versions.delete()

bucket.delete()
EOF
}
