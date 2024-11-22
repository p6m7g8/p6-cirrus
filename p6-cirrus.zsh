######################################################################
#<
#
# Function: p6df::modules::p6cirrus::init()
#
#  Depends:	 p6_bootstrap
#  Environment:	 P6_DFZ_SRC_ORIGINAL_DIR
#>
######################################################################
p6df::modules::p6-cirrus::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6_return_void
}