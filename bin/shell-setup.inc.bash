bosh2 -e "$(bosh2 int "$BASE_DIR/conf/env-depl-vars.yml" --path /internal_ip)" \
    --ca-cert <(bosh2 int "$BASE_DIR/state/env-creds.yml" --path /director_ssl/ca) \
    alias-env "$BOSH_ENVIRONMENT_ALIAS"
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=$(bosh2 int "$BASE_DIR/state/env-creds.yml" --path /admin_password)
