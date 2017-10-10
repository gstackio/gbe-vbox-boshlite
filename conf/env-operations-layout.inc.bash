# These operations files are relative to the 'operations' subdirectory here in
# this project. The '.yml' extension is implied.
local_operations=(
)
# These operation files are relative to the UPSTREAM_DEPLOYMENT_DIR set in
# the '.envrc' config file. The '.yml' extension is implied.
upstream_operations=(
    virtualbox/cpi
    virtualbox/outbound-network
    bosh-lite
    bosh-lite-runc
    jumpbox-user
)
