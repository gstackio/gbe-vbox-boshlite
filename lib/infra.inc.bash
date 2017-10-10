# We assume we have those variables set:
#  - BASE_DIR
#  - UPSTREAM_DEPLOYMENT_DIR
#  - MAIN_DEPLOYMENT_FILE
# These are typicaly set by the '.envrc' config file

source "$BASE_DIR/conf/env-operations-layout.inc.bash"
DEPL_DIR=$BASE_DIR
source "$BASE_DIR/lib/common.inc.bash"

function bosh2_ro_invoke() {
    local verb=$1
    shift

    build_operations_arguments

    bosh2 "$verb" "$MAIN_DEPLOYMENT_FILE" \
        "${operations_arguments[@]}" \
        "$@" \
        --vars-file "$BASE_DIR/conf/env-depl-vars.yml"
}

function bosh2_rw_invoke() {
    local verb=$1
    shift

    bosh2_ro_invoke "$verb" \
        --vars-store "$BASE_DIR/state/env-creds.yml" \
        --state "$BASE_DIR/state/env-infra-state.json" \
        "$@"
}
