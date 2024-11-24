# shellcheck shell=bash
######################################################################
#<
#
# Function: p6_cirrus_cloudtrail_trail_logging_start(prefix)
#
#  Args:
#	prefix -
#
#>
######################################################################
p6_cirrus_cloudtrail_trail_logging_start() {
  local prefix="$1"

  local trail_arn=$(p6_aws_svc_cloudtrail_trail_arns "$prefix")
  p6_aws_cli_cmd cloudtrail start-logging --name "$trail_arn"

  p6_return_void
}

######################################################################
#<
#
# Function: p6_cirrus_cloudtrail_trail_delete(prefix)
#
#  Args:
#	prefix -
#
#>
######################################################################
p6_cirrus_cloudtrail_trail_delete() {
  local prefix="$1"

  local trail_arn=$(p6_aws_svc_cloudtrail_trail_arns)
  p6_aws_cli_cmd cloudtrail delete-trail --name "$trail_arn"

  p6_return_void
}
