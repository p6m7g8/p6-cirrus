# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_cirrus_cloudtrail_logging_start()
#
#>
######################################################################
p6_cirrus_cloudtrail_logging_start() {

  local trail_arn=$(p6_aws_svc_cloudtrail_trail_arns)
  p6_aws_svc_cloudtrail_trail_logging_start "$trail_arn"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_cloudtrail_trail_delete()
#
#>
######################################################################
p6_cirrus_cloudtrail_trail_delete() {

  local trail_arn=$(p6_aws_svc_cloudtrail_trail_arns)
  p6_aws_svc_cloudtrail_trail_logging_start "$trail_arn"

  p6_return_void
}
