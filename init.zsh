######################################################################
#<
#
# Function: p6df::modules::p6cirrus::init()
#
#  Depends:	 p6_bootstrap
#  Environment:	 P6_DFZ_SRC_ORIGINAL_DIR
#>
######################################################################
p6df::modules::p6cirrus::init() {

  local dir="$P6_DFZ_SRC_P6M7G8_DIR/p6cirrus"

  p6_bootstrap "$dir"
}
