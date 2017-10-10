# We assume we have those variables set:
#  - BASE_DIR
#  - UPSTREAM_DEPLOYMENT_DIR
#  - MAIN_DEPLOYMENT_FILE
# These are typicaly set by the '.envrc' config file

source "$BASE_DIR/conf/env-operations-layout.inc.bash"

function build_operations_arguments() {
    operations_arguments=()
    for op in "${local_operations[@]}"; do
        operations_arguments+=(-o "$BASE_DIR/operations/$op.yml")
    done

    for op in "${upstream_operations[@]}"; do
        operations_arguments+=(-o "$UPSTREAM_DEPLOYMENT_DIR/$op.yml")
    done
}

function bosh2_ro_invoke() {
    local verb=$1
    shift

    build_operations_arguments

    bosh2 "$verb" "$UPSTREAM_DEPLOYMENT_DIR/bosh.yml" \
        "${operations_arguments[@]}" \
        -l "$BASE_DIR/conf/env-depl-vars.yml" \
        "$@"
}

function bosh2_rw_invoke() {
    local verb=$1
    shift

    bosh2_ro_invoke "$verb" \
        --vars-store "$BASE_DIR/state/env-creds.yml" \
        --state "$BASE_DIR/state/env-infra-state.json" \
        "$@"
}
